Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3351C433EF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 29 Jun 2022 22:14:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LYG2t3L7Nz3f2J
	for <linuxppc-dev@archiver.kernel.org>; Thu, 30 Jun 2022 08:14:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cdjrlc.com (client-ip=43.154.54.12; helo=smtpbg.qq.com; envelope-from=yuanjilin@cdjrlc.com; receiver=<UNKNOWN>)
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LY2GF5Cf0z3bmK
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2022 23:23:02 +1000 (AEST)
X-QQ-mid: bizesmtp65t1656508939tswi8yzf
Received: from localhost.localdomain ( [182.148.13.66])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 29 Jun 2022 21:22:16 +0800 (CST)
X-QQ-SSF: 0100000000200060C000C00A0000000
X-QQ-FEAT: MYl5Gn9dGPU8YT+5ZkHurVRhLXTgHvFsIdJfTPawL/dHrlkE8qf0Qiniuoycd
	nNDl6+vehW/6TLBcK88IN1vjdmaoTEnuOdasepYn3sTVu0x/uVnBfLwHZWf9usTRoWObYeT
	P8Cv66DMwdNgHkvxQ+xA4zhXqh7avupOTHKD7hQ5KBSu0qZK1P43HIPS2pxzj3OXgmvvfJ1
	e7WgNqIP6wmwUOwXIXhwdFEb8YBcA+c2rlDaIsYY7NXfbvbYrrMF07MNuS7S/4znWoLpyfu
	vFk5eVQRmbAOh5XgbQJEbtWghHK/+DwVtL1WakZLI9F39JJ+W0gmq92ed19SXuruvprg+52
	cbCxqNJ
X-QQ-GoodBg: 0
From: Jilin Yuan <yuanjilin@cdjrlc.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Subject: [PATCH] ethernet/ibm:fix repeated words in comments
Date: Wed, 29 Jun 2022 21:22:09 +0800
Message-Id: <20220629132209.30191-1-yuanjilin@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr4
X-Mailman-Approved-At: Thu, 30 Jun 2022 08:13:02 +1000
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
Cc: Jilin Yuan <yuanjilin@cdjrlc.com>, linux-kernel@vger.kernel.org, tlfalcon@linux.ibm.com, paulus@samba.org, drt@linux.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Delete the redundant word 'a'.

Signed-off-by: Jilin Yuan <yuanjilin@cdjrlc.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 7e7fe5bdf1f8..8ab326fdc3f5 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -3073,7 +3073,7 @@ static int ibmvnic_reset(struct ibmvnic_adapter *adapter,
 
 	/* If failover is pending don't schedule any other reset.
 	 * Instead let the failover complete. If there is already a
-	 * a failover reset scheduled, we will detect and drop the
+	 * failover reset scheduled, we will detect and drop the
 	 * duplicate reset when walking the ->rwi_list below.
 	 */
 	if (adapter->state == VNIC_REMOVING ||
-- 
2.36.1

