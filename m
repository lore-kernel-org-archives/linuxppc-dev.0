Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 96840679E9
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Sep 2006 14:15:41 +1000 (EST)
Date: Fri, 22 Sep 2006 14:15:22 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: paulus@samba.org
Subject: iSeries i/o patch
Message-Id: <20060922141522.00d82ee7.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paulus,

Couls you please apply the version of the patch here:

https://patchwork.ozlabs.org/linuxppc/patch?id=7033

This one does not depend on the noreturn BUG() patches and clearly
only affects iSeries.  I have built and run it there.  I have also built
it for several other configurations (pseries, g5, pmac32 and ppc32) just
to make sure. :-)

If we do decide to make BUG() noreturn, we can fix up the places where it
makes a difference later.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
