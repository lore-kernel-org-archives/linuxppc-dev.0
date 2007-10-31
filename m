Return-Path: <pbadari@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 15A16DDDF9
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Nov 2007 02:45:32 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l9VEjBjd004134
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 10:45:11 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l9VFjBvl027070
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 09:45:12 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l9VFjAjX023983
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 09:45:11 -0600
Subject: [PATCH 2/3] Enable hotplug memory remove for ppc64
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain
Date: Wed, 31 Oct 2007 08:48:39 -0800
Message-Id: <1193849319.17412.32.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, anton@au1.ibm.com,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
	linux-mm <linux-mm@kvack.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Enable hotplug memory remove for ppc64.

Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
---
 arch/powerpc/Kconfig |    3 +++
 1 file changed, 3 insertions(+)

Index: linux-2.6.23/arch/powerpc/Kconfig
===================================================================
--- linux-2.6.23.orig/arch/powerpc/Kconfig	2007-10-23 09:39:29.000000000 -0700
+++ linux-2.6.23/arch/powerpc/Kconfig	2007-10-25 11:44:57.000000000 -0700
@@ -234,6 +234,9 @@ config HOTPLUG_CPU
 config ARCH_ENABLE_MEMORY_HOTPLUG
 	def_bool y
 
+config ARCH_ENABLE_MEMORY_HOTREMOVE
+	def_bool y
+
 config KEXEC
 	bool "kexec system call (EXPERIMENTAL)"
 	depends on (PPC_PRPMC2800 || PPC_MULTIPLATFORM) && EXPERIMENTAL
