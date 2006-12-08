Return-Path: <krafft@de.ibm.com>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DC28767B89
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Dec 2006 21:45:03 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.8/8.13.8) with ESMTP id kB8AitLt183564
	for <linuxppc-dev@ozlabs.org>; Fri, 8 Dec 2006 10:44:58 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id kB8AisgA3174496
	for <linuxppc-dev@ozlabs.org>; Fri, 8 Dec 2006 11:44:54 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id kB8AirsT020149
	for <linuxppc-dev@ozlabs.org>; Fri, 8 Dec 2006 11:44:53 +0100
Date: Fri, 8 Dec 2006 11:41:13 +0100
From: Christian Krafft <krafft@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: [patch] powerpc: add scanning of ebc bus to of_platform
Message-ID: <20061208114113.2191e446@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: krafft@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Subject: powerpc: add scanning of ebc bus to of_platform

This patch add scanning of ebc bus to of_platform, which is needed
to recognize devices located on that bus.

Signed-off-by: Christian Krafft <krafft@de.ibm.com>

Index: linux-2.6.19-rc6/arch/powerpc/kernel/of_platform.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- linux-2.6.19-rc6.orig/arch/powerpc/kernel/of_platform.c
+++ linux-2.6.19-rc6/arch/powerpc/kernel/of_platform.c
@@ -50,6 +50,7 @@ static struct of_device_id of_default_bu
 	{ .type =3D "plb5", },
 	{ .type =3D "plb4", },
 	{ .type =3D "opb", },
+	{ .type =3D "ebc", },
 	{},
 };
=20


--=20
Mit freundlichen Gr=FCssen,
kind regards,

Christian Krafft
IBM Systems & Technology Group,=20
Linux Kernel Development
IT Specialist
