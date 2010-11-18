Return-Path: <stephen.neuendorffer@xilinx.com>
Received: from SG2EHSOBE004.bigfish.com (sg2ehsobe002.messaging.microsoft.com
	[207.46.51.76]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EB266B721A
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Nov 2010 11:10:58 +1100 (EST)
From: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
To: <grant.likely@secretlab.ca>, <dirk.brandewie@gmail.com>,
	<devicetree-discuss@lists.ozlabs.org>, <linuxppc-dev@lists.ozlabs.org>,
	<microblaze-uclinux@itee.uq.edu.au>
Subject: [PATCH 3/7] arch/x86: select OF and OF_FLATTREE
Date: Thu, 18 Nov 2010 15:54:58 -0800
In-Reply-To: <1290124502-13125-3-git-send-email-stephen.neuendorffer@xilinx.com>
References: <1290021345-4303-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1290124502-13125-1-git-send-email-stephen.neuendorffer@xilinx.com>
	<1290124502-13125-2-git-send-email-stephen.neuendorffer@xilinx.com>
	<1290124502-13125-3-git-send-email-stephen.neuendorffer@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain
Message-ID: <111913e5-7481-46b8-b04d-eee3cdc8fc32@SG2EHSMHS002.ehs.local>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Testing patch to verify that the device tree code can be compiled on X86.
---
 arch/x86/Kconfig |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index cea0cd9..0f2ed5b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -59,6 +59,8 @@ config X86
 	select ANON_INODES
 	select HAVE_ARCH_KMEMCHECK
 	select HAVE_USER_RETURN_NOTIFIER
+	select OF
+	select OF_FLATTREE
 
 config INSTRUCTION_DECODER
 	def_bool (KPROBES || PERF_EVENTS)
-- 
1.5.6.6



This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
