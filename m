Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id E09B9DDD0C
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jul 2007 10:52:27 +1000 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "'linuxppc-dev Development'" <linuxppc-dev@ozlabs.org>,
	"'Netdev'" <netdev@vger.kernel.org>,
	"'Li Yang-r58472'" <LeoLi@freescale.com>
Subject: [PATCH] ucc_geth.c, make PHY device optional.
Date: Tue, 3 Jul 2007 02:52:13 +0200
Message-ID: <012701c7bd0c$64fe67c0$0e67a8c0@Jocke>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <1183142980.20673.89.camel@gentoo-jocke.transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> This patch makes the PHY optional for ucc_geth.c ethernet driver.
> This is useful to support a direct mii to mii connection to, for example,
> a onboard swicth.
> 
> Signed-off-by: Joakim Tjernlund <joakim.tjernlund@transmode.se>
----
[SNIP patch sent last Friday]

Since this is my last week before vacation, I would really like to
get feedback on this patch sooner than later :)

 Jocke
