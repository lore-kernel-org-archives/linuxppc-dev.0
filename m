Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 2F34EDDF1A
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 Jul 2007 10:45:49 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: ARCH=ppc vs ARCH=powerpc
Date: Mon, 9 Jul 2007 02:34:14 +0200
References: <Pine.LNX.4.61.0707061706140.4792@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707061706140.4792@mtfhpc.demon.co.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707090234.14851.arnd@arndb.de>
Cc: Mark Fortescue <mark@mtfhpc.demon.co.uk>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Friday 06 July 2007, Mark Fortescue wrote:
> For me, the requirement is to keep support for the cards indicated in 
> arch/ppc/config/xxx_defconfig (as I have one that I might what to use with 
> linux) in the same way as they are supported in ARCH=ppc.

The one thing that is holding up the transition to arch/powerpc is lack
of people with access to the respective boards. If you have one board
that you care about, it would be good if you look into getting it moved
over. Tell us if you have problems doing so. It shouldn't be all that
hard any more, and if it is, maybe some documentation is missing.

> I have just made some tweeks to get ARCH=ppc building for me but I still 
> need to sort out what is required to get around *** Error: Headers not 
> exportable for this architecture (ppc).

You should simply install the headers with ARCH=powerc, even when the
kernel is built with ARCH=ppc. From the user space point of view, there
is only one set of headers.

	Arnd <><
