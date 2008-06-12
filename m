Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 99140DDE1D
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 17:24:55 +1000 (EST)
Subject: Re: linux-next: powerpc build failure
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080612170505.6049fa75.sfr@canb.auug.org.au>
References: <20080611192748.686236fd.sfr@canb.auug.org.au>
	<20080611095951.GB14033@elte.hu>
	<18512.32267.636550.47385@cargo.ozlabs.ibm.com>
	<20080612053335.GA22035@bubble.grove.modra.org>
	<20080612170505.6049fa75.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Thu, 12 Jun 2008 17:23:57 +1000
Message-Id: <1213255437.14478.30.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Thomas@ozlabs.org, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, Alan Modra <amodra@bigpond.net.au>,
	"H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>,
	Gleixner <tglx@linutronix.de>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-06-12 at 17:05 +1000, Stephen Rothwell wrote:
> So I tried this (added --relax to LDFLAGS_vmlinux if CONFIG FTRACE was
> set) and got this;
> 
> /usr/bin/ld: --relax and -r may not be used together
> 
> So, I will disable FTRACE on powerpc for now by removing HAVE_FTRACE
> from
> being selected in arch/powerpc/Kconfig.

So we completely lose ftrace for the sake of a config that nobody
sane ever uses (allyesconfig) ? :-)

Cheers,
Ben.
