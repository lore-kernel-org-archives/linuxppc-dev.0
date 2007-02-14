Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 99DF3DDDE4
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 18:52:00 +1100 (EST)
Date: Wed, 14 Feb 2007 16:51:07 +0900 (JST)
Message-Id: <200702140751.l1E7p73x027147@toshiba.co.jp>
Subject: Re: [PATCH 0/4] spidernet: support for Celleb
To: linas@austin.ibm.com, jens@de.ibm.com
In-Reply-To: <20070212234959.GF923@austin.ibm.com>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: jim@jklewis.com, linuxppc-dev@ozlabs.org, jgarzik@pobox.com,
	cbe-oss-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas-san, Jens-san,

> Tested this series of patches together with Jen's "version 3" patch,
> it worked for me. Code looks reasonable.  Thus

We tried Jens-san's v3 patch on Celleb, and it works for us.

We also need Linas-san's patch set which includes bug-fix and makes
the code compilable etc. But our previous patch set conflicts with
Linas-san's patch set.

So we will post a revised patch set for spider_net, which is based on
Jens-san's phy patch and Linas-san's spider_net patch.  The revised
patch set will differ from our previous patch set only by editorial
changes, so we think it will be ready to go in.


Best regards,
Kou Ishizaki
