Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 451FDDDF61
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Mar 2009 17:35:30 +1100 (EST)
Date: Mon, 2 Mar 2009 22:35:18 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: powerpc allnoconfig
Message-Id: <20090302223518.9b4591c1.akpm@linux-foundation.org>
In-Reply-To: <20090303172232.f12ffbf8.sfr@canb.auug.org.au>
References: <20090302171948.d1e2aa00.akpm@linux-foundation.org>
	<12051.1236047470@neuling.org>
	<20090302184049.27a73395.akpm@linux-foundation.org>
	<20090303135203.b36312a0.sfr@canb.auug.org.au>
	<20090302185514.2cc73512.akpm@linux-foundation.org>
	<20090303141905.52dbf9b1.sfr@canb.auug.org.au>
	<20090302200809.26b5d5bb.akpm@linux-foundation.org>
	<20090303154043.fee7902e.sfr@canb.auug.org.au>
	<20090302213801.1dd255f3.akpm@linux-foundation.org>
	<20090303172232.f12ffbf8.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Michael Neuling <mikey@neuling.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 3 Mar 2009 17:22:32 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> So, I can only imagine it is your toolchain that is letting you down.

hrm.  I blame Rusty.

> What is your host machine?

x86_64/FCx

>  Can I send you a new toolchain? (Mine are only
> good for building kernels - they have no libraries - they are build by a
> script I got from Segher Boessenkool.)

It's OK - I don't really care and as long as it's OK on a realistic
build setup, I guess we're good.
