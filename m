Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (unknown [209.180.55.243])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B453FDDF18
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  9 Jul 2007 13:38:33 +1000 (EST)
Subject: Re: ARCH=ppc vs ARCH=powerpc
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Mark Fortescue <mark@mtfhpc.demon.co.uk>
In-Reply-To: <Pine.LNX.4.61.0707061706140.4792@mtfhpc.demon.co.uk>
References: <Pine.LNX.4.61.0707061706140.4792@mtfhpc.demon.co.uk>
Content-Type: text/plain
Date: Sun, 08 Jul 2007 22:38:28 -0500
Message-Id: <1183952308.3308.2.camel@vader.jdub.homelinux.org>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 2007-07-06 at 17:21 +0100, Mark Fortescue wrote:
> Hi,
> 
> I have noticed and read a few comments regarding the demise of ARCH=ppc.
> 
> Having two PowerPC arcitectures and only supprting one of them makes 
> little sense. Is it not time to migrate (where required) the remaining 
> code from arch/ppc to arch/powerpc and asm-ppc to asm-powerpc. There are 
> not many files left that are unique to ARCH=ppc so it should not take too 
> long.

It was started in 2005.  It's taken too long already.

Bug fixes will still be taken until arch/ppc dies.  New platform/board
support, no.

josh
