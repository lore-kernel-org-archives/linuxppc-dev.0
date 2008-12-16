Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-quonix.sasl.smtp.pobox.com
	[208.72.237.25]) by ozlabs.org (Postfix) with ESMTP id 36975DDF1E
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Dec 2008 11:07:11 +1100 (EST)
Date: Mon, 15 Dec 2008 18:07:04 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] add of_find_next_cache_node()
Message-ID: <20081216000704.GQ6958@localdomain>
References: <1228956366-17593-1-git-send-email-ntl@pobox.com>
	<1229296287.26324.87.camel@pasglop> <20081215223333.GP6958@localdomain>
	<1229383984.26324.134.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1229383984.26324.134.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> 
> Don't 970MP have a shared L2 tho ?

The 970MP UM describes 1MB L2 per core, and the device tree on the
quad G5 reflects that... might be interesting to know what it looks
like on IBM JS21 for comparison's sake, but I think we're okay.
