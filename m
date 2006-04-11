Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 89258679F3
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Apr 2006 01:25:51 +1000 (EST)
Date: Tue, 11 Apr 2006 10:23:58 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Stefan Meyer <reyems@telkomsa.net>
Subject: Re: Linux kernel for MPC834X platform
In-Reply-To: <003d01c65d7b$f88a6da0$1100a8c0@stefanlaptop>
Message-ID: <Pine.LNX.4.44.0604111022330.25404-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Tue, 11 Apr 2006, Stefan Meyer wrote:

> Hi Kumar
> Pardon my ignorance, but  I am not with you on the flat device tree and the 
> new u-boot ??
> Regards
> Stefan

Look at Documentation/powerpc/booting-without-of.txt in the kernel tree.  
I have a u-boot tree @ git.kernel.org/pub/scm/boot/u-boot/u-boot.git which 
has support for booting the MPC834x ADS/MDS/SYS board from Freescale with 
a flat device tree for use with the arch/powerpc port.

- kumar
