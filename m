From: jwhit93@comcast.net
To: "MuthuGanesh M" <muthuganeshm@myw.ltindia.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PPC tool chain -  uClibc
Date: Fri, 04 Jun 2004 14:34:17 +0000
Message-Id: <060420041434.5094.40C08869000449D5000013E62200745672CCC79B07089906@comcast.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The most recent versions of uClibc no longer use a gcc wrapper,
instead you must recompile the toolchain with native
uClibc support.  The "buildroot" package automates much of
this process - see http://uclibc.org/toolchains.html for details.
The only hiccup I encountered missing headers which had
to be copied by hand, otherwise the Makefile takes care
of everything.

Also, Karim Yaghmour's book "Building Embedded Linux Systems"
gives some pointers on building toolchains in general and
uClibc in particular.

Regards,

John W


>
> Hello !
>
> I have taken the ELDK distro and using its tool chain.
> I have compiled uClibc also with the cross compiler.(ppc)
> After installing uClibc also the ppc cross compiler is refering glibc
> library only. How to change wrap ppc with uClibc...
> Any body please help me in solving this..
> Thanks in advance.
>
> Muthu ganesh.M
>
>
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
