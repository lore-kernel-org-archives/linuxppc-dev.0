Return-Path: <nacc@us.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 23824B70EE
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 14 Jan 2011 10:22:51 +1100 (EST)
Received: from d01dlp02.pok.ibm.com (d01dlp02.pok.ibm.com [9.56.224.85])
	by e1.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id p0DNDvgM014247
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jan 2011 18:13:57 -0500
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
	by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 7295C4DE8040
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 13 Jan 2011 18:19:37 -0500 (EST)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p0DNMgPq2121838
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jan 2011 18:22:42 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p0DNMgwQ002219
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jan 2011 18:22:42 -0500
Date: Thu, 13 Jan 2011 15:22:39 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] pseries_defconfig: add BNX2=m
Message-ID: <20110113232239.GA4277@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Neuling <mikey@neuling.org>, sonnyrao@us.ibm.com,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Upcoming servers will include a Broadcom NIC, add to the defconfig to
increase testing coverage and make sure mainline builds come up with
networking.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

diff --git a/arch/powerpc/configs/pseries_defconfig b/arch/powerpc/configs/pseries_defconfig
index f87f0e1..2048585 100644
--- a/arch/powerpc/configs/pseries_defconfig
+++ b/arch/powerpc/configs/pseries_defconfig
@@ -184,6 +184,7 @@ CONFIG_ACENIC_OMIT_TIGON_I=y
 CONFIG_E1000=y
 CONFIG_E1000E=y
 CONFIG_TIGON3=y
+CONFIG_BNX2=m
 CONFIG_CHELSIO_T1=m
 CONFIG_CHELSIO_T3=m
 CONFIG_EHEA=y


-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
