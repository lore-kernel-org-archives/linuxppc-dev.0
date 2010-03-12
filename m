Return-Path: <albert_herranz@yahoo.es>
Received: from smtp123.mail.ukl.yahoo.com (smtp123.mail.ukl.yahoo.com
	[77.238.184.54]) by ozlabs.org (Postfix) with SMTP id 7C573B7DC3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 13 Mar 2010 06:13:02 +1100 (EST)
From: Albert Herranz <albert_herranz@yahoo.es>
To: linux-usb@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 08/11] wii: have generic dma coherent
Date: Fri, 12 Mar 2010 20:12:43 +0100
Message-Id: <1268421166-4791-9-git-send-email-albert_herranz@yahoo.es>
In-Reply-To: <1268421166-4791-1-git-send-email-albert_herranz@yahoo.es>
References: <1268421166-4791-1-git-send-email-albert_herranz@yahoo.es>
Cc: Albert Herranz <albert_herranz@yahoo.es>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Let the Nintendo Wii gaming console use per-device dma coherent allocations.
This will be used later by some of its drivers.

Signed-off-by: Albert Herranz <albert_herranz@yahoo.es>
---
 arch/powerpc/platforms/embedded6xx/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
index 524d971..fe77ab2 100644
--- a/arch/powerpc/platforms/embedded6xx/Kconfig
+++ b/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -119,6 +119,7 @@ config WII
 	bool "Nintendo-Wii"
 	depends on EMBEDDED6xx
 	select GAMECUBE_COMMON
+	select HAVE_GENERIC_DMA_COHERENT
 	help
 	  Select WII if configuring for the Nintendo Wii.
 	  More information at: <http://gc-linux.sourceforge.net/>
-- 
1.6.3.3
