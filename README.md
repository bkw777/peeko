# PEEKO

Alternate PCBs for [gusmanb/logicanalyzer](https://github.com/gusmanb/logicanalyzer)

![](PCB/out/peeko_with_level_shifter.top.jpg)
![](PCB/out/peeko_with_level_shifter.jpg)
![](PCB/out/peeko_with_level_shifter.b.jpg)

# peeko  

The order you solder the parts matters.  
Solder everything on the pico side first, but not the pico itself, just the pins, diode, resistor.  
Then flush cut the bottoms of the Pi pins, at least where the IDC connector will lay.  
Then solder the bottom side parts. No need to flush cut any.  
Lastly solder the Pico to the pins and flush-cut the tops.  

![](PCB/out/peeko.jpg)
![](PCB/out/peeko.2.jpg)
![](PCB/out/peeko.3.jpg)
![](PCB/out/peeko.top.jpg)
![](PCB/out/peeko.bottom.jpg)
![](PCB/out/peeko.svg)

# input level shifter
![](PCB/out/peeko_input_level_shifter.jpg)
![](PCB/out/peeko_input_level_shifter.top.jpg)
![](PCB/out/peeko_input_level_shifter.bottom.jpg)
![](PCB/out/peeko_input_level_shifter.svg)

# peeko_jy

The Jason Yang version with integrated level-shifting, 4-layer pcb  
This board clips the input signal to about 3v6 by a Schottky diode to 3v3 with a 220 ohm resistor on the input.  
This means it can possibly handle signals higher than 5.5v, but also means it pulls the circuit under test down to 3.6v or up to 0v pretty hard.  
If you don't need high speed, you can replace the resistors with higher values to reduce the load on the circuit under test. The higher the resistance, the better the seperation, but also the slower the transitions.  

![](PCB/out/peeko_jy.jpg)
![](PCB/out/peeko_jy.top.jpg)
![](PCB/out/peeko_jy.inner2.jpg)
![](PCB/out/peeko_jy.bottom.jpg)
![](PCB/out/peeko_jy.svg)

# enclosures
Enclosures are not drawn yet.

# usage
For software, firmware, & directions, see [gusmanb/logicanalyzer](https://github.com/gusmanb/logicanalyzer)
