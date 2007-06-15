Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound2-dub-R.bigfish.com (outbound-dub.frontbridge.com
	[213.199.154.16])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 5816CDE0E5
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 08:08:03 +1000 (EST)
Message-ID: <46730D94.9020906@am.sony.com>
Date: Fri, 15 Jun 2007 15:07:16 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: paulus@samba.org
Subject: [patch 31/33] PS3: Select MEMORY_HOTPLUG.
References: <20070615204749.629571012@am.sony.com>>
In-Reply-To: <20070615204749.629571012@am.sony.com>>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The PS3 uses the kernel's hotplug memory support, so make sure it is
always enabled when building for PS3.

Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
---
 arch/powerpc/platforms/ps3/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/powerpc/platforms/ps3/Kconfig
+++ b/arch/powerpc/platforms/ps3/Kconfig
@@ -7,6 +7,7 @@ config PPC_PS3
 	select USB_OHCI_BIG_ENDIAN_MMIO
 	select USB_ARCH_HAS_EHCI
 	select USB_EHCI_BIG_ENDIAN_MMIO
+	select MEMORY_HOTPLUG
 	help
 	  This option enables support for the Sony PS3 game console
 	  and other platforms using the PS3 hypervisor.

-- 
