Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: "XOL" <xol@mail.ru>
To: "Mark Hatle" <fray@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re[2]: perl under eldk for ppc8xx
Mime-Version: 1.0
Date: Tue, 20 May 2003 20:23:34 +0400
In-Reply-To: <3ECA540C.2030506@mvista.com>
Reply-To: "XOL" <xol@mail.ru>
Content-Type: text/plain; charset=koi8-r
Message-Id: <E19I9tm-000Cq6-00.xol-mail-ru@f16.mail.ru>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


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
> If you are going to be building perl, you really need to do it "self-hosted",
> unless you are prepared to do significant modification to the perl build system.
>   Perl insists on being self-hosted compiled, it generates dynamic signal lists
> and other structures based on the machine performing the compile, obviously that
> doesn't work right in a cross compile situation.
>
> --Mark
>
> XOL wrote:
> > Hello.
> > I found out that eldk 2.1.0 whic I'm using has no perl.
> > Does anybody succeded to build perl for ppc8xx?
> > Can you give please some details. Probably you have binaries/rpm
> > Thank you. Xol.
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
