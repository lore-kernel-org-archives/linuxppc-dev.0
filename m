Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 12EDEDDE0A
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 19:15:26 +1100 (EST)
Date: Wed, 14 Feb 2007 17:07:06 +0900 (JST)
Message-Id: <200702140807.l1E8790a011678@toshiba.co.jp>
Subject: [PATCH 0/4] spidernet: support for Celleb
To: jgarzik@pobox.com
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, jim@jklewis.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jeff-san,

This is a revised patch set for spider_net to work on Celleb.

This patch set is based on Jens-san's v3 phy patch and Linas-san's
spider_net patch.

Please apply our patch set with them.


Note: You need not apply Jens-san's spidernet patch because our patch
set includes it.

Best regards,
Kou Ishizaki
