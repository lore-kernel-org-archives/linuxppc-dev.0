Date: Wed, 24 Apr 2002 11:26:26 -0700
From: andrew may <acmay@acmay.homeip.net>
To: andrew may <acmay@acmay.homeip.net>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: [PATCH] IBM ocp I2C
Message-ID: <20020424112626.A22212@ecam.san.rr.com>
References: <20020423200127.G20394@ecam.san.rr.com> <20020423200151.H20394@ecam.san.rr.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="HlL+5n6rz5pIUxbD"
In-Reply-To: <20020423200151.H20394@ecam.san.rr.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii

This patch is also needed to get it to compile. I forgot
to check things after I removed the stuff from the headers.

--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="i2c-clock2.patch"

# This is a BitKeeper generated patch for the following project:
# Project Name: Linux 2.4 for PowerPC development tree
# This patch format is intended for GNU patch command version 2.5 or higher.
# This patch includes the following deltas:
#	           ChangeSet	1.966   -> 1.967
#	drivers/i2c/i2c-adap-ibm_ocp.c	1.2     -> 1.3
#
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/04/24	amay@infosec-server.infosec	1.967
# remove dead code
# --------------------------------------------
#
diff -Nru a/drivers/i2c/i2c-adap-ibm_ocp.c b/drivers/i2c/i2c-adap-ibm_ocp.c
--- a/drivers/i2c/i2c-adap-ibm_ocp.c	Wed Apr 24 11:21:27 2002
+++ b/drivers/i2c/i2c-adap-ibm_ocp.c	Wed Apr 24 11:21:27 2002
@@ -304,8 +304,6 @@
       iic_ibmocp_data[i]->data = (struct iic_regs *)iic_ibmocp_adaps[i];
       iic_ibmocp_data[i]->setiic = iic_ibmocp_setbyte;
       iic_ibmocp_data[i]->getiic = iic_ibmocp_getbyte;
-      iic_ibmocp_data[i]->getown = 0;
-      iic_ibmocp_data[i]->getclock = 0;
       iic_ibmocp_data[i]->waitforpin = iic_ibmocp_waitforpin;
       iic_ibmocp_data[i]->udelay = 80;
       iic_ibmocp_data[i]->mdelay = 80;

--HlL+5n6rz5pIUxbD--

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
