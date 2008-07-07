Return-Path: <schwab@suse.de>
Received: from mx1.suse.de (mx1.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D10B2DDF11
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Jul 2008 20:01:21 +1000 (EST)
From: Andreas Schwab <schwab@suse.de>
To: Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH 1/2] elf loader support for auxvec base platform string
References: <20080703234140.GC9594@localdomain>
	<20080704021929.5E9EF1541F5@magilla.localdomain>
	<1215409693.8970.79.camel@pasglop>
	<20080707061811.19989154246@magilla.localdomain>
	<1215411800.8970.91.camel@pasglop>
	<20080707063522.5FE55154246@magilla.localdomain>
	<je8wwet9p6.fsf@sykes.suse.de>
	<20080707093151.8798A154246@magilla.localdomain>
Date: Mon, 07 Jul 2008 12:01:14 +0200
In-Reply-To: <20080707093151.8798A154246@magilla.localdomain> (Roland
	McGrath's message of "Mon, 7 Jul 2008 02:31:51 -0700 (PDT)")
Message-ID: <je63rirp1x.fsf@sykes.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Cc: Nathan Lynch <ntl@pobox.com>, linux-kernel@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Roland McGrath <roland@redhat.com> writes:

> There are 32 bits free now.  One can anticipate that reassigning a bit
> would come up only after these are exhausted.  With prudent use, this
> will take a very long time to happen.  Then the oldest CPU type string
> might be retired to reuse its bit.  It seems unlikely that there will
> be a single installation (root directory) that really needs to have
> installed both a kernel optimized for the oldest CPU model known and a
> kernel optimized for the newest CPU model known.

The kernel does not have to come from the same place as the root
filesystem.  You may want to run a new kernel with an old filesystem, or
vice-versa.

Andreas.

-- 
Andreas Schwab, SuSE Labs, schwab@suse.de
SuSE Linux Products GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
PGP key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
