From: Marc-Christian Petersen <m.c.p@wolk.linux-systeme.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org
Subject: [PATCH 2.6.4-rc2] Disable Macintosh device drivers for all but PPC
Date: Sun, 7 Mar 2004 21:50:12 +0100
MIME-Version: 1.0
Message-Id: <200403072117.47345@WOLK>
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_Es4SAd7/qsCkCkh"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--Boundary-00=_Es4SAd7/qsCkCkh
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Benjamin,

I think the attached patch is needed to stop showing us "Macintosh device
drivers" for all architectures via menuconfig || xconfig || gconfig.

ciao, Marc

--Boundary-00=_Es4SAd7/qsCkCkh
Content-Type: text/x-diff;
  charset="iso-8859-15";
  name="Kconfig-cleanup-ppc.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="Kconfig-cleanup-ppc.patch"

diff -Naurp linux-2.6.4-rc1/drivers/macintosh/Kconfig linux-2.6.4-rc1-modified/drivers/macintosh/Kconfig
--- linux-2.6.4-rc1/drivers/macintosh/Kconfig	2004-03-07 20:52:34.000000000 +0100
+++ linux-2.6.4-rc1-modified/drivers/macintosh/Kconfig	2004-03-07 21:12:47.000000000 +0100
@@ -1,5 +1,6 @@

 menu "Macintosh device drivers"
+	depends on PPC

 config ADB
 	bool "Apple Desktop Bus (ADB) support"

--Boundary-00=_Es4SAd7/qsCkCkh--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
