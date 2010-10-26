Return-Path: <yanok@emcraft.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 2C538B7148
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Oct 2010 10:53:15 +1100 (EST)
From: Ilya Yanok <yanok@emcraft.com>
To: linuxppc-dev@lists.ozlabs.org, wd@denx.de, dzu@denx.de, vlad@emcraft.com
Subject: [REPOST] [PATCH 0/6] fixes and MPC8308 support for the mpc512x_dma
	driver
Date: Wed, 27 Oct 2010 01:52:54 +0200
Message-Id: <1288137180-3220-1-git-send-email-yanok@emcraft.com>
In-Reply-To: <1285676696-5358-1-git-send-email-yanok@emcraft.com>
References: <1285676696-5358-1-git-send-email-yanok@emcraft.com>
Cc: Piotr Ziecik <kosmo@semihalf.com>, Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello everybody,

meanwhile I've fixed one more issue in mpc512x_dma driver.

Any comments? Anybody interrested in this driver? Piotr?

Still unsure how to deal with bitfield structures in IO space...

Regards, Ilya.

Signed-off-by: Ilya Yanok <yanok@emcraft.com>
Cc: Piotr Ziecik <kosmo@semihalf.com>
