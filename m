Return-Path: <roman.fietze@telemotive.de>
Received: from coyote.quickmin.net (coyote.quickmin.net [217.14.112.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.quickmin.de", Issuer "smtp.quickmin.de" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id D625AB8C7E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Dec 2009 18:13:09 +1100 (EST)
Received: from rfietze.mit.telemotive.de (rfietze.mit.telemotive.de
	[192.168.5.33])
	by alderan.mit.telemotive.de (Postfix) with ESMTP id 8EFA5BADFD
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 22 Dec 2009 08:13:04 +0100 (CET)
From: Roman Fietze <roman.fietze@telemotive.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 13/13] powerpc/5200: LocalPlus driver: clean up comments
References: <200912081339.50722.roman.fietze@telemotive.de>
	<fa686aa40912211611i2469b15p175511fd7ead4d49@mail.gmail.com>
	<200912220755.09756.roman.fietze@telemotive.de>
In-Reply-To: <200912220755.09756.roman.fietze@telemotive.de>
MIME-Version: 1.0
Message-ID: <200912220813.04321.roman.fietze@telemotive.de>
Date: Tue, 22 Dec 2009 08:13:04 +0100
Content-Type: Text/Plain;
  charset="iso-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Signed-off-by: Roman Fietze <roman.fietze@telemotive.de>
=2D--
 arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c |   14 --------------
 1 files changed, 0 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c b/arch/powerpc/p=
latforms/52xx/mpc52xx_lpbfifo.c
index b2c92f5..a89072a 100644
=2D-- a/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_lpbfifo.c
@@ -206,17 +206,6 @@ static void mpc52xx_lpbfifo_kick(struct mpc52xx_lpbfif=
o_request *req)
 /**
  * mpc52xx_lpbfifo_sclpc_irq - IRQ handler for LPB FIFO
  *
=2D * On transmit, the dma completion irq triggers before the fifo
=2D * completion triggers.  Handle the dma completion here instead of the
=2D * LPB FIFO Bestcomm task completion irq because everything is not
=2D * really done until the LPB FIFO completion irq triggers.
=2D *
=2D * In other words:
=2D * For DMA, on receive, the "Fat Lady" is the bestcom completion irq. on
=2D * transmit, the fifo completion irq is the "Fat Lady". The opera (or in
=2D * this case the DMA/FIFO operation) is not finished until the "Fat
=2D * Lady" sings.
=2D *
  * Reasons for entering this routine:
  * 1) PIO mode rx and tx completion irq
  * 2) DMA interrupt mode tx completion irq
@@ -411,9 +400,6 @@ void mpc52xx_lpbfifo_poll(void)
 {
 	struct mpc52xx_lpbfifo_request *req =3D lpbfifo.req;
=20
=2D	/*
=2D	 * For more information, see comments on the "Fat Lady"=20
=2D	 */
 	if (mpc52xx_lpbfifo_is_dma(req->flags) && (req->flags & MPC52XX_LPBFIFO_F=
LAG_WRITE))
 		mpc52xx_lpbfifo_sclpc_irq(0, NULL);
 	else=20
=2D-=20
1.6.5.5



=2D-=20
Roman Fietze                Telemotive AG B=FCro M=FChlhausen
Breitwiesen                              73347 M=FChlhausen
Tel.: +49(0)7335/18493-45        http://www.telemotive.de
