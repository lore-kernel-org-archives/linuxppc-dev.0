Message-ID: <3E0356C2.10702@mvista.com>
Date: Fri, 20 Dec 2002 10:43:30 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Patch for drivers/mtd/maps/Config.in
Content-Type: multipart/mixed;
 boundary="------------010804080709020005010706"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------010804080709020005010706
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Tom, et. al.,

Revs 1.15, 1.16, and 1.17 have an extra 'fi' stmt (in
linuxppc_2_4_devel).  This patch fixes that.

Mark
--

--------------010804080709020005010706
Content-Type: text/plain;
 name="cfg.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cfg.diff"

===== drivers/mtd/maps/Config.in 1.17 vs edited =====
--- 1.17/drivers/mtd/maps/Config.in	Mon Dec 16 21:10:05 2002
+++ edited/drivers/mtd/maps/Config.in	Fri Dec 20 10:31:04 2002
@@ -63,8 +63,7 @@
     if [ "$CONFIG_440" = "y" ]; then
       dep_tristate '  Flash devices mapped on IBM Ebony' CONFIG_MTD_EBONY $CONFIG_MTD_CFI $CONFIG_EBONY
     fi
-   fi
- fi
+  fi
 fi

 if [ "$CONFIG_MIPS" = "y" ]; then

--------------010804080709020005010706--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
