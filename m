Return-Path: <bwalle@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 18084DDE47
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Feb 2008 00:25:33 +1100 (EST)
Date: Tue, 5 Feb 2008 14:25:27 +0100
From: Bernhard Walle <bwalle@suse.de>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: 2.6.24-mm1: ppc32: too few arguments to function 'reserve_bootmem'
Message-ID: <20080205132526.GC31523@suse.de>
References: <20080203171634.58ab668b.akpm@linux-foundation.org>
	<200802042129.03065.m.kozlowski@tuxland.pl>
	<20080204144036.cf22a402.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080204144036.cf22a402.akpm@linux-foundation.org>
Cc: linuxppc-dev@ozlabs.org, Mariusz Kozlowski <m.kozlowski@tuxland.pl>,
	paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Andrew Morton <akpm@linux-foundation.org> [2008-02-04 23:40]:
> We did this wrong.  We should have introduced a new reserve_bootmem_foo()
> and migrated over to that in stages.  Once all callers are migrated, remove
> the old interface.

Well, my original proposal was to add a new function but then someone
complained that we already have too much bootmem functions. I don't
remember if this was on LKML or internally in Bugzilla.

However, sorry, it was my fault of course.


        Bernhard
