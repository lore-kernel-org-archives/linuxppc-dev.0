Return-Path: <SRS0+fdd23b9c115b88e530f5+1108+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7821D67B9C
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Sep 2006 15:07:59 +1000 (EST)
Subject: Re: [POWERPC] merge iSeries i/o operations with the rest
From: David Woodhouse <dwmw2@infradead.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20060905120817.e52857ee.sfr@canb.auug.org.au>
References: <20060905120817.e52857ee.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Mon, 04 Sep 2006 22:07:50 -0700
Message-Id: <1157432871.2413.9.camel@shinybook.infradead.org>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-09-05 at 12:08 +1000, Stephen Rothwell wrote:
> The low level i/o operations are now handled in iSeires by taking a
> trap when we access the (inaccessible) io memory region and calling
> the Hypervisor from the trap code.  

There was some discussion of the possibility of using the 'alternatives'
mechanism to patch the I/O instructions at run-time when we find we've
booted on iSeries -- just turning each one into a jump to a trampoline
which does the appropriate hypervisor calls, thus avoiding the overhead
of the trap each time.

Was that approach not viable, or not noticeably less of a performance
hit on iSeries?

-- 
dwmw2
