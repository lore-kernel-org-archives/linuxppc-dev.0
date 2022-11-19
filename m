Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADFAEC433FE
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Nov 2022 11:33:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NDs3r2QnWz3f5n
	for <linuxppc-dev@archiver.kernel.org>; Sat, 19 Nov 2022 22:33:44 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=heyquark.com (client-ip=217.70.183.199; helo=relay9-d.mail.gandi.net; envelope-from=ash@heyquark.com; receiver=<UNKNOWN>)
X-Greylist: delayed 75 seconds by postgrey-1.36 at boromir; Sat, 19 Nov 2022 22:32:26 AEDT
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NDs2L5sZJz3ccn
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Nov 2022 22:32:26 +1100 (AEDT)
Received: (Authenticated sender: ash@heyquark.com)
	by mail.gandi.net (Postfix) with ESMTPSA id B1936FF803;
	Sat, 19 Nov 2022 11:32:16 +0000 (UTC)
From: Ash Logan <ash@heyquark.com>
To: krzysztof.kozlowski+dt@linaro.org,
	paulus@samba.org,
	mpe@ellerman.id.au,
	christophe.leroy@csgroup.eu,
	robh+dt@kernel.org,
	benh@kernel.crashing.org,
	segher@kernel.crashing.org,
	pali@kernel.org
Subject: [PATCH v4 11/11] powerpc: wiiu: add minimal default config
Date: Sat, 19 Nov 2022 22:30:41 +1100
Message-Id: <20221119113041.284419-12-ash@heyquark.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221119113041.284419-1-ash@heyquark.com>
References: <20220628133144.142185-1-ash@heyquark.com>
 <20221119113041.284419-1-ash@heyquark.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, linkmauve@linkmauve.fr, linux-kernel@vger.kernel.org, rw-r-r-0644@protonmail.com, joel@jms.id.au, linuxppc-dev@lists.ozlabs.org, j.ne@posteo.net
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Adds a bare-minimum config to get a kernel compiled. Will need some more
interesting options once a storage device to boot from is added.

Signed-off-by: Ash Logan <ash@heyquark.com>
---
 arch/powerpc/configs/wiiu_defconfig | 7 +++++++
 1 file changed, 7 insertions(+)
 create mode 100644 arch/powerpc/configs/wiiu_defconfig

diff --git a/arch/powerpc/configs/wiiu_defconfig b/arch/powerpc/configs/wiiu_defconfig
new file mode 100644
index 000000000000..a761ebcdd9f2
--- /dev/null
+++ b/arch/powerpc/configs/wiiu_defconfig
@@ -0,0 +1,7 @@
+# CONFIG_PPC_CHRP is not set
+# CONFIG_PPC_PMAC is not set
+CONFIG_WIIU=y
+# CONFIG_PPC_OF_BOOT_TRAMPOLINE is not set
+CONFIG_HIGHMEM=y
+CONFIG_STRICT_KERNEL_RWX=y
+CONFIG_PPC_EARLY_DEBUG=y
-- 
2.38.1

