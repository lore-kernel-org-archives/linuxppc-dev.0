Message-ID: <3E8DC956.20800@mvista.com>
Date: Fri, 04 Apr 2003 11:05:10 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: linuxppc_2_4_devel arch/ppc/kernel/ppc-stub.c (KGDB) patch
Content-Type: multipart/mixed;
 boundary="------------040001050304000805040907"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------040001050304000805040907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Tom,

Please apply the attached fix for KGDB.  The ampersand should not have
been removed on that line.

Mark
--

--------------040001050304000805040907
Content-Type: text/plain;
 name="ppc-stub.c.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc-stub.c.diff"

===== arch/ppc/kernel/ppc-stub.c 1.24 vs edited =====
--- 1.24/arch/ppc/kernel/ppc-stub.c	Thu Mar 27 02:26:50 2003
+++ edited/arch/ppc/kernel/ppc-stub.c	Fri Apr  4 11:00:21 2003
@@ -609,7 +609,7 @@
 	*ptr++ = hexchars[PC_REGNUM >> 4];
 	*ptr++ = hexchars[PC_REGNUM & 0xf];
 	*ptr++ = ':';
-	ptr = mem2hex((char *)regs->nip, ptr, 4);
+	ptr = mem2hex((char *)&regs->nip, ptr, 4);
 	*ptr++ = ';';
 	*ptr++ = hexchars[SP_REGNUM >> 4];
 	*ptr++ = hexchars[SP_REGNUM & 0xf];

--------------040001050304000805040907--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
