Return-Path: <wg@grandegger.com>
Message-ID: <484CECE2.9050605@grandegger.com>
Date: Mon, 09 Jun 2008 10:42:10 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Linuxppc-dev@ozlabs.org
Subject: [PATCH] booting-without-of: add more bindings for FSL UPM driver
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds the bindings for the property "chip-delay" used by
the patch "[NAND] driver extension to support NAND on TQM85xx modules" 
posted to this list a few minutes ago:

      http://ozlabs.org/pipermail/linuxppc-dev/2008-June/057632.html

Note: this patch is based on the following patches from Anton
      Vorontsov posted to this list some time ago:

      http://ozlabs.org/pipermail/linuxppc-dev/2008-May/056531.html
      http://ozlabs.org/pipermail/linuxppc-dev/2008-June/057244.html

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 Documentation/powerpc/booting-without-of.txt |    1 +
 1 file changed, 1 insertion(+)

Index: linux-2.6-galak/Documentation/powerpc/booting-without-of.txt
===================================================================
--- linux-2.6-galak.orig/Documentation/powerpc/booting-without-of.txt
+++ linux-2.6-galak/Documentation/powerpc/booting-without-of.txt
@@ -3007,6 +3007,7 @@ platforms are moved over to use the flat
       - reg : should specify localbus chip select and size used for the chip.
       - fsl,upm-addr-offset : UPM pattern offset for the address latch.
       - fsl,upm-cmd-offset : UPM pattern offset for the command latch.
+      - chip-delay : may specify a delay value in milliseconds.
       - gpios : may specify optional GPIO connected to the Ready-Not-Busy pin.
 
       Example:
