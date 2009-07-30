Return-Path: <davem@davemloft.net>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E6F88B7BCA
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 31 Jul 2009 07:20:58 +1000 (EST)
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id A8DDEDDD1C
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Jul 2009 07:20:58 +1000 (EST)
Date: Thu, 30 Jul 2009 14:21:03 -0700 (PDT)
Message-Id: <20090730.142103.94025463.davem@davemloft.net>
To: leoli@freescale.com
Subject: Re: [PATCH] gianfar: fix coalescing setup in ethtool support 
From: David Miller <davem@davemloft.net>
In-Reply-To: <1248857517-8270-1-git-send-email-leoli@freescale.com>
References: <1248857517-8270-1-git-send-email-leoli@freescale.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, b06378@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Li Yang <leoli@freescale.com>
Date: Wed, 29 Jul 2009 16:51:57 +0800

> Parameter order for using mk_ic_value(count, time) was reversed,
> the patch fixes this.
> 
> Signed-off-by: Jiajun Wu <b06378@freescale.com>
> Signed-off-by: Li Yang <leoli@freescale.com>

Applied, thanks.
