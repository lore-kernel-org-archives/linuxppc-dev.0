Return-Path: <anton@samba.org>
Date: Wed, 12 Jan 2011 23:14:32 +1100
From: Anton Blanchard <anton@samba.org>
To: benh@kernel.crashing.org
Subject: [PATCH 2/2] powerpc: Enable 64kB pages and 1024 threads in pseries
	config
Message-ID: <20110112231432.28f485f3@kryten>
In-Reply-To: <20110112231243.71c71291@kryten>
References: <20110112231243.71c71291@kryten>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


- Enable 64kB pages so it gets some regular testing.

- The largest POWER7 has 1024 threads so bump NR_CPUS it to match.

Signed-off-by: Anton Blanchard <anton@samba.org> 
---     

Index: powerpc.git/arch/powerpc/configs/pseries_defconfig
===================================================================
--- powerpc.git.orig/arch/powerpc/configs/pseries_defconfig	2011-01-12 22:51:34.101760097 +1100
+++ powerpc.git/arch/powerpc/configs/pseries_defconfig	2011-01-12 22:52:47.434064107 +1100
@@ -2,7 +2,7 @@ CONFIG_PPC64=y
 CONFIG_ALTIVEC=y
 CONFIG_VSX=y
 CONFIG_SMP=y
-CONFIG_NR_CPUS=128
+CONFIG_NR_CPUS=1024
 CONFIG_EXPERIMENTAL=y
 CONFIG_SYSVIPC=y
 CONFIG_POSIX_MQUEUE=y
@@ -45,6 +45,8 @@ CONFIG_KEXEC=y
 CONFIG_IRQ_ALL_CPUS=y
 CONFIG_MEMORY_HOTPLUG=y
 CONFIG_MEMORY_HOTREMOVE=y
+CONFIG_PPC_64K_PAGES=y
+CONFIG_PPC_SUBPAGE_PROT=y
 CONFIG_SCHED_SMT=y
 CONFIG_HOTPLUG_PCI=m
 CONFIG_HOTPLUG_PCI_RPA=m
