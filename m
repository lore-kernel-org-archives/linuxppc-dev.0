Return-Path: <matt@genesi-usa.com>
Received: from mail.genesippc.com (mithrandir.softwarenexus.net [66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9F39067B77
	for <linuxppc-dev@ozlabs.org>; Sun, 23 Jul 2006 23:28:15 +1000 (EST)
From: "Matt Sealey" <matt@genesi-usa.com>
To: "'Segher Boessenkool'" <segher@kernel.crashing.org>
Subject: RE: AltiVec in the kernel
Date: Sun, 23 Jul 2006 15:28:02 +0200
Message-ID: <006701c6ae5b$d5e83620$7302a8c0@bakuhatsu.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <bb0f53dbee5c7240daf6855454eca028@kernel.crashing.org>
Cc: 'Olof Johansson' <olof@lixom.net>,
	'linuxppc-dev list' <linuxppc-dev@ozlabs.org>,
	'Paul Mackerras' <paulus@samba.org>
Reply-To: matt@genesi-usa.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> You could give Freevec a whole lot more exposure, to people 
> who might be more interested in it than the average glibc 
> user, by putting it into uClibc first.

[snip]

> You'll have to update uClibc's PowerPC port first though 
> (mostly just copying stuff from recent glibc) -- it seems the 
> libc AltiVec support (for handling setjmp() etc.) isn't in there yet.

I remember a discussion from one of the Gentoo guys wanting to do this
with libfreevec.

Getting into Gentoo, though, is not difficult. The problem with this
is Gentoo is one Linux distribution. I would be more impressed if code
was in Debian or Ubuntu considering their exhausting lead times on
producing new package trees and accepting new code :D

-- 
Matt Sealey <matt@genesi-usa.com>
Manager, Genesi, Developer Relations
