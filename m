Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id BD3D0474C7
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jan 2009 16:57:48 +1100 (EST)
Date: Mon, 12 Jan 2009 21:57:47 -0800 (PST)
Message-Id: <20090112.215747.18333160.davem@davemloft.net>
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH] gianfar: Fix soft lockup with multi-interrupt TSECs
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090112183835.GA25390@oksana.dev.rtsoft.ru>
References: <20090112183835.GA25390@oksana.dev.rtsoft.ru>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, afleming@freescale.com, netdev@vger.kernel.org,
	jgarzik@pobox.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Anton Vorontsov <avorontsov@ru.mvista.com>
Date: Mon, 12 Jan 2009 21:38:35 +0300

> This patch fixes following bug:
> 
> BUG: soft lockup - CPU#0 stuck for 61s! [S03mountvirtfs-:922]
 ...
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>

Applied, thanks Anton.
