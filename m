Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 15938DDDE9
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Dec 2007 04:13:13 +1100 (EST)
From: "Joakim Tjernlund" <joakim.tjernlund@transmode.se>
To: "'Vitaly Bordug'" <vitb@kernel.crashing.org>,
	"'Paul Mackerras'" <paulus@samba.org>
References: <20071206225121.31080.86606.stgit@localhost.localdomain>
Subject: RE: [PATCH 1/3] [NET] phy/fixed.c: rework to not duplicate PHY
	layerfunctionality
Date: Sat, 29 Dec 2007 18:13:08 +0100
Message-ID: <003c01c84a3e$15d3a9c0$02ac10ac@Jocke>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-reply-to: <20071206225121.31080.86606.stgit@localhost.localdomain>
Cc: netdev@vger.kernel.org, 'linuxppc-dev' <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: 
> linuxppc-dev-bounces+joakim.tjernlund=transmode.se@ozlabs.org 
> [mailto:linuxppc-dev-bounces+joakim.tjernlund=transmode.se@ozl
> abs.org] On Behalf Of Vitaly Bordug
> Sent: den 6 december 2007 23:51
> To: Paul Mackerras
> Cc: netdev@vger.kernel.org; linuxppc-dev
> Subject: [PATCH 1/3] [NET] phy/fixed.c: rework to not 
> duplicate PHY layerfunctionality
> 
> 
> With that patch fixed.c now fully emulates MDIO bus, thus no need
> to duplicate PHY layer functionality. That, in turn, drastically
> simplifies the code, and drops down line count.
> 
> As an additional bonus, now there is no need to register MDIO bus
> for each PHY, all emulated PHYs placed on the platform fixed MDIO bus.
> There is also no more need to pre-allocate PHYs via .config option,
> this is all now handled dynamically.
> 
> 
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> Signed-off-by: Vitaly Bordug <vitb@kernel.crashing.org>
> Acked-by: Jeff Garzik <jeff@garzik.org>

What happened to this patch set? Is it sitting in a tree somewhere waiting
for 2.4.25 or does it need more work?

 Jocke
