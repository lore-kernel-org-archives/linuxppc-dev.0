Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id C0E12DDEE9
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 10:02:37 +1000 (EST)
Date: Sun, 27 Jul 2008 17:02:35 -0700 (PDT)
Message-Id: <20080727.170235.97056809.davem@davemloft.net>
To: linux-kernel@vger.kernel.org
Subject: mISDN still breaking the allmodconfig build...
From: David Miller <davem@davemloft.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, akpm@linux-foundation.org,
	torvalds@linux-foundation.org, kkeil@suse.de, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


More fallout from the premature mISDN driver merge:

drivers/isdn/hardware/mISDN/hfcmulti.c:5255:2: error: #error "not running on big endian machines now"
