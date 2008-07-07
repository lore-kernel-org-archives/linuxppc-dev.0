Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 64A54DDDE7
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 08:56:41 +1000 (EST)
Subject: Re: [PATCH 1/2] elf loader support for auxvec base platform string
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andreas Schwab <schwab@suse.de>
In-Reply-To: <je63rirp1x.fsf@sykes.suse.de>
References: <20080703234140.GC9594@localdomain>
	<20080704021929.5E9EF1541F5@magilla.localdomain>
	<1215409693.8970.79.camel@pasglop>
	<20080707061811.19989154246@magilla.localdomain>
	<1215411800.8970.91.camel@pasglop>
	<20080707063522.5FE55154246@magilla.localdomain>
	<je8wwet9p6.fsf@sykes.suse.de>
	<20080707093151.8798A154246@magilla.localdomain>
	<je63rirp1x.fsf@sykes.suse.de>
Content-Type: text/plain
Date: Tue, 08 Jul 2008 08:56:33 +1000
Message-Id: <1215471393.8970.157.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Nathan Lynch <ntl@pobox.com>, linux-kernel@vger.kernel.org,
	Roland McGrath <roland@redhat.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-07-07 at 12:01 +0200, Andreas Schwab wrote:
> Roland McGrath <roland@redhat.com> writes:
> 
> > There are 32 bits free now.  One can anticipate that reassigning a bit
> > would come up only after these are exhausted.  With prudent use, this
> > will take a very long time to happen.  Then the oldest CPU type string
> > might be retired to reuse its bit.  It seems unlikely that there will
> > be a single installation (root directory) that really needs to have
> > installed both a kernel optimized for the oldest CPU model known and a
> > kernel optimized for the newest CPU model known.
> 
> The kernel does not have to come from the same place as the root
> filesystem.  You may want to run a new kernel with an old filesystem, or
> vice-versa.

I agree, I'm pretty dubious here...

Cheers,
Ben.
