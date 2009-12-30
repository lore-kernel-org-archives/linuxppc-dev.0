Return-Path: <avorontsov@dev.rtsoft.ru>
Received: from mail.dev.rtsoft.ru (mail.dev.rtsoft.ru [213.79.90.226])
	by ozlabs.org (Postfix) with SMTP id 70BA71007D4
	for <linuxppc-dev@ozlabs.org>; Thu, 31 Dec 2009 05:21:48 +1100 (EST)
Date: Wed, 30 Dec 2009 21:21:46 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: David Miller <davem@davemloft.net>
Subject: net: Assorted fixes
Message-ID: <20091230182146.GA4515@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: netdev@vger.kernel.org, afleming@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Dec 27, 2009 at 09:57:36PM -0800, David Miller wrote:
> Actually I'm reverting both patches:
> 
> drivers/net/phy/mdio_bus.c:268: warning: ‘mdio_bus_phy_may_suspend’ defined but not used
> 
> Please resubmit these two patches with this warning fixed.
> 
> CONFIG_PM is not always enabled :-)

Ugh, sorry about that, and thanks for catching!

Here are the amended patches + one more fix.

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
