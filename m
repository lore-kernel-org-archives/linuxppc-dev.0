Message-ID: <00b801c2a2c1$70bc9470$370da8c0@aman>
From: "Aman" <aman@mistralsoftware.com>
To: "Matt Porter" <porter@cox.net>
Cc: "linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
References: <000901c2a20b$23472400$370da8c0@aman> <20021212145243.A5263@home.com>
Subject: Re: NVRAM/RTC
Date: Fri, 13 Dec 2002 21:35:22 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Matt

This might be a very basic question. By porting what do you mean?. As of now
I copied the ebony bsp to different location and did changes to boot on the
custom board. Till now it was booting without any problem. Once I changed
the EBC configuration to configure some other FPGA ,bcos of which  linux
booting hangs at " Now Booting the kernel ".
I commented the ioremap of RTC, and the definitions of
ppc_md.set_rtc_time = todc_set_rtc_time;

ppc_md.get_rtc_time = todc_get_rtc_time;

 still the same problem. Should I hv to do something else also.

Thanking you in advance
regards
Aman


----- Original Message -----
From: "Matt Porter" <porter@cox.net>
To: "Aman" <aman@mistralsoftware.com>
Cc: "linuxppc embedded" <linuxppc-embedded@lists.linuxppc.org>
Sent: Friday, December 13, 2002 3:22 AM
Subject: Re: NVRAM/RTC


>
> On Thu, Dec 12, 2002 at 11:50:23PM +0530, Aman wrote:
> >
> > Hi All
> >
> > I have customized board , which has PPC 440GP as its processor. In this
> > board there is no NVRAM/RTC as in the 440GP evalkit. In the Rom monitor,
> > configuration related to it NVRAM/RTC has been removed. Because of this
> > changes in the rom monitor code, the linux image is hanging after " Now
> > Booting the Kernel". If  NVRAM/RTC EBC bank1 is enabled in rom monitor,
the
> > linux image is executing without any problem. Can anyone say , how to
> > disable the NVRAM/RTC option in the linux kernel.
>
> Are you trying to run an ebony image on this board?  Sounds like it,
> and that would be the wrong thing to do.  Make a new port, and
> in your <board>.c file, don't ioremap the RTC area (since you don't
> have one) and delete (or set NULL) all the time/nvram machdeps.
>
> Regards,
> --
> Matt Porter
> porter@cox.net
> This is Linux Country. On a quiet night, you can hear Windows reboot.
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
