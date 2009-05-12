Return-Path: <npiggin@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7BBD8DDDEE
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 15:59:27 +1000 (EST)
Date: Tue, 12 May 2009 07:59:18 +0200
From: Nick Piggin <npiggin@suse.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Next May 11 : BUG during scsi initialization
Message-ID: <20090512055918.GF32535@wotan.suse.de>
References: <20090511161442.3e9d9cb9.sfr@canb.auug.org.au>
	<4A081002.4050802@in.ibm.com>
	<20090511115233.GB8112@parisc-linux.org>
	<4A081437.7000409@in.ibm.com>
	<20090511122135.GC8112@parisc-linux.org>
	<20090512045716.GC32535@wotan.suse.de>
	<20090512155613.881fa2ec.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090512155613.881fa2ec.sfr@canb.auug.org.au>
Cc: linux-scsi <linux-scsi@vger.kernel.org>, Matthew Wilcox <matthew@wil.cx>,
	linuxppc-dev@ozlabs.org, Pekka Enberg <penberg@cs.helsinki.fi>,
	linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 12, 2009 at 03:56:13PM +1000, Stephen Rothwell wrote:
> Hi Nick,
> 
> On Tue, 12 May 2009 06:57:16 +0200 Nick Piggin <npiggin@suse.de> wrote:
> >
> > Hmm, I think (hope) your problems were fixed with the recent memory
> > coruption bug fix for SLQB. (if not, let me know)
> > 
> > This one possibly looks like a problem with remote memory allocation
> > or memory hotplug or something like that. I'll do a bit of code
> > review....
> 
> These are -next kernels which include the two fixes you posted recently
> (I am pretty sure).

Yes they should do.


>  I am also getting the network failures that Sachin
> is seeing on several of my machines here.  The previously reported
> problems have gone away.

This one is a SCSI failure... was there also a network one reported?
At any rate, I'm fairly sure this is a problem with SLQB, so it could
easily happen in any early driver setup.
