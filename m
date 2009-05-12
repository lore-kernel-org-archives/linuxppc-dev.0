Return-Path: <npiggin@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A4545DDEF5
	for <linuxppc-dev@ozlabs.org>; Tue, 12 May 2009 16:56:06 +1000 (EST)
Date: Tue, 12 May 2009 08:56:01 +0200
From: Nick Piggin <npiggin@suse.de>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Next May 11 : BUG during scsi initialization
Message-ID: <20090512065601.GA19079@wotan.suse.de>
References: <20090511161442.3e9d9cb9.sfr@canb.auug.org.au>
	<4A081002.4050802@in.ibm.com>
	<20090511115233.GB8112@parisc-linux.org>
	<4A081437.7000409@in.ibm.com>
	<20090511122135.GC8112@parisc-linux.org>
	<20090512045716.GC32535@wotan.suse.de>
	<20090512155613.881fa2ec.sfr@canb.auug.org.au>
	<20090512055918.GF32535@wotan.suse.de>
	<20090512160352.4a97d2f4.sfr@canb.auug.org.au>
	<20090512165245.78b6bf83.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090512165245.78b6bf83.sfr@canb.auug.org.au>
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

On Tue, May 12, 2009 at 04:52:45PM +1000, Stephen Rothwell wrote:
> Hi Nick,
> 
> On Tue, 12 May 2009 16:03:52 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > This is what I have been getting for the last few days:
> 
> bisected into the net changes, I will follow up there, sorry.

No problem. Phew, yours was looking like a nasty one if it was indeed
an SLQB bug ;) 

Thanks,
Nick
