From: "dong in kang" <dkang@east.isi.edu>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: Kernel parameters (Sandpoint X3 with Altimus MPC755)
Date: Tue, 20 May 2003 13:25:22 -0400
Message-ID: <001301c31ef4$cc2cafc0$45a97241@Minjoo>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <E19I9tm-000Cq6-00.xol-mail-ru@f16.mail.ru>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


 Hello,
 I'm trying to boot Montavista Linux kernel on Sandpoint X3 with Altimus
MPC755 CPU without bootloader and without using DINK32.
(I'm using BDI2000 with Metrowerks Codewarrior v.6.0).
I could read/write SDRAM before manually loading zImange.initrd.
However, I don't know how to setup kernel parameters and command lines.
What information should I put for kernel parameters? and where?

 Thanks,

 Dong-In

-----Original Message-----
From: owner-linuxppc-embedded@lists.linuxppc.org
[mailto:owner-linuxppc-embedded@lists.linuxppc.org] On Behalf Of XOL
Sent: Tuesday, May 20, 2003 12:24 PM
To: Mark Hatle
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re[2]: perl under eldk for ppc8xx



Hi.
I just made my first attempt to build perl 5_005_03.
I'm runnig linux 2.4.18 on MPC862 at 100MHz with 64M ram.
My filesystem is nfs mounted.
While running ./Configure I got nice core dump
saying something about lack of the memory.
So my next quiestion is
1. Does anyone has binaries or rpm?
2. Did someone build perl before on same system?

-----Original Message-----
From: Mark Hatle <fray@mvista.com>
To: XOL <xol@mail.ru>
Date: Tue, 20 May 2003 11:13:00 -0500
Subject: Re: perl under eldk for ppc8xx

>
>
> If you are going to be building perl, you really need to do it
> "self-hosted", unless you are prepared to do significant modification to
the perl build system.
>   Perl insists on being self-hosted compiled, it generates dynamic
> signal lists and other structures based on the machine performing the
> compile, obviously that doesn't work right in a cross compile
> situation.
>
> --Mark
>
> XOL wrote:
> > Hello.
> > I found out that eldk 2.1.0 whic I'm using has no perl. Does anybody
> > succeded to build perl for ppc8xx? Can you give please some details.
> > Probably you have binaries/rpm Thank you. Xol.
> >
> >
> >
> >
> >
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
