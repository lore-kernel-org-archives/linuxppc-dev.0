Return-Path: <jwboyer@jdub.homelinux.org>
Received: from jdub.homelinux.org (67-40-242-100.roch.qwest.net
	[67.40.242.100])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C014B67B5A
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 10 Sep 2006 03:43:20 +1000 (EST)
Subject: RE: asm/*.h files missing for ppc arch.
From: Josh Boyer <jwboyer@jdub.homelinux.org>
To: Ming Liu <eemingliu@hotmail.com>
In-Reply-To: <BAY110-F12CE731189ED422803AC93B2340@phx.gbl>
References: <BAY110-F12CE731189ED422803AC93B2340@phx.gbl>
Content-Type: text/plain
Date: Sat, 09 Sep 2006 12:42:43 -0500
Message-Id: <1157823763.2670.2.camel@vader.jdub.homelinux.org>
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

On Sat, 2006-09-09 at 15:14 +0000, Ming Liu wrote:
> Dear all,
> Sorry that mmu.h is there. However ptrace.h, cputime.h and so on are not in 
> asm-ppc/. 
> 
> Waiting for your telling...

How are you compiling?  For 4xx, you still need to specify ARCH=ppc with
the make command.  There is some makefile hackery that will then bring
in header files from asm-powerpc as needed.

josh
