To: "XOL" <xol@mail.ru>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Re[2]: perl under eldk for ppc8xx 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 20 May 2003 20:23:34 +0400."
             <E19I9tm-000Cq6-00.xol-mail-ru@f16.mail.ru>
Date: Wed, 21 May 2003 19:26:03 +0200
Message-Id: <20030521172609.05ED5C6162@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

in message <E19I9tm-000Cq6-00.xol-mail-ru@f16.mail.ru> you wrote:
>
> I just made my first attempt to build perl 5_005_03.
> I'm runnig linux 2.4.18 on MPC862 at 100MHz with 64M ram.
> My filesystem is nfs mounted.
> While running ./Configure I got nice core dump
> saying something about lack of the memory.
> So my next quiestion is
> 1. Does anyone has binaries or rpm?
> 2. Did someone build perl before on same system?

I have put a tarball with ppc_8xx binaries with perl-5.8.0 (built  on
a native MPC8xx system under ELDK-2.1.0) at
ftp://ftp.denx.de/pub/tmp/perl-5.8.0-ppc_8xx.tar.bz2

[FYI: I've built it on a TQM860L board with 64 MB  RAM  and  a  4  GB
harddisk on a PCMCIA adapter; the "make" took exactly 3 hours...]

Hope this helps.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
How come everyone's going so slow if it's called rush hour?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
