Return-Path: <penberg@cs.helsinki.fi>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 24122B7206
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 18:38:14 +1000 (EST)
Received: from mail.cs.helsinki.fi (courier.cs.helsinki.fi [128.214.9.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B31FBDDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 18:38:13 +1000 (EST)
Subject: Re: [Powerpc/SLQB] Next June 06 : BUG during scsi initialization
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20090612183559.33018f0c.sfr@canb.auug.org.au>
References: <20090511161442.3e9d9cb9.sfr@canb.auug.org.au>
	<4A081002.4050802@in.ibm.com> <4A2909E8.6000507@in.ibm.com>
	<Pine.LNX.4.64.0906071105030.11309@melkki.cs.Helsinki.FI>
	<4A2D001E.5060802@in.ibm.com> <20090609141903.GE15219@wotan.suse.de>
	<4A31EB2A.9080003@in.ibm.com> <20090612074213.GA21070@wotan.suse.de>
	<4A320D12.2050802@in.ibm.com> <20090612082145.GD24044@wotan.suse.de>
	<1244795139.30512.23.camel@penberg-laptop>
	<20090612183559.33018f0c.sfr@canb.auug.org.au>
Date: Fri, 12 Jun 2009 11:38:07 +0300
Message-Id: <1244795887.30512.27.camel@penberg-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Nick Piggin <npiggin@suse.de>, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-06-12 at 18:35 +1000, Stephen Rothwell wrote:
> Hi Pekka,
> 
> On Fri, 12 Jun 2009 11:25:39 +0300 Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> >
> > Hmm, SLQB in my for-next branch. Stephen, is slab.git dropped from
> > linux-next or something?
> 
> Yesterday (next-20090611) the slab tree for linux-next had only one
> commit in it ("SLUB: Out-of-memory diagnostics").  Today (next-20090612)
> it has quite a lot in it again - including SLQB.

Ah, ok. I did mess it up for few hours and I guess you picked up then.
Thanks, Stephen!
