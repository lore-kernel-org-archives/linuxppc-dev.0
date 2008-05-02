Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4214BDE421
	for <linuxppc-dev@ozlabs.org>; Sat,  3 May 2008 03:33:44 +1000 (EST)
In-Reply-To: <Pine.LNX.4.64.0805020920120.1141@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0805020920120.1141@blarg.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1f2a22ddd60d37e6e7dc1048feb6d0a4@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] Fix kernel builds with newer gcc versions and
	-Os
Date: Fri, 2 May 2008 19:33:37 +0200
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> If someone using cutting edge toolchains for ppc64 could test and make
> sure if we enable CONFIG_CC_OPTIMIZE_FOR_SIZE things work that would be
> nice.

Current linus tree + some more stuff + this patch, ppc64_defconfig,
powerpc64-linux-gcc (GCC) 4.4.0 20080429 (experimental), builds just
fine.  CONFIG_CC_OPTIMIZE_FOR_SIZE=y.  Need any more test / more info?


Segher
