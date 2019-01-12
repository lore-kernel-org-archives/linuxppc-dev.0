Return-Path: <SRS0=eeko=PU=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03198C43387
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 16:23:33 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EC992084C
	for <linuxppc-dev@archiver.kernel.org>; Sat, 12 Jan 2019 16:23:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EC992084C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gmx.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43cQ5Z0GrQzDqv4
	for <linuxppc-dev@archiver.kernel.org>; Sun, 13 Jan 2019 03:23:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmx.net
 (client-ip=212.227.15.19; helo=mout.gmx.net;
 envelope-from=j.neuschaefer@gmx.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=gmx.net
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43cQ3n5NQ3zDr7s
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 13 Jan 2019 03:21:57 +1100 (AEDT)
Received: from longitude ([109.90.232.48]) by mail.gmx.com (mrgmx003
 [212.227.17.190]) with ESMTPSA (Nemesis) id 0MBnSJ-1gaPh72NSJ-00AklE; Sat, 12
 Jan 2019 17:21:38 +0100
From: =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc: wii.dts: Add interrupt-related properties to
 GPIO node
Date: Sat, 12 Jan 2019 17:21:23 +0100
Message-Id: <20190112162124.3341-2-j.neuschaefer@gmx.net>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190112162124.3341-1-j.neuschaefer@gmx.net>
References: <20190112162124.3341-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:82L0IR9jKPSYd1BuEFVjgfSHjYwwjso1XFHSvChA0sOM6QCIyo1
 H224qYhxPCJdK7yqmMJGXIi0rEaVu2nT3CF6DXVMIwkODaTPVSJrMxBKkHDuQ1ohmse//B5
 4NmSuIKAuZ+Qxu059NhyDensYZYyT1HR5/j5r7ZMXKOP4i0sgLft4rVOBm1VfYDSpjaIk+F
 MljUthAC/zzHfuwYn03zg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AUQHPoYqtXI=:PVqB6X1Terxciex+jM0O0g
 7TKMrqdlisjQ6ad5ttlx14Ds1u4btr2ls320sAfoh3a+No56B2rW9JdMuBYeDy6tK/t+niGMq
 J/XBxBM+eetfZWQVTpjozbOd06o89c9k8ZZnl6ieUGyaf2B19AderNc2WMGWVo44Jl3Lzg5ix
 wI307/gZeOB2Fh43FIPbv+IsUrQFplMqjqyWrTou4WK3r0M8zx2h38EpdvJOvcX07/bfn2QsL
 899x3fdu25mBrWEpqY/X8aaE0th/QsItH7PpJNIVq5wzDmrRSBGi8uXGjBZK23ORTErySx4mK
 VzZhXFi/D1FXlKYvOe5LcTNVX788wk6Sv5VaCEOCcMaXtJtf/z2vTiHaTA+/cqT2t2VPb2Gt2
 QNaTkH3UHPjGLBD91IjNAy+x2iObVPbpqminkuK/ln3y7HG8H0AnlHYGHwuuf2w7z6/dcsNI1
 otu3g3/q84tOsPgm1RdCZcwMfqmUui0gubV1YSV7B3Lhq/7NCORmvbCVEwXWxaF4gojNh3ukN
 E8y145ffSLLMz6uSlZBtPota8v/1nV41sP4dfjxBg1nklnd9IYVDqGoUUIo5F9wWTd/B94OaU
 VuvK3tdiieGkBrprgsujJzjgOyp4dUQaZFNyUne0w6jh6xV8ovEK0U1tOD4zQNx8y3BaytO3F
 4ytag3mSRv728eKACBW+1iSEsFl+ubW3J4tZ3raphogvhqrY48Uaoqnw22JcxIDiM8MyWb1Yt
 Nwpulh79EvWkksa8Zi0bjVZfO4G6CyWatuhF+ZTIHIS+I2WLTHtSQp7n3iHuXqQ7ytoMTlm4j
 yNOEw7Kfp57qhkr6ba+aOAX8xMrkn2AsiwPvXG5Nry9MyS7fOVrQlmR/mJ9mG/NFthGvw9TIS
 M3Q+zIYWcNKsgd5LbB6YQYQzCY20fcZPHwwgRG2aLolRqgVrTztn4PMymULebXdW02OaEyV72
 NW2F287DCEQ==
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
Cc: Mark Rutland <mark.rutland@arm.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 =?UTF-8?q?Jonathan=20Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
 Rob Herring <robh+dt@kernel.org>, Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The Hollywood GPIO controller is connected to the Hollywood PIC (&PIC1)
at IRQs 10 and 11; IRQ 10 for GPIO lines that are configured for access
by the PPC, 11 for GPIO lines that are configured for access by the
ARM926.

Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
---
 arch/powerpc/boot/dts/wii.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/powerpc/boot/dts/wii.dts b/arch/powerpc/boot/dts/wii.dts
index 40fe791ec9e6..864e5a17aa1d 100644
--- a/arch/powerpc/boot/dts/wii.dts
+++ b/arch/powerpc/boot/dts/wii.dts
@@ -187,6 +187,11 @@
 				"DEBUG0", "DEBUG1", "DEBUG2", "DEBUG3",
 				"DEBUG4", "DEBUG5", "DEBUG6", "DEBUG7";
 
+			interrupt-controller;
+			#interrupt-cells = <2>;
+			interrupts = <10>;
+			interrupt-parent = <&PIC1>;
+
 			/*
 			 * This is commented out while a standard binding
 			 * for i2c over gpio is defined.
-- 
2.20.1

