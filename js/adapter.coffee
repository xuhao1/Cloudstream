num0=2
num1=2
series0=mkchart "#mach0","mach0",num0
series1=mkchart "#mach1","mach1",num1

add0 = (q,vm,x,y)->
	dataset=series
	if q==0
		dataset[vm].addPoint [x,sum0-count0 ],true,true
	else
		dataset[2*num0-vm-1].addPoint [x,-count1 ],true,true
