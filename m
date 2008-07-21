Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CE806DDF0A
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Jul 2008 19:34:54 +1000 (EST)
Subject: Re: [PATCH v3] elf loader support for auxvec base platform string
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20080720204008.8927460c.akpm@linux-foundation.org>
References: <1216166331-14810-1-git-send-email-ntl@pobox.com>
	<1216166331-14810-2-git-send-email-ntl@pobox.com>
	<1216276539.7740.309.camel@pasglop>
	<20080717000951.5f8cab37.akpm@linux-foundation.org>
	<20080717221932.GL9594@localdomain>
	<20080717154218.8981035c.akpm@linux-foundation.org>
	<487FD74C.4080603@BitWagon.com> <20080718182850.GO9594@localdomain>
	<1216610655.11027.80.camel@pasglop>
	<20080720204008.8927460c.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Mon, 21 Jul 2008 19:33:57 +1000
Message-Id: <1216632837.11027.82.camel@pasglop>
Mime-Version: 1.0
Cc: John Reiser <jreiser@BitWagon.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Nathan Lynch <ntl@pobox.com>,
	torvalds@linux-foundation.org, roland@redhat.com
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > Andrew, we have one other patch (the powerpc bits) on top of that one.
> > Do you want to carry both in -mm on top of John's patch ? We would like
> > that in .27 though, I don't know what your merge plans are for John's
> > patch.
> > 
> 
> How about I send John's patch Linuswards right now?

No objection.

Cheers,
Ben.
