To: ADharankar@ATTBI.Com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Relocating PPCBoot into SRAM 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 16 Feb 2003 14:15:19 EST."
             <200302161415.19790.ADharankar@ATTBI.Com>
Date: Sun, 16 Feb 2003 20:48:03 +0100
Message-Id: <20030216194808.33949C5E20@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200302161415.19790.ADharankar@ATTBI.Com> you wrote:
> Hello!  Thanks for the nice reply!

You're welcome.

> To test the region of SDRAM where PPCBoot/U-Boot resides, how could
> a non-destructive test be implemented? Perhaps, would one way would be
> to do these test for that region of PPCBoot/U-Boot before it is
> relocated to SDRAM?

This is a good idea, especially since you also have to deal with  the
exception vectors...

> Some of the x86 PC BIOSs/Bootloaders/Monitors seem to be able to do
> a full/destructive memory test without a reboot. That is what seems
> to be appealing to for PPCBoot/U-Boot.

Did you check how U-Boot's POST routines  (especially  post/memory.c)
work?

Don't re-invent the wheel.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
See us @ Embedded World, Nuremberg, Feb 18-20, Hall 12.0 Booth 12-442

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
