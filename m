Subject: RE: I2C RTC with MPC8xx?
Date: Wed, 29 Jan 2003 09:14:58 -0800
Message-ID: <AFA2797FA126FD46B8CD281F2809844E0197DB@taurus.primary.local>
From: "Keith Outwater" <Keith_Outwater@microvision.com>
To: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Stephen -

I am successfully using a DS1337 RTC with PPCBoot/U-Boot and a
linux-2.4.4-10-06 kernel from the Denx FTP site. I haven't gotten around
to submitting it, but let me know if you want the patch.

Keith

Keith Outwater
Sr. Staff Engineer
Microvision, Inc.
19910 N. Creek Parkway
Bothell, WA 98011


> -----Original Message-----
> From: Steven Scholz [mailto:steven.scholz@imc-berlin.de]
> Sent: Wednesday, January 29, 2003 4:38 AM
> To: Linuxppc-Embedded
> Subject: I2C RTC with MPC8xx?
>
>
>
> Hi there,
>
> what do I have to do to use an I2C RTC (like Dallas DS1337)
> within LinuxPPC?
>
> I know there're drivers for PPCBoot / U-Boot.
>
> But how could I access them from Linux?
>
> drivers/char/rtc_8xx.c is not suitable.
>
> Thanks,
>
> Steven
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
