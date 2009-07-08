Return-Path: <davem@davemloft.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id F1CFFB7089
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  8 Jul 2009 12:16:31 +1000 (EST)
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id B0161DDDF4
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Jul 2009 12:16:31 +1000 (EST)
Date: Tue, 07 Jul 2009 19:16:32 -0700 (PDT)
Message-Id: <20090707.191632.192291073.davem@davemloft.net>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] net: fix OF fixed-link property handling on Freescale
	network device drivers
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090707151241.GA26831@oksana.dev.rtsoft.ru>
References: <20090703221851.23909.923.stgit@localhost.localdomain>
	<20090707151241.GA26831@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, leoli@freescale.com, afleming@freescale.com,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Vorontsov <avorontsov@ru.mvista.com>
Date: Tue, 7 Jul 2009 19:12:41 +0400

> ->restart() will dereference phydev, which is NULL.
> 
> grep for 'phydev' in fs_enet/mac-*.c.

Ok, so this patch still needs a little bit more work.

Thanks for testing!
