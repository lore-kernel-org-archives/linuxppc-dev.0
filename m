Date: Thu, 20 Dec 2001 11:57:16 +0100
From: Marius Groeger <mag@sysgo.de>
Message-Id: <200112201057.fBKAvGW08553@dagobert.svc.sysgo.de>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Compile Penguin PPC for x386?
In-Reply-To: <20011212122102.B21676@cx258813-a.chnd1.az.home.com>
References: <20011212165819.D1790@borg.org> <20011212122102.B21676@cx258813-a.chnd1.az.home.com>
Reply-To: mag@sysgo.de
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In linux.ppc.embedded, Matt Porter wrote:
>
> No, the PPC MM changes in 2_4_devel rely on changes to the generic
> MM API that aren't yet in the kernel.org release.  You could modify
> the appropriate files in arch/i386/mm/ and include/asm-i386/ to match
> if you like.

Matt, do you know the origin of those changes? Are they an invention of the
linuxppc people, or part of the 2.5 tree? I'm asking because I'm afraid that
these changes might not make it into kernel.org release for a LONG time...

--
Marius Groeger        SYSGO Real-Time Solutions GmbH    www.sysgo.de
Software Engineering  Embedded and Real-Time Software   www.osek.de
mgroeger @ sysgo de   Germany                           www.elinos.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
