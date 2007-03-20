Return-Path: <rmk+linuxppc-dev=ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
	[217.147.92.249])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8408FDDEF1
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 21:57:01 +1100 (EST)
Date: Tue, 20 Mar 2007 10:56:41 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [PATCH] Complain about missing system calls.
Message-ID: <20070320105641.GA29198@flint.arm.linux.org.uk>
References: <1173394873.3461.510.camel@pmac.infradead.org>
	<20070319164243.026fdbfd.akpm@linux-foundation.org>
	<1174376588.3392.168.camel@pmac.infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1174376588.3392.168.camel@pmac.infradead.org>
Sender: Russell King <rmk@arm.linux.org.uk>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	sam@ravnborg.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 20, 2007 at 07:43:08AM +0000, David Woodhouse wrote:
> On Mon, 2007-03-19 at 16:42 -0700, Andrew Morton wrote:
> > hm, did you try running this on x86_64?
> 
> I don't have any. I only tested it on PowerPC and i386. Others then
> provided more exclusions for SPARC and maybe ARM, although I'm not sure
> you have the latter yet. It's not hard to add extra exclusions.

Some of the ones which come up on x86_64 also come up on ARM for the
same reason; they're obsolete system calls which probably shouldn't
be implemented on anything but legacy i386.  Things like waitpid, etc.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
