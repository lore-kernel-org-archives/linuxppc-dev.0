Subject: Re: [uClinux-dev] Need clarity on compiler & emulator usage
To: uClinux development list <uclinux-dev@uclinux.org>
Cc: linuxppc-embedded@lists.linuxppc.org,
	"uClinux development list" <uclinux-dev@uclinux.org>,
	uclinux-dev-bounces@uclinux.org
Message-ID: <OF9477A27F.D06A60A2-ON65256E4C.001BD8CA@lntinfotech.com>
From: "Thamarai Selvan" <Thamarai.Selvan@lntinfotech.com>
Date: Wed, 3 Mar 2004 10:55:49 +0530
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi ,

Is really Linux kernel gcc dependent? ;-(-
can u focus me on to one such code in the kernel?

has the gcc dependencies been forced into macros?
how can they be identified and can they be replaced ?
is there any specific header as such in which theses dependencies are
forced into?

with regards
Thamarai Selvan.G




                      "Bino George"
                      <bino@dlink.co.in>          To:       "uClinux development list"
                      Sent by:                     <uclinux-dev@uclinux.org>,
                      uclinux-dev-bounces@         <linuxppc-embedded@lists.linuxppc.org>
                      uclinux.org                 cc:       uclinux-dev@uclinux.org
                                                  Subject:  Re: [uClinux-dev] Need clarity on compiler &
                                                   emulator usage
                      03/01/2004 05:00 PM
                      Please respond to
                      uClinux development
                      list






Hi guys:
        I think you guys are little confused. The Linux Kernel is dependent
on Gcc. May be you can consider,  kernel hackers made use of gcc extensions
and knowledge of code generation. Please google for  Linux kernel + gcc
depedendent etc
    Your ICE is not worried about which elf file you are downloading. You
can download linux or boot loader or what ever you want.  The only thing
you
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

_______________________________________________
uClinux-dev mailing list
uClinux-dev@uclinux.org
http://mailman.uclinux.org/mailman/listinfo/uclinux-dev
This message was resent by uclinux-dev@uclinux.org


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
