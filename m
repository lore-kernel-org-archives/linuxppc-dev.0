Message-ID: <000d01c3ff80$98d3a5d0$9264a8c0@SHUBHASHRI>
From: "Bino George" <bino@dlink.co.in>
To: "uClinux development list" <uclinux-dev@uclinux.org>,
	<linuxppc-embedded@lists.linuxppc.org>
Cc: <uclinux-dev@uclinux.org>
References: <OFE01E481D.BE779471-ON65256E4A.0022D7D1@lntinfotech.com>
Subject: Re: [uClinux-dev] Need clarity on compiler & emulator usage
Date: Mon, 1 Mar 2004 17:00:26 +0530
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi guys:
        I think you guys are little confused. The Linux Kernel is dependent
on Gcc. May be you can consider,  kernel hackers made use of gcc extensions
and knowledge of code generation. Please google for  Linux kernel + gcc
depedendent etc
    Your ICE is not worried about which elf file you are downloading. You
can download linux or boot loader or what ever you want.  The only thing you
have to do is , read and understand the ICE manual.
bino

----- Original Message -----
From: "Thamarai Selvan" <Thamarai.Selvan@lntinfotech.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Cc: <uclinux-dev@uclinux.org>
Sent: Monday, March 01, 2004 12:03 PM
Subject: [uClinux-dev] Need clarity on compiler & emulator usage


> hi all,
>
> I have a real strange question
> Let us take it specific on ppc architecture if needed
> what is the advantage of using GNU compiler as such?
> why not other compilers like Diab C compiler can be used?
> can we use vision ice emulators to download the image if not why?
> what is the advantage of using BDI2000?
> what are the constraints that prevent the usage of the above compiler and
> emulator?
>
> Thanks in before for all your inputs
>
> with regards
> Thamarai Selvan.G
>
>
>
> _______________________________________________
> uClinux-dev mailing list
> uClinux-dev@uclinux.org
> http://mailman.uclinux.org/mailman/listinfo/uclinux-dev
> This message was resent by uclinux-dev@uclinux.org


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
