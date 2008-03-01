Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 5901ADDE35
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Mar 2008 12:44:36 +1100 (EST)
Date: Fri, 29 Feb 2008 17:44:34 -0800 (PST)
Message-Id: <20080229.174434.216640668.davem@davemloft.net>
To: pbadari@us.ibm.com
Subject: Re: [RFC] updating lmb.memory information for hot mem add/remove
From: David Miller <davem@davemloft.net>
In-Reply-To: <1204333964.10146.18.camel@dyn9047017100.beaverton.ibm.com>
References: <1204247002.7729.11.camel@concordia.ozlabs.ibm.com>
	<1204307816.10146.11.camel@dyn9047017100.beaverton.ibm.com>
	<1204333964.10146.18.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: paulus@samba.org, anton@au1.ibm.com, ntl@pobox.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Badari Pulavarty <pbadari@us.ibm.com>
Date: Fri, 29 Feb 2008 17:12:44 -0800

> Here is what I cooked up and it seems to work fine.
> It may be easier to review the code (against my earlier patches).

BTW, the lmb code now lives under lib/ (sparc64 will be using it too)
and has several bug fixes applied to it in Paulus's current upstream
tree.
