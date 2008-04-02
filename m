Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 9D377DDF7C
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Apr 2008 23:15:54 +1100 (EST)
Subject: RE: [PATCH] Add Fixed PHY support for ucc_geth
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: Li Yang <LeoLi@freescale.com>
In-Reply-To: <989B956029373F45A0B8AF029708189001D1954D@zch01exm26.fsl.freescale.net>
References: <>
	<1205833615-15833-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<989B956029373F45A0B8AF029708189001D1954D@zch01exm26.fsl.freescale.net>
Content-Type: text/plain
Date: Wed, 02 Apr 2008 14:15:52 +0200
Message-Id: <1207138552.9675.61.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Cc: Netdev <netdev@vger.kernel.org>, Jeff Garzik <jeff@garzik.org>,
	"Linuxppc-Embedded@Ozlabs.Org" <linuxppc-embedded@ozlabs.org>
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Fri, 2008-03-21 at 16:51 +0800, Li Yang wrote:
> > -----Original Message-----
> > From: Joakim Tjernlund [mailto:Joakim.Tjernlund@transmode.se] 
> > Sent: Tuesday, March 18, 2008 5:47 PM
> > To: Netdev; Li Yang; Linuxppc-Embedded@Ozlabs.Org
> > Cc: Joakim Tjernlund
> > Subject: [PATCH] Add Fixed PHY support for ucc_geth
> > 
> > The new Fixed PHY method, fixed-link property, isn't
> > impl. for ucc_geth which makes fixed PHYs non functional.
> > Add support for the new method to restore the Fixed PHY
> > functionality.
> > 
> > Signed-off-by: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
> 
> Signed-off-by: Li Yang <leoli@freescale.com>
> 
> ---
> Ps: This patch depends on the patch "ucc_geth: use correct thread number
> for 10/100Mbps link" to apply, which hasn't made to Linus' tree for now
> but has already been in Jeff and David's trees.

What happened to this patch? It is not in Linus tree.

 Jocke
