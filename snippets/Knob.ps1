enum LatchBoltState {
    Extended
    Retracted
}
enum RotationDirection {
    Clockwise
    CounterClockwise
}
# Define an extension method for the RotationDirection enum
$rotationDirectionOpposite = @{
    TypeName   = 'RotationDirection'
    MemberName = 'Opposite'
    MemberType = 'ScriptMethod'
    Value      = {
        if ($this -eq [RotationDirection]::Clockwise) {
            return [RotationDirection]::CounterClockwise
        }
        else {
            return [RotationDirection]::Clockwise
        }
    }
}
$memberExists = (Get-TypeData -TypeName $rotationDirectionOpposite.TypeName | Select-Object -ExpandProperty Members)?.ContainsKey($rotationDirectionOpposite.MemberName)
if (-not $memberExists) {
    Update-TypeData @rotationDirectionOpposite
}

class KnobInteractionResult {
    [Nullable[RotationDirection]] $InsideKnob
    [Nullable[RotationDirection]] $OutsideKnob
    [Nullable[LatchBoltState]] $LatchBolt

    KnobInteractionResult(
        [Nullable[RotationDirection]] $insideKnob, 
        [Nullable[RotationDirection]] $outsideKnob, 
        [Nullable[LatchBoltState]] $latchBolt
    ) {
        $this.InsideKnob = $insideKnob
        $this.OutsideKnob = $outsideKnob
        $this.LatchBolt = $latchBolt
    }
}

class PrivacyDoorKnob {
    hidden [boolean] $isButtonPressed = $false

    [boolean] IsButtonPressed() {
        return $this.isButtonPressed
    }

    [void] PressButton() {
        $this.isButtonPressed = $true
    }

    [KnobInteractionResult] TurnOutsideKnob([RotationDirection] $direction) {
        if ($this.isButtonPressed) {
            return [KnobInteractionResult]::new(
                $null,
                $null,
                [LatchBoltState]::Extended
            )
        }
        return [KnobInteractionResult]::new(
            $direction.Opposite(),
            $direction,
            [LatchBoltState]::Retracted
        )
    }
    
    [KnobInteractionResult] TurnInsideKnob([RotationDirection] $direction) {
        $this.isButtonPressed = $false
        return [KnobInteractionResult]::new(
            $direction,
            $direction.Opposite(),
            [LatchBoltState]::Retracted
        )
    }
}