Return-Path: <davem@davemloft.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1042AB7087
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 23 Jul 2009 02:40:56 +1000 (EST)
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id C58EDDDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Jul 2009 02:40:55 +1000 (EST)
Date: Wed, 22 Jul 2009 09:40:59 -0700 (PDT)
Message-Id: <20090722.094059.113003489.davem@davemloft.net>
To: mware@elphinstone.net
Subject: Re: [PATCH v3] net: Rework mdio-ofgpio driver to use of_mdio
	infrastructure
From: David Miller <davem@davemloft.net>
In-Reply-To: <4A66400F.3090309@elphinstone.net>
References: <4A66400F.3090309@elphinstone.net>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mark Ware <mware@elphinstone.net>
Date: Wed, 22 Jul 2009 08:24:15 +1000

> Changes to the fs_enet driver
> (aa73832c5a80d6c52c69b18af858d88fa595dd3c) cause kernel crashes when
> using the mdio-ofgpio driver.
> 
> This patch replicates similar changes made to the fs_enet mii-bitbang
> drivers.  It has been tested on a custom mpc8280 based board using an
> NFS mounted root.
> 
> Signed-off-by: Mark Ware <mware@elphinstone.net>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>

Your email client has massively corrupted this patch, I even tried
to fix it up but it's so bad that I just gave up half-way through.

Please use an attachment or whatever is necessary to get this
patch submitted cleanly and without it getting damaged.  Read:

linux/Documentation/email-clients.txt

for tips.

Thanks.
