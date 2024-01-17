Describe 'A privacy doorknob' {
    Context 'when the push button is pressed' {
        Context 'when the user tries to turn the outside knob clockwise' {
            It 'should not turn the outside knob at all' {
                # Arrange
                . "$PSScriptRoot/Knob.ps1"
                $knob = New-Object 'PrivacyDoorKnob'
                $knob | Should -Not -Be $null
                $knob.PressButton()
            
                # Act
                $result = $knob.TurnOutsideKnob([RotationDirection]::Clockwise)
            
                # Assert
                $result.OutsideKnob | Should -Be $null
            }
            It 'should not turn the inside knob at all' {
                # Arrange
                . "$PSScriptRoot/Knob.ps1"
                $knob = New-Object 'PrivacyDoorKnob'
                $knob | Should -Not -Be $null
                $knob.PressButton()
            
                # Act
                $result = $knob.TurnOutsideKnob([RotationDirection]::Clockwise)
            
                # Assert
                $result.InsideKnob | Should -Be $null
            }
            It 'should not retract the latch bolt' {
                # Arrange
                . "$PSScriptRoot/Knob.ps1"
                $knob = New-Object 'PrivacyDoorKnob'
                $knob | Should -Not -Be $null
                $knob.PressButton()
            
                # Act
                $result = $knob.TurnOutsideKnob([RotationDirection]::Clockwise)
            
                # Assert
                $result.LatchBolt | Should -Be ([LatchBoltState]::Extended)
            }
        }
    }
	
    #         * when the user tries to turn the outside knob counterclockwise,
    #             * should not turn the inside knob at all.
    #             * should not retract the latch bolt.
    #         * when the user tries to turn the inside knob clockwise,
    #             * should pop the push button out.
    #             * should turn the inside knob clockwise.
    #             * should turn the outside knob counterclockwise.
    #             * should retract the latch bolt.
    #         * when the user tries to turn the inside knob counterclockwise,
    #             * should pop the push button out.
    #             * should turn the inside knob counterclockwise.
    #             * should turn the outside knob clockwise.
    #             * should retract the latch bolt.
}