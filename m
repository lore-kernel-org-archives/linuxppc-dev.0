From: "Ron Bianco" <ronb@junction.net>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: Sandpoint & random crashes?
Date: Mon, 11 Sep 2000 16:53:00 -0700
Message-ID: <000301c01c4b$6a7ac6d0$4d012ac7@warp-speed>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <39BD66B9.9A1A362F@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Another possible hardware related problem might be that the Dink monitor is not
programming the SDRAM controller with the right parameters for that DIMM module ( I assume
the sandpoint uses DIMMs ).
I'm not sure if the monitor reads the param data from the module's eeprom or is manually
configured and stored in CMOS ram.

Anyway, have you run any memory tests?

My 2 peso's worth, good luck.

Ron

> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Mark A.
> Greer
> Sent: Monday, September 11, 2000 4:12 PM
> To: Alex Shnitman
> Cc: linuxppc-embedded@lists.linuxppc.org
> Subject: Re: Sandpoint & random crashes?
>
>
>
> Alex Shnitman wrote:
>
> > Hi, Mark!
> > Today I think I noticed a very interesting consistency that might be
> > helpful. I haven't had the time to test it completely; I'll do it
> > tomorrow and post again. The thing is, there's a little green led on
> > the board saying "backup power" or something like that. If you turn
> > off the computer and the power supply, and leave it off for half a
> > minute or so, the led turns off. If you turn the computer on
> > afterwards and load the kernel, it loads init and you can work (until
> > it crashes). If you just reset the computer and load the kernel (after
> > uploading it via dink of course), init won't load.
> >
>
> This almost sounds like a hardware problem.  How old is your processor module?
> Remember this is a test platform for MOT SPS where they test out new processors,
> etc.  They may have given you an early rev board or processor or host bridge or...
> If you have an old one, you may want to ask for a newer one.
>
> I perused through /proc cat-ing files as well.  Haven't had any problems.  I'll
> keep an eye out.   Please let me/us know what you discover in the meantime.
>
> Thanks,
>
> Mark
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
