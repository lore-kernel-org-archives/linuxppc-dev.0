Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 88AA4DDEE2
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 19:50:21 +1100 (EST)
Date: Wed, 07 Feb 2007 17:49:50 +0900 (JST)
Message-Id: <200702070849.l178nvGC005341@toshiba.co.jp>
Subject: [PATCH 0/4] spidernet: support for Celleb
To: jgarzik@pobox.com, jens@de.ibm.com
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, jim@jklewis.com, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a revised spidernet patch set based on
netdev-2.6.git#upstream.

This patch set is merged Jens-san's spidernet patch and works on
Toshiba Cell reference set (aka Celleb). 
It requires Jens-san's phy patch
(http://ozlabs.org/pipermail/linuxppc-dev/2007-February/030987.html).

Ignore our previos patch set, and try this patch set on Cell Blade,
please (sorry for asking a lot).

Best regards,
Kou Ishizaki
