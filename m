Message-ID: <29365-19760@sneakemail.com>
Date: Fri, 11 Jun 2004 08:52:44 -0700
From: "Stephen Williams" <612dlag102@sneakemail.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Another problem with pk pull of linuxppc-2.4
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


The ibm405gpr.h header file is missing the definition of OPB_BASE_START.
I copied the definitions from the linuxppc_2_4_devel tree and it worked
just fine, so I believe this is a correct patch.

According to bk, this file hasn't been changed in linuxppc-2.4 in over
a year (2003-03-12) so *how* pray tell have people been compiling this
thing for PPC405GPr? Who's the right party for getting this patch
installed?

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/06/11 08:49:06-07:00 steve@wing.XXXXXXXXXX
#   Defines of OPB_BASE_START needed by ibm405gpr.c,
#   which does not include ibm405gp.h.
#
# arch/ppc/platforms/ibm405gpr.h
#   2004/06/11 08:49:04-07:00 steve@wing.XXXXXXXXXX +2 -0
#   Defines of OPB_BASE_START needed by ibm405gpr.c,
#   which does not include ibm405gp.h.
#
diff -Nru a/arch/ppc/platforms/ibm405gpr.h b/arch/ppc/platforms/ibm405gpr.h
--- a/arch/ppc/platforms/ibm405gpr.h    2004-06-11 08:50:46 -07:00
+++ b/arch/ppc/platforms/ibm405gpr.h    2004-06-11 08:50:46 -07:00
@@ -75,6 +75,8 @@
  #define PPC4xx_ONB_IO_PADDR    ((uint)0xef600000)
  #define PPC4xx_ONB_IO_VADDR    PPC4xx_ONB_IO_PADDR
  #define PPC4xx_ONB_IO_SIZE     ((uint)4*1024)
+#define OPB_BASE_START        0x40000000
+#define EBIU_BASE_START       0xF0100000

  /* serial port defines */
  #define RS_TABLE_SIZE  2



--
Steve Williams                "The woods are lovely, dark and deep.
steve at XXXXXXXXXX           But I have promises to keep,
http://www.XXXXXXXXXX         and lines to code before I sleep,
http://www.picturel.com       And lines to code before I sleep."


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
