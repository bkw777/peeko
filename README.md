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

The Jason Yang version with integrated level-shifting, 4-layer pcb.  
It looks pretty, and I've redrawn it to be even prettier, but I think this must be pretty abusive to both the RP2040 and the circuit under test so I don't really recommend it.  

Maybe swap out the BAV99 for BAV7004. Faster switching time, lower forward voltage.  
And maybe swap the 220 ohms for 470, 1k, even 4.7k if you don't need the full 100msps (only good to about 10mhz signals). Higher resistance means less current but also slower rise time.  

The good thing about this one is it can handle both higher than 5v and lower than 0v. But the higher the input voltage, the higher the current.  

5v input probably means about 4.5ma load on the target, and you're still overdriving the pico input to about 4v.  
12v input probably means about 36ma load on the target.  
-12v input probably means about 50ma, and passing about -1v to the pico input.  

I have not verified any of this for real.  

![](PCB/out/peeko_jy.jpg)
![](PCB/out/peeko_jy.top.jpg)
![](PCB/out/peeko_jy.inner2.jpg)
![](PCB/out/peeko_jy.bottom.jpg)
![](PCB/out/peeko_jy.svg)

# enclosures
Enclosures are not drawn yet.

# usage
For software, firmware, & directions, see [gusmanb/logicanalyzer](https://github.com/gusmanb/logicanalyzer)
