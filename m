Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 94BBADDF28
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 08:06:05 +1000 (EST)
Subject: Re: linux-next: scsi tree build failure
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: James Bottomley <James.Bottomley@HansenPartnership.com>
In-Reply-To: <1215441589.3274.17.camel@localhost.localdomain>
References: <20080707222528.280f0b9e.sfr@canb.auug.org.au>
	<1215441589.3274.17.camel@localhost.localdomain>
Content-Type: text/plain
Date: Tue, 08 Jul 2008 08:05:50 +1000
Message-Id: <1215468350.8970.129.camel@pasglop>
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-scsi <linux-scsi@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-07-07 at 09:39 -0500, James Bottomley wrote:
> > Caused because commit 341b56db6804040aa9559e913865108424e3b18b
> ("[SCSI]
> > ibmvscsi: driver enablement for CMO"), which was 15/16 in a series,
> has
> > been merged before any of the other patches in the series.  I have
> > reverted that commit.
> 
> Do I detect the fact that IBM sent a patch for a SCSI driver for which
> the core features weren't yet enabled (and which I couldn't check, not
> having a ppc build system)?

I suspect the sender (Robert) was asking for comments/review :-) In any
case, Robert, next time make it explicit on a patch CCed to a separate
list from the rest of the serie that it isn't to be merged without
dependencies.

James, if you ack it, I'll put it in powerpc.git.

Cheers,
Ben.
