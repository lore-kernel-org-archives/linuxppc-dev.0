Subject: Re: [PATCH] export m8xx_cpm_hostalloc
From: Andreas Oberritter <obi@saftware.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <1090590567.3939.20.camel@localhost.localdomain>
References: <1090590567.3939.20.camel@localhost.localdomain>
Content-Type: multipart/mixed; boundary="=-28WYUdDxqg3gF4C0mX6m"
Message-Id: <1090590704.3939.23.camel@localhost.localdomain>
Mime-Version: 1.0
Date: Fri, 23 Jul 2004 15:51:44 +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--=-28WYUdDxqg3gF4C0mX6m
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Forgot to attach the patch, so here it is.

--=-28WYUdDxqg3gF4C0mX6m
Content-Disposition: attachment; filename=export_hostalloc.diff
Content-Type: text/x-patch; name=export_hostalloc.diff; charset=utf-8
Content-Transfer-Encoding: 7bit

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/07/23 15:13:53+02:00 obi@pegasos.saftware.de
#   export m8xx_cpm_hostalloc for modularized i2c driver
#
# arch/ppc/8xx_io/commproc.c
#   2004/07/23 15:13:33+02:00 obi@pegasos.saftware.de +2 -0
#   export m8xx_cpm_hostalloc for modularized i2c driver
#
diff -Nru a/arch/ppc/8xx_io/commproc.c b/arch/ppc/8xx_io/commproc.c
--- a/arch/ppc/8xx_io/commproc.c	2004-07-23 15:31:13 +02:00
+++ b/arch/ppc/8xx_io/commproc.c	2004-07-23 15:31:13 +02:00
@@ -327,6 +327,8 @@
 	return(retloc);
 }

+EXPORT_SYMBOL(m8xx_cpm_hostalloc);
+
 /* Set a baud rate generator.  This needs lots of work.  There are
  * four BRGs, any of which can be wired to any channel.
  * The internal baud rate clock is the system clock divided by 16.

--=-28WYUdDxqg3gF4C0mX6m--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
