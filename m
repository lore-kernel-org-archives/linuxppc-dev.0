Message-ID: <1154.81.193.61.199.1086982022.squirrel@alumni.deec.uc.pt>
In-Reply-To: 
     <0F48024310E5D6118D200002B3A440DB08B07A3D@zil01exm08.mcil.comm.mot.com
     >
References: 
    <0F48024310E5D6118D200002B3A440DB08B07A3D@zil01exm08.mcil.comm.mot.com>
Date: Fri, 11 Jun 2004 20:27:02 +0100 (WEST)
Subject: RE: U-Boot and kernel 2.6
From: "Ricardo DIz" <rdiz@alumni.deec.uc.pt>
To: "Meriin Michael-BMM063" <Meriin@motorola.com>
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks, I'll do that first thing Monday morning (currently on a 4-days
mini-vacations :) )

Regards,
Ricardo Diz

>
> Check the bd_t definition, it MUST be the same in u-boot and Linux
> platform definition.
> bd_t in Linux is defined in ppcboot.h
>
> Best Regards,
>      Michael Meriin
>
>
> -----Original Message-----
> From: owner-linuxppc-embedded@lists.linuxppc.org
> [mailto:owner-linuxppc-embedded@lists.linuxppc.org]On Behalf Of Ricardo
> DIz
> Sent: Wednesday, June 09, 2004 20:48
> To: linuxppc-embedded@lists.linuxppc.org
> Subject: U-Boot and kernel 2.6
>
>
>
> Hi,
>
> I'm trying to boot a custom 860T board using the latest kernel from
> linuxppc-2.5. The board is currently using a variation of an old version
> of U-Boot (0.2.0) along with a hacked 2.4.20 linux kernel version.
>
> My first aim is to boot a simple kernel and make it get to a shell. For
> that I compiled the kernel, but did not compiled u-boot with a recent
> version.
>
> When booting, the kernel got uncompressed, but then it resets! I presume
> the watchdog (which is enabled), is resetting the processor, so I guess
> booting just stalls. Was there any changes in the way parameters were
> received by the kernel since 2.4.20?
>
> Oh, I forgot to mention the compiler. I'm still using a gcc 2.95
> cross-compiler, altough I tried using a gcc 3.2 cross-compiler for the
> 8260 once, but got the same result.
>
> I followed a recent thread very similar to this, but that turned out to be
> just a matter of UART configuration, and I don't thinks this is the case.
>
> Any thoughts?
>
> Thanks in advance,
> Ricardo Diz
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
