Return-Path: <rmk+linuxppc-dev=ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[217.147.92.249])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8C67FDDEA0
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 18:38:18 +1000 (EST)
Date: Wed, 4 Apr 2007 09:38:03 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
Message-ID: <20070404083803.GA13134@flint.arm.linux.org.uk>
References: <1175663999.2932.8.camel@shinybook.infradead.org>
	<17939.15726.114059.679277@cargo.ozlabs.ibm.com>
	<1175666635.2932.17.camel@shinybook.infradead.org>
	<20070404.011208.120446173.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070404.011208.120446173.davem@davemloft.net>
Sender: Russell King <rmk@arm.linux.org.uk>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	dwmw2@infradead.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 04, 2007 at 01:12:08AM -0700, David Miller wrote:
> Your ARM example holds zero water because that platform has all kinds
> of weird devices so people there are used to all kinds of non-standard
> conventions and naming.

I think your perception is more wrong than you could ever think.
Montavista would absolutely love all serial ports to be under the
ttyS* naming, especially on ARM where there is a wide variety of
different possibilities - ttyAM, ttySA, ttyPXA, ttyAMA, and so
the list goes on.  It apparantly gives their support department
real headaches.

There are similar feelings from the handhelds.org community.

However, despite people pressing for it, there's yet to be a *sane*
*technical* *solution* to the problem.  All I've seen so far is one
bad hack.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
