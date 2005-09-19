Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 203D768333
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Sep 2005 19:10:54 +1000 (EST)
Date: Mon, 19 Sep 2005 11:10:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20050919091046.GA7873@lst.de>
References: <15A1D026-00E3-4652-ABA5-9A8B8517A2CA@freescale.com>
	<432C23AE.6020800@hogyros.de>
	<17197.58312.715169.991104@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17197.58312.715169.991104@cargo.ozlabs.ibm.com>
Cc: ppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: Reminder: removal of APUS and Gemini still pending
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 19, 2005 at 08:01:44AM +1000, Paul Mackerras wrote:
> That sounds like a mistake to me...
> 
> > get proper changesets with attribution instead of a big patch (the plan 
> > is to forward-merge the changes until after the transition, then turn 
> > them back into a diff and apply them step by step).
> 
> One of the things I particularly want to do is to remove the special
> cases in the virtual<->physical address translations for APUS.
> Perhaps the sparsemem or discontigmem code could be used instead?

The apus codedrop Sven put into the Debian Kernel SVN repo has this
removed, see:

http://svn.debian.org/wsvn/kernel/dists/trunk/linux-2.6/debian/patches-debian/powerpc-apus.patch?op=file&rev=0&sc=0

even if apus folks don't want to merge now all the core touching parts
of that patch should go in as they clanup the ifdef APUS mess quite a
lot.
