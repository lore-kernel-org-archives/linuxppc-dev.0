To: "MuthuGanesh M" <muthuganeshm@myw.ltindia.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PPC tool chain - uClibc 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 04 Jun 2004 17:41:22 +0530."
             <s0c0b448.016@EMAIL>
Date: Fri, 04 Jun 2004 18:15:10 +0200
Message-Id: <20040604161515.C28C6C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <s0c0b448.016@EMAIL> you wrote:
>
> I have taken the ELDK distro and using its tool chain.
> I have compiled uClibc also with the cross compiler.(ppc)
> After installing uClibc also the ppc cross compiler is refering glibc
> library only. How to change wrap ppc with uClibc...

The uCLibc project comes with some descriptions what needs to be done
to build a toolchain. See http://www.uclibc.org/toolchains.html

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"Ada is PL/I trying to be Smalltalk.                 - Codoso diBlini

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
