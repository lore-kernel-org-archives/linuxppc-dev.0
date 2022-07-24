Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BC0BC43334
	for <linuxppc-dev@archiver.kernel.org>; Sun, 24 Jul 2022 22:47:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lrdbj6LmXz3dsJ
	for <linuxppc-dev@archiver.kernel.org>; Mon, 25 Jul 2022 08:47:29 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=cdjrlc.com (client-ip=43.154.54.12; helo=smtpbg.qq.com; envelope-from=wangjianli@cdjrlc.com; receiver=<UNKNOWN>)
X-Greylist: delayed 113 seconds by postgrey-1.36 at boromir; Sun, 24 Jul 2022 16:31:48 AEST
Received: from smtpbg.qq.com (biz-43-154-54-12.mail.qq.com [43.154.54.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LrCxw3V1lz305c
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Jul 2022 16:31:43 +1000 (AEST)
X-QQ-mid: bizesmtp86t1658644169t732hzsm
Received: from localhost.localdomain ( [125.70.163.183])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 24 Jul 2022 14:29:27 +0800 (CST)
X-QQ-SSF: 01000000002000007000B00A0000000
X-QQ-FEAT: jTyhoG5kVjE+IMviPcyFbe8k8mPtdLra19VGuyaVGwYwIg9vuV5EXT6TvFo37
	MTgs92cNK4oES9V3yo35SOT5nmwPwEFMvqSrKEpPfFO9XZPg4kEM0SBftNl5BeE/K+kkocR
	gy094Nsxet9LYgRhvVJDqjQV0jTxUNqJnpFw30IEk6Ka25tKExZp3DpP0aqMx/Dm+zUZ3+X
	pcWXnRuSXzjZUCNZJLNHKzbCHZRFZNd0y5VwEtzVEaZhBSyYVpD5YeLsby9QtLIQ4YxU2P3
	u5E/F5FZ1XTRCZCcoGGRIKRvGtBSt667gyWfavwAq1c6XjgzspsxPmQxuylpcytVBeoIpek
	dv7rNduC27jQkLtABwq4LfP3/FAQA4aIrn01MQw
X-QQ-GoodBg: 0
From: wangjianli <wangjianli@cdjrlc.com>
To: mpe@ellerman.id.au,
	benh@kernel.crashing.org,
	paulus@samba.org,
	Julia.Lawall@inria.fr,
	liubo03@inspur.com
Subject: [PATCH] powerpc/kvm: fix repeated words in comments Delete the redundant word 'that'.
Date: Sun, 24 Jul 2022 14:29:20 +0800
Message-Id: <20220724062920.1551-1-wangjianli@cdjrlc.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:cdjrlc.com:qybglogicsvr:qybglogicsvr7
X-Mailman-Approved-At: Mon, 25 Jul 2022 08:46:47 +1000
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
Cc: wangjianli <wangjianli@cdjrlc.com>, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Signed-off-by: wangjianli <wangjianli@cdjrlc.com>
---
 arch/powerpc/kvm/book3s_64_mmu_hv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
index 514fd45c1994..73c6db20cd8a 100644
--- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
+++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
@@ -1601,7 +1601,7 @@ long kvm_vm_ioctl_resize_hpt_commit(struct kvm *kvm,
  * is valid, it is written to the HPT as if an H_ENTER with the
  * exact flag set was done.  When the invalid count is non-zero
  * in the header written to the stream, the kernel will make
- * sure that that many HPTEs are invalid, and invalidate them
+ * sure that many HPTEs are invalid, and invalidate them
  * if not.
  */
 
-- 
2.36.1

