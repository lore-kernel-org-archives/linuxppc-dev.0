Return-Path: <SRS0+2568b504cf8fbadfadf9+1039+infradead.org+dwmw2@canuck.srs.infradead.org>
Received: from canuck.infradead.org (canuck.infradead.org [205.233.218.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9EB7367A42
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jun 2006 00:28:01 +1000 (EST)
Subject: Re: [PATCH 2/7] mtd: Add map file for mpc83xx boards
From: David Woodhouse <dwmw2@infradead.org>
To: Li Yang-r58472 <LeoLi@freescale.com>
In-Reply-To: <9FCDBA58F226D911B202000BDBAD467306E04FD3@zch01exm40.ap.freescale.net>
References: <9FCDBA58F226D911B202000BDBAD467306E04FD3@zch01exm40.ap.freescale.net>
Content-Type: text/plain
Date: Wed, 28 Jun 2006 15:27:41 +0100
Message-Id: <1151504861.17134.39.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: Phillips Kim-R1AAHA <Kim.Phillips@freescale.com>,
	Yin Olivia-r63875 <Hong-Hua.Yin@freescale.com>,
	"'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
	linuxppc-dev@ozlabs.org,
	"'linux-mtd@lists.infradead.org'" <linux-mtd@lists.infradead.org>,
	Chu hanjin-r52514 <Hanjin.Chu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-06-28 at 22:23 +0800, Li Yang-r58472 wrote:
> Flash mapping file for MPC83xx MDS platforms.

I'm not accepting any more individual map drivers unless they're
absolutely necessary, which this one isn't.

Use a platform device and physmap. Or better still, extend physmap to
handle of_devices too and just stick the flash information in the device
tree.

-- 
dwmw2
