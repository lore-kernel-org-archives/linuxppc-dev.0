Message-ID: <3E071A3F.7050309@intracom.gr>
Date: Mon, 23 Dec 2002 16:14:23 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org
Subject: [PATCH]: Trivial MTD map Config.in fix
Content-Type: multipart/mixed;
 boundary="------------080902050500030907020502"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------080902050500030907020502
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi

There is an unbalanced fi in the drivers/mtd/maps/Config.in
which causes an abort when you select it.

Please apply as it is obvious.

Pantelis

--------------080902050500030907020502
Content-Type: text/plain;
 name="trivial-mtd-map.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="trivial-mtd-map.patch"

--- ../linuxppc_2_4_devel/drivers/mtd/maps/Config.in	Fri Dec 20 11:35:57 2002
+++ drivers/mtd/maps/Config.in	Mon Dec 23 16:06:05 2002
@@ -63,8 +66,7 @@
     if [ "$CONFIG_440" = "y" ]; then
       dep_tristate '  Flash devices mapped on IBM Ebony' CONFIG_MTD_EBONY $CONFIG_MTD_CFI $CONFIG_EBONY
     fi
-   fi
- fi
+  fi
 fi

 if [ "$CONFIG_MIPS" = "y" ]; then

--------------080902050500030907020502--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
