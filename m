Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 18BD1DDE3E
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 15:50:16 +1000 (EST)
Date: Tue, 03 Apr 2007 22:50:06 -0700 (PDT)
Message-Id: <20070403.225006.119275067.davem@davemloft.net>
To: dwmw2@infradead.org
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
From: David Miller <davem@davemloft.net>
In-Reply-To: <1175663999.2932.8.camel@shinybook.infradead.org>
References: <20070404022544.59b022a6@the-village.bc.nu>
	<17939.10130.687893.167511@cargo.ozlabs.ibm.com>
	<1175663999.2932.8.camel@shinybook.infradead.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
	alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: David Woodhouse <dwmw2@infradead.org>
Date: Wed, 04 Apr 2007 01:19:59 -0400

> I don't see why that 'should' be the case. Certainly it _isn't_ the case
> on most supported platforms -- we have separate device numbers, and
> names, for most types of ports. There's only one or two drivers which
> abuse ttySn for anything other than 8250 ports.

sunsu, sunzilog, pmac_zilog, sunsab, etc.

The list is longer than you think.  In fact the convention is
very well established.
