Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 31539DDF33
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Mar 2009 16:38:17 +1100 (EST)
Date: Mon, 2 Mar 2009 21:38:01 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: powerpc allnoconfig
Message-Id: <20090302213801.1dd255f3.akpm@linux-foundation.org>
In-Reply-To: <20090303154043.fee7902e.sfr@canb.auug.org.au>
References: <20090302171948.d1e2aa00.akpm@linux-foundation.org>
	<12051.1236047470@neuling.org>
	<20090302184049.27a73395.akpm@linux-foundation.org>
	<20090303135203.b36312a0.sfr@canb.auug.org.au>
	<20090302185514.2cc73512.akpm@linux-foundation.org>
	<20090303141905.52dbf9b1.sfr@canb.auug.org.au>
	<20090302200809.26b5d5bb.akpm@linux-foundation.org>
	<20090303154043.fee7902e.sfr@canb.auug.org.au>
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

On Tue, 3 Mar 2009 15:40:43 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Andrew,
> 
> On Mon, 2 Mar 2009 20:08:09 -0800 Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > > Right, you have a 64 bit only compiler. Also it is version 4.1.0 which we now black ban (I think).
> > 
> > Probably.  But I only use it for compilation testing, so the `Your
> > version of gcc miscompiles the __weak directive' thing is a pointless
> > PITA, so I patch it out.
> 
> Ah, ok.
> 
> > > let us know if that works :-)
> > 
> > didn't.  Oh well.
> 
> Rats!
> 
> I think we need a better bug report :-)
> Kernel version?

Current mainline.

> What error do you get now?

Same as before.

> allmodconfig and defconfig turn CONFIG_PPC64 on.  allnoconfig turns it
> off so you are trying to build a 32 bit kernel with a 64 bit compiler.

Oh.  Well that will tear it.

How does one prepare a powerpc64 allnoconfig?
