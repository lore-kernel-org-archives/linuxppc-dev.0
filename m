Message-Id: <199902032031.PAA16572@post-ofc05.srv.cis.pitt.edu>
From: "Chad Sanner" <cmsst89+@pitt.edu>
To: <linuxppc-dev@lists.linuxppc.org>
Subject: X problems
Date: Wed, 3 Feb 1999 15:27:51 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




----------
> From: Chad Sanner <cmsst89+@pitt.edu>
> Subject: X problems
> Date: Wednesday, February 03, 1999 3:04 PM
> 
> I'm trying to configure X-windows for the first time and I'm having
> trouble.
> I've exhausted all the faq's on the net and my problem still hasen't been
> answered.
> 
> My video card is supported..ATI 264-VT4..Internal RAMDAC. 
> My monitor is not supported..HP D5298A..14 in monitor.
> 	When I ran diagnostics on the monitor from a win98 box before installing
> linux, my monitor's
> 	resoultion was set at 800x600 with a color depth of 32bpp. The Verticle
> Frenq. was at 75hz 
> 	and the Horzontal at 46.79khz.  It supported refreshe rates of 75, 72,
70,
> 60, 56, and 48.  All
> 	interlaced except 48hz.
> 
> When useing the "XConfigurator" with my Red Hat Linux 5.2 relase I choose
> my card and install the MACH 64 server.  When I come to the monitor
> selection, I choose Custom because my monitor is unlisted.  I'm then
asked
> to choose a horizontal sync range from this list:
> 				
> 			Standard VGA		640x480 @ 60hz
> 			Super VGA		800x600 @ 56hz
> 			8514 Compatible	1024x768 @ 87hz interlaced (no 800x600)
> 			Super VGA		1024x768 @ 87hz interlaced, 800x600 @ 56hz
> 			Extended Super VGA	800x600 @ 60hz, 640x480 @ 72hz
> 			Non-Interlaced SVGA	1024x768 @ 70hz, 800x600 @ 72hz
> 			High Frequency SVGA	1024x768 @ 70hz
> 			Monitor that can do	1280x1024 @ 60hz
> 			Monitor that can do	1280x1024 @ 74hz
> 			Monitor that can do	1280x1024 @ 76hz
> 
> I'm not sure which range I should select, however I did try the
> Non-Interlaced SVGA selection the first time I tried to configure it.
> 
> I was then asked to choose a vertical sync range from this list:
> 	
> 			50-70
> 			50-90
> 			50-100
> 			40-150
> 
> Again I'm not sure what to choose but judging from my diagnostics list,
the
> vert sync was at 75hz. so I chose the 50-90 range.
> 
> I was next asked for screen configuration and if I wanted my video card
> probed for default resoultion and color depth. When I chose the probe
> options I get this error:
> 
> 					X Error
> 		There was an error detecting the video ram on your card. 
> 		You should try configuring the video card manually.
> 
> I choose ok and then am asked for video ram on my card which I choose
4meg
> ideally matching my card.
> 
> I am then asked for a clock chip setting from this list:
> 
> 			No Clockchip Setting (recomended)
> 			Chrontel 8391
> 			ICD2061A and compatibles (ICS9161A, DCS2824)
> 			ICS2595
> 			ICS5342 (similar to SDAC, but not completely compatible)
> 			ICS5341
> 			S3 GenDAC (86C708) and ICS5300 (autodetected)
> 			S3 SDAC (86C716)
> 			STG1703 (autodetected)
> 			Sierra SC11412
> 			T1 3025 (autodetected)
> 			T1 3026 (autodetected)
> 			IBM RGB 51x/52x (autodetected)
> 
> I choose the recomended "No Clockchip Setting"
> 
> Then I move on to the Video modes selection and from it I choose:
640x480,
> 800x600, and 1024x768 for 8but, 16bit and 24bit.
> 
> I then issue the "startx" commandand when X starts, there is first a
bunch
> of horizontal lines racing across the screen and then the lines turn to
> blue.  I then use ctrl, alt, and backspace to get out of x windows.
> 
> One of the times I tried the configure I chose the IBM RGB clockchip
> setting and then issued the startx command and x started but everything
was
> duplicated 3 times.  The window borders would shake back and fourth
> extremely fast so I backed out of this too.
> 
> Is there any way I can configure x to run in my enviroment correctly?
> 
> Thanks,
> 	griffter
> 		93 93/93
> 

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
