Return-Path: <michael@ozlabs.org>
From: Michael Ellerman <michael@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Subject: [PATCH] powerpc: Turn on BPF_JIT in ppc64_defconfig
Date: Fri, 22 Jun 2012 13:52:29 +1000
Message-Id: <1340337149-22384-1-git-send-email-michael@ellerman.id.au>
Cc: matt@ozlabs.org, amodra@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Matt added BPF_JIT support in commit 0ca87f05, but currently none of our
defconfigs build it. Turn that sucker on.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/configs/ppc64_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index c1442a3..a637ee7 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -489,3 +489,4 @@ CONFIG_VIRTUALIZATION=y
 CONFIG_KVM_BOOK3S_64=m
 CONFIG_KVM_BOOK3S_64_HV=y
 CONFIG_VHOST_NET=m
+CONFIG_BPF_JIT=y
-- 
1.7.9.5
