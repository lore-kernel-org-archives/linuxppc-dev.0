Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9C708DDF89
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 10:14:08 +1000 (EST)
Subject: Re: mISDN still breaking the allmodconfig build...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20080727.170235.97056809.davem@davemloft.net>
References: <20080727.170235.97056809.davem@davemloft.net>
Content-Type: text/plain
Date: Mon, 28 Jul 2008 10:13:42 +1000
Message-Id: <1217204022.11188.139.camel@pasglop>
Mime-Version: 1.0
Cc: sfr@canb.auug.org.au, kkeil@suse.de, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	torvalds@linux-foundation.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2008-07-27 at 17:02 -0700, David Miller wrote:
> More fallout from the premature mISDN driver merge:
> 
> drivers/isdn/hardware/mISDN/hfcmulti.c:5255:2: error: #error "not running on big endian machines now"

Lovely...

Ben.
