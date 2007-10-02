Return-Path: <mgreer@mvista.com>
Date: Mon, 1 Oct 2007 17:24:08 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH] powerpc: MAINTAINERS shouldn't reference linuxppc-embedded
Message-ID: <20071002002408.GB11878@mag.az.mvista.com>
References: <20071002002053.GB11277@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071002002053.GB11277@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Powerpc patches should be posted to linuxppc-dev@ozlabs.org so modify
MAINTAINERS to no longer reference linuxppc-embedded@ozlabs.org.

Signed-off-by: Mark A. Greer <mgreer@mvista.com>

---
 MAINTAINERS |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

---

diff --git a/MAINTAINERS b/MAINTAINERS
index 8f80068..06259b4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1543,7 +1543,7 @@ P:	Pantelis Antoniou
 M:	pantelis.antoniou@gmail.com
 P:	Vitaly Bordug
 M:	vbordug@ru.mvista.com
-L:	linuxppc-embedded@ozlabs.org
+L:	linuxppc-dev@ozlabs.org
 L:	netdev@vger.kernel.org
 S:	Maintained
 
@@ -1551,14 +1551,14 @@ FREESCALE HIGHSPEED USB DEVICE DRIVER
 P:	Li Yang
 M:	leoli@freescale.com
 L:	linux-usb-devel@lists.sourceforge.net
-L:	linuxppc-embedded@ozlabs.org
+L:	linuxppc-dev@ozlabs.org
 S:	Maintained
 
 FREESCALE QUICC ENGINE UCC ETHERNET DRIVER
 P:	Li Yang
 M:	leoli@freescale.com
 L:	netdev@vger.kernel.org
-L:	linuxppc-embedded@ozlabs.org
+L:	linuxppc-dev@ozlabs.org
 S:	Maintained
 
 FILE LOCKING (flock() and fcntl()/lockf())
@@ -2291,7 +2291,6 @@ M:	tnt@246tNt.com
 W:	http://www.246tNt.com/mpc52xx/
 W:	http://www.penguinppc.org/
 L:	linuxppc-dev@ozlabs.org
-L:	linuxppc-embedded@ozlabs.org
 S:	Maintained
 
 LINUX FOR POWERPC EMBEDDED PPC4XX
@@ -2300,7 +2299,7 @@ M:	jwboyer@linux.vnet.ibm.com
 P:	Matt Porter
 M:	mporter@kernel.crashing.org
 W:	http://www.penguinppc.org/
-L:	linuxppc-embedded@ozlabs.org
+L:	linuxppc-dev@ozlabs.org
 T:	git kernel.org:/pub/scm/linux/kernel/git/jwboyer/powerpc.git
 S:	Maintained
 
@@ -2308,21 +2307,21 @@ LINUX FOR POWERPC BOOT CODE
 P:	Tom Rini
 M:	trini@kernel.crashing.org
 W:	http://www.penguinppc.org/
-L:	linuxppc-embedded@ozlabs.org
+L:	linuxppc-dev@ozlabs.org
 S:	Maintained
 
 LINUX FOR POWERPC EMBEDDED PPC8XX
 P:	Marcelo Tosatti
 M:	marcelo@kvack.org
 W:	http://www.penguinppc.org/
-L:	linuxppc-embedded@ozlabs.org
+L:	linuxppc-dev@ozlabs.org
 S:	Maintained
 
 LINUX FOR POWERPC EMBEDDED PPC83XX AND PPC85XX
 P:	Kumar Gala
 M:	galak@kernel.crashing.org
 W:	http://www.penguinppc.org/
-L:	linuxppc-embedded@ozlabs.org
+L:	linuxppc-dev@ozlabs.org
 S:	Maintained
 
 LINUX FOR POWERPC PA SEMI PWRFICIENT
@@ -2978,7 +2977,7 @@ POWERPC 4xx EMAC DRIVER
 P:	Eugene Surovegin
 M:	ebs@ebshome.net
 W:	http://kernel.ebshome.net/emac/
-L:	linuxppc-embedded@ozlabs.org
+L:	linuxppc-dev@ozlabs.org
 L:	netdev@vger.kernel.org
 S:	Maintained
 
