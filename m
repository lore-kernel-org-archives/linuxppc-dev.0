Return-Path: <tinamdar@amcc.com>
From: Tanmay Inamdar <tinamdar@apm.com>
To: benh@kernel.crashing.org, jwboyer@gmail.com, grant.likely@secretlab.ca,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 devicetree-discuss@lists.ozlabs.org
Subject: [PATCH 4/5] powerpc: config: 40x: Add 16650 UART support in klondike
 defconfig
Date: Mon,  2 Apr 2012 12:09:06 +0530
Message-Id: <1333348747-12713-4-git-send-email-tinamdar@apm.com>
In-Reply-To: <1333348747-12713-3-git-send-email-tinamdar@apm.com>
References: <1333348747-12713-1-git-send-email-tinamdar@apm.com>
 <1333348747-12713-2-git-send-email-tinamdar@apm.com>
 <1333348747-12713-3-git-send-email-tinamdar@apm.com>
Cc: Tanmay Inamdar <tinamdar@apm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adding 16650 UART support in klondike_defconfig for APM8018X SOC

Signed-off-by: Tanmay Inamdar <tinamdar@apm.com>
---
:100644 100644 c0d228d... c35c345... M	arch/powerpc/configs/40x/klondike_defconfig
 arch/powerpc/configs/40x/klondike_defconfig |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/configs/40x/klondike_defconfig b/arch/powerpc/configs/40x/klondike_defconfig
index c0d228d..c35c345 100644
--- a/arch/powerpc/configs/40x/klondike_defconfig
+++ b/arch/powerpc/configs/40x/klondike_defconfig
@@ -30,6 +30,12 @@ CONFIG_SCSI_SAS_ATTRS=y
 # CONFIG_UNIX98_PTYS is not set
 # CONFIG_LEGACY_PTYS is not set
 # CONFIG_DEVKMEM is not set
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=2
+CONFIG_SERIAL_8250_RUNTIME_UARTS=2
+CONFIG_SERIAL_8250_EXTENDED=y
+CONFIG_SERIAL_OF_PLATFORM=y
 # CONFIG_HW_RANDOM is not set
 # CONFIG_HWMON is not set
 # CONFIG_USB_SUPPORT is not set
-- 
1.6.1.rc3
