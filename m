Message-ID: <003601c2c784$e92ebcc0$870ca8c0@hercules>
From: "Frank Robbins" <Frank.Robbins@Analogue-Micro.com>
To: "Steven Scholz" <steven.scholz@imc-berlin.de>
Cc: <linuxppc-embedded@lists.linuxppc.org>
References: <3E37996A.40302@imc-berlin.de>
Subject: Re: problems with MPC8xx internal RTC !?
Date: Wed, 29 Jan 2003 10:55:15 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Just an a side note  has the errata for the RTC been fixed on the MPC855T it
is not fixed on the 860T  and I believe this feature is now missing on
future MPC 866T, 857 variants.

If not it will draw several mA from your battery and discharge it very
quickly

Frank

----- Original Message -----
From: "Steven Scholz" <steven.scholz@imc-berlin.de>
To: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Sent: Wednesday, January 29, 2003 9:05 AM
Subject: problems with MPC8xx internal RTC !?


>
> Hi there,
>
> I am using an MPC855T, external clocked with 16 MHz. Using the internal
PLLs it
> runs at 80MHz/40Mhz. An 32.768KHZ crystal is connected to clock the MPCs
> internal RTC. A battery is there as well.
>
> All seems to be fine. But I realized that the RTC runs too fast. It seems
to be
> releated to systems restarts.
>
> It tested. After 25 reboots the RTC is already SIX seconds ahead!!!
>
> rdate:   Wed Jan 29 10:03:58 2003
> date:    Wed Jan 29 10:04:04 CET 2003
> hwclock: Wed Jan 29 10:04:04 2003  0.000000 seconds
>
> Any ideas?
>
> Thanks,
>
> Steven
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
