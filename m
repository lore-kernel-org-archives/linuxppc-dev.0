Return-Path: <fenkes@de.ibm.com>
Received: from mtagate8.de.ibm.com (mtagate8.de.ibm.com [195.212.29.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate8.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EB14BDDEE0
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Mar 2007 00:22:11 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate8.de.ibm.com (8.13.8/8.13.8) with ESMTP id l2REM6HQ297350
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Mar 2007 14:22:06 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v8.3) with
	ESMTP id l2REM6MV1859720
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Mar 2007 16:22:06 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id l2REM5rS021334
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Mar 2007 16:22:06 +0200
From: Joachim Fenkes <fenkes@de.ibm.com>
To: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ibmebus: newline fix
Date: Tue, 27 Mar 2007 15:18:55 +0100
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703271618.55616.fenkes@de.ibm.com>
Cc: pmac@au1.ibm.com, themann@de.ibm.com, paulus@samba.org, johnrose@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stupid me forgot a newline in an error message.

Signed-off-by: Joachim Fenkes <fenkes@de.ibm.com>
---


Applies on top of
"ibmebus: change probe/remove interface from using loc-code to DT path"


 ibmebus.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


diff -Nurp 03b.path/arch/powerpc/kernel/ibmebus.c 03c.path/arch/powerpc/kernel/ibmebus.c
--- 03b.path/arch/powerpc/kernel/ibmebus.c	2007-03-21 15:23:23.000000000 +0100
+++ 03c.path/arch/powerpc/kernel/ibmebus.c	2007-03-27 15:30:44.341143552 +0200
@@ -421,7 +421,7 @@ static ssize_t ibmebus_store_probe(struc
 		of_node_put(dn);
 		rc = IS_ERR(dev) ? PTR_ERR(dev) : count;
 	} else {
-		printk(KERN_WARNING "%s: no such device node: %s",
+		printk(KERN_WARNING "%s: no such device node: %s\n",
 		       __FUNCTION__, path);
 		rc = -ENODEV;
 	}
