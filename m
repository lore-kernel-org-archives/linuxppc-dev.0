Return-Path: <James.Bottomley@HansenPartnership.com>
Received: from accolon.hansenpartnership.com (accolon.hansenpartnership.com
	[76.243.235.52]) by ozlabs.org (Postfix) with ESMTP id C252BDDF10
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 08:08:05 +1000 (EST)
Subject: Re: linux-next: scsi tree build failure
From: James Bottomley <James.Bottomley@HansenPartnership.com>
To: benh@kernel.crashing.org
In-Reply-To: <1215468350.8970.129.camel@pasglop>
References: <20080707222528.280f0b9e.sfr@canb.auug.org.au>
	<1215441589.3274.17.camel@localhost.localdomain>
	<1215468350.8970.129.camel@pasglop>
Content-Type: text/plain
Date: Mon, 07 Jul 2008 17:07:58 -0500
Message-Id: <1215468479.3274.42.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-scsi <linux-scsi@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2008-07-08 at 08:05 +1000, Benjamin Herrenschmidt wrote:
> On Mon, 2008-07-07 at 09:39 -0500, James Bottomley wrote:
> > > Caused because commit 341b56db6804040aa9559e913865108424e3b18b
> > ("[SCSI]
> > > ibmvscsi: driver enablement for CMO"), which was 15/16 in a series,
> > has
> > > been merged before any of the other patches in the series.  I have
> > > reverted that commit.
> > 
> > Do I detect the fact that IBM sent a patch for a SCSI driver for which
> > the core features weren't yet enabled (and which I couldn't check, not
> > having a ppc build system)?
> 
> I suspect the sender (Robert) was asking for comments/review :-) In any
> case, Robert, next time make it explicit on a patch CCed to a separate
> list from the rest of the serie that it isn't to be merged without
> dependencies.
> 
> James, if you ack it, I'll put it in powerpc.git.

I thought it was all done and dusted (which is why I put it in
scsi-misc).  However, now Brian King seems to have some late arriving
comments.

James
