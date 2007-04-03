Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 737CCDDED6
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 09:56:57 +1000 (EST)
Date: Tue, 03 Apr 2007 16:56:57 -0700 (PDT)
Message-Id: <20070403.165657.34759233.davem@davemloft.net>
To: dwmw2@infradead.org
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
From: David Miller <davem@davemloft.net>
In-Reply-To: <1175642916.10567.24.camel@shinybook.infradead.org>
References: <1175610345.2665.15.camel@shinybook.infradead.org>
	<17938.57292.870224.132415@cargo.ozlabs.ibm.com>
	<1175642916.10567.24.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: David Woodhouse <dwmw2@infradead.org>
Date: Tue, 03 Apr 2007 19:28:36 -0400

> Abusing the 8250 device numbers prevents the 8250 module from being
> loaded at the same time as pmac_zilog, and means you can't have both
> internal port and PCMCIA or PCI 8250 ports active at the same time.

Dynamic minor number allocation for ttyS? would allow this
just fine, and that's exactly what we do on sparc as I
explained in another response.
