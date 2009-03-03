Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A9CC2DDF8A
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Mar 2009 03:57:17 +1100 (EST)
Date: Tue, 3 Mar 2009 08:56:14 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: powerpc allnoconfig
Message-Id: <20090303085614.07f8aa27.akpm@linux-foundation.org>
In-Reply-To: <alpine.LRH.2.00.0903031109190.31985@vixen.sonytel.be>
References: <20090302171948.d1e2aa00.akpm@linux-foundation.org>
	<12051.1236047470@neuling.org>
	<20090302184049.27a73395.akpm@linux-foundation.org>
	<20090303135203.b36312a0.sfr@canb.auug.org.au>
	<20090302185514.2cc73512.akpm@linux-foundation.org>
	<20090303141905.52dbf9b1.sfr@canb.auug.org.au>
	<20090302200809.26b5d5bb.akpm@linux-foundation.org>
	<alpine.LRH.2.00.0903031109190.31985@vixen.sonytel.be>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Michael Neuling <mikey@neuling.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 3 Mar 2009 11:14:04 +0100 (CET) Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:

> > > let us know if that works :-)
> > 
> > didn't.  Oh well.
> 
> Does allnoconfig work if you force the compiler to be 32-bit, like
> 
>     make CC="powerpc64-unknown-linux-gnu-gcc -m32"

Nope:

scripts/mod/empty.c:1: error: -m64 requires a PowerPC64 cpu

I have a 32-bit-only gcc and `allnoconfig' secretly switches your
CPU from 64-bit to 32-bit.
