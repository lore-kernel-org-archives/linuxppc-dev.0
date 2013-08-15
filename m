Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH 1/6] powerpc: Update the 00-Index in Documentation/powerpc
Date: Thu, 15 Aug 2013 15:22:14 +1000
Message-Id: <1376544139-26783-1-git-send-email-michael@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

People have been dropping things in here without updating the index, do
it for them.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 Documentation/powerpc/00-INDEX | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/powerpc/00-INDEX b/Documentation/powerpc/00-INDEX
index 05026ce..6db73df 100644
--- a/Documentation/powerpc/00-INDEX
+++ b/Documentation/powerpc/00-INDEX
@@ -5,13 +5,20 @@ please mail me.
 
 00-INDEX
 	- this file
+bootwrapper.txt
+	- Information on how the powerpc kernel is wrapped for boot on various
+	  different platforms.
 cpu_features.txt
 	- info on how we support a variety of CPUs with minimal compile-time
 	options.
 eeh-pci-error-recovery.txt
 	- info on PCI Bus EEH Error Recovery
+firmware-assisted-dump.txt
+	- Documentation on the firmware assisted dump mechanism "fadump".
 hvcs.txt
 	- IBM "Hypervisor Virtual Console Server" Installation Guide
+kvm_440.txt
+	- Various notes on the implementation of KVM for PowerPC 440.
 mpc52xx.txt
 	- Linux 2.6.x on MPC52xx family
 pmu-ebb.txt
@@ -19,3 +26,7 @@ pmu-ebb.txt
 qe_firmware.txt
 	- describes the layout of firmware binaries for the Freescale QUICC
 	  Engine and the code that parses and uploads the microcode therein.
+ptrace.txt
+	- Information on the ptrace interfaces for hardware debug registers.
+transactional_memory.txt
+	- Overview of the Power8 transactional memory support.
-- 
1.8.1.2
