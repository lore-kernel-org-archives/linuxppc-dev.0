Return-Path: <mgreer@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id 06A78DDEDB
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Feb 2007 10:06:05 +1100 (EST)
Date: Fri, 9 Feb 2007 16:07:00 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 18/19] bootwrapper: Add xlate_reg(),
	and use it to find serial registers.
Message-ID: <20070209230700.GC12035@mag.az.mvista.com>
References: <20070207230017.GA3758@ld0162-tx32.am.freescale.net>
	<20070207230145.GR3849@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070207230145.GR3849@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 07, 2007 at 05:01:45PM -0600, Scott Wood wrote:
> xlate_reg() uses the ranges properties of a node's parentage to find the
> absolute physical address of the node's registers.
> 
> The ns16550 driver uses this when no virtual-reg property is found.

Is this necessary?  Shouldn't there always be a virtual-reg?

Mark
