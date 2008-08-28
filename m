Return-Path: <paul@mad-scientist.us>
Received: from netezza.com (mta.netezza.com [12.148.248.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "Domain-Confidentiality-authority",
	Issuer "Domain-Confidentiality-authority" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id CD223DE71A
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Aug 2008 04:22:30 +1000 (EST)
Subject: Re: 2.6.25: include/asm-ppc vs. include/asm-powerpc
From: Paul Smith <paul@mad-scientist.us>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200808281642.26647.arnd@arndb.de>
References: <1219928864.16802.69.camel@homebase.localnet>
	<200808281553.18167.arnd@arndb.de>
	<1219933848.16802.96.camel@homebase.localnet>
	<200808281642.26647.arnd@arndb.de>
Content-Type: text/plain
Date: Thu, 28 Aug 2008 14:07:10 -0400
Message-Id: <1219946830.16629.551.camel@psmith-ubeta.netezza.com>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
Reply-To: paul@mad-scientist.us
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2008-08-28 at 16:42 +0200, Arnd Bergmann wrote:
> The trick that arch/ppc uses is to create a symlink
> arch/ppc/include/asm pointing to include/asm-powerpc and then passing
> "-Iinclude -Iarch/ppc/include" to the compiler.

Aha!!

Changing that arch/ppc/include/asm symlink to be relative
(-> ../../../include/asm-powerpc) instead of absolute solves all these
problems!

Now I'm just down to real portability issues (since the drivers were
originally written for 2.6.14).


Thanks very much!
