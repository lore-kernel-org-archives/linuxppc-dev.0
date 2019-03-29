Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D5F6C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 15:48:09 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADBDD21871
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 15:48:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="TX0iOggF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADBDD21871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44W5jd5Q4hzDqSV
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 02:48:05 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44W4Ys163pzDqQh
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 01:56:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="TX0iOggF"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44W4Yr6qSrz8t23
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 01:56:16 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44W4Yr6Q6Cz9sQq; Sat, 30 Mar 2019 01:56:16 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="TX0iOggF"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44W4Yr2s0Wz9sPx
 for <linuxppc-dev@ozlabs.org>; Sat, 30 Mar 2019 01:56:16 +1100 (AEDT)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C1DB82184C;
 Fri, 29 Mar 2019 14:56:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1553871374;
 bh=nqd2yJFaHnL4GaK13NyxLvaFXoCyL0q/FTz80XAl+C0=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=TX0iOggFGZ6lyjU0kdqbu4GM4DcBmxZG7tPLa7hOBI26FF9Vh9WLOmM52+qxFhEDo
 FP/LSIdNIKNvPqDtRx+zvsyEijx8KKcJBajpBeCvxV9A0x86XzgS4LTOPm6ZQfTNJS
 P8CN5JKp0dQQMVGeQhhk53XXvCJ11WKFsD1yoUFI=
Subject: Patch "[PATCH stable v4.14 23/32] powerpc/fsl: Emulate SPRN_BUCSR
 register" has been added to the 4.14-stable tree
To: christophe.leroy@c-s.fr, diana.craciun@nxp.com, gregkh@linuxfoundation.org,
 linuxppc-dev@ozlabs.org, mpe@ellerman.id.au, msuchanek@suse.de
From: <gregkh@linuxfoundation.org>
Date: Fri, 29 Mar 2019 15:54:47 +0100
In-Reply-To: <20190329112620.14489-24-mpe@ellerman.id.au>
Message-ID: <155387128711464@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-stable: commit
X-Patchwork-Hint: ignore 
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
Cc: stable-commits@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>


This is a note to let you know that I've just added the patch titled

    [PATCH stable v4.14 23/32] powerpc/fsl: Emulate SPRN_BUCSR register

to the 4.14-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     powerpc-fsl-emulate-sprn_bucsr-register.patch
and it can be found in the queue-4.14 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From foo@baz Fri Mar 29 15:53:50 CET 2019
From: Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 29 Mar 2019 22:26:11 +1100
Subject: [PATCH stable v4.14 23/32] powerpc/fsl: Emulate SPRN_BUCSR register
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: linuxppc-dev@ozlabs.org, diana.craciun@nxp.com, msuchanek@suse.de, christophe.leroy@c-s.fr
Message-ID: <20190329112620.14489-24-mpe@ellerman.id.au>

From: Michael Ellerman <mpe@ellerman.id.au>

From: Diana Craciun <diana.craciun@nxp.com>

commit 98518c4d8728656db349f875fcbbc7c126d4c973 upstream.

In order to flush the branch predictor the guest kernel performs
writes to the BUCSR register which is hypervisor privilleged. However,
the branch predictor is flushed at each KVM entry, so the branch
predictor has been already flushed, so just return as soon as possible
to guest.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
[mpe: Tweak comment formatting]
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kvm/e500_emulate.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/arch/powerpc/kvm/e500_emulate.c
+++ b/arch/powerpc/kvm/e500_emulate.c
@@ -277,6 +277,13 @@ int kvmppc_core_emulate_mtspr_e500(struc
 		vcpu->arch.pwrmgtcr0 = spr_val;
 		break;
 
+	case SPRN_BUCSR:
+		/*
+		 * If we are here, it means that we have already flushed the
+		 * branch predictor, so just return to guest.
+		 */
+		break;
+
 	/* extra exceptions */
 #ifdef CONFIG_SPE_POSSIBLE
 	case SPRN_IVOR32:


Patches currently in stable-queue which might be from mpe@ellerman.id.au are

queue-4.14/powerpc-fsl-emulate-sprn_bucsr-register.patch
queue-4.14/powerpc-64-make-stf-barrier-ppc_book3s_64-specific.patch
queue-4.14/powerpc-fsl-fix-spectre_v2-mitigations-reporting.patch
queue-4.14/powerpc-64s-patch-barrier_nospec-in-modules.patch
queue-4.14/powerpc-pseries-query-hypervisor-for-count-cache-flush-settings.patch
queue-4.14/powerpc-64s-add-support-for-software-count-cache-flush.patch
queue-4.14/powerpc64s-show-ori31-availability-in-spectre_v1-sysfs-file-not-v2.patch
queue-4.14/powerpc-fsl-flush-the-branch-predictor-at-each-kernel-entry-64bit.patch
queue-4.14/powerpc-fsl-update-spectre-v2-reporting.patch
queue-4.14/powerpc-64-make-meltdown-reporting-book3s-64-specific.patch
queue-4.14/powerpc-64s-add-support-for-ori-barrier_nospec-patching.patch
queue-4.14/powerpc-use-barrier_nospec-in-copy_from_user.patch
queue-4.14/powerpc-fsl-sanitize-the-syscall-table-for-nxp-powerpc-32-bit-platforms.patch
queue-4.14/powerpc-fsl-add-macro-to-flush-the-branch-predictor.patch
queue-4.14/powerpc-fsl-add-barrier_nospec-implementation-for-nxp-powerpc-book3e.patch
queue-4.14/powerpc-security-fix-spectre_v2-reporting.patch
queue-4.14/powerpc-64-disable-the-speculation-barrier-from-the-command-line.patch
queue-4.14/powerpc-fsl-fix-the-flush-of-branch-predictor.patch
queue-4.14/powerpc-64-add-config_ppc_barrier_nospec.patch
queue-4.14/powerpc-fsl-enable-runtime-patching-if-nospectre_v2-boot-arg-is-used.patch
queue-4.14/powerpc-64-use-barrier_nospec-in-syscall-entry.patch
queue-4.14/powerpc-fsl-fixed-warning-orphan-section-__btb_flush_fixup.patch
queue-4.14/powerpc-fsl-add-nospectre_v2-command-line-argument.patch
queue-4.14/powerpc-64s-add-new-security-feature-flags-for-count-cache-flush.patch
queue-4.14/powerpc-fsl-add-infrastructure-to-fixup-branch-predictor-flush.patch
queue-4.14/powerpc-64s-enhance-the-information-in-cpu_show_spectre_v1.patch
queue-4.14/powerpc-64-call-setup_barrier_nospec-from-setup_arch.patch
queue-4.14/powerpc-asm-add-a-patch_site-macro-helpers-for-patching-instructions.patch
queue-4.14/powerpc-fsl-flush-the-branch-predictor-at-each-kernel-entry-32-bit.patch
queue-4.14/powerpc-64s-enable-barrier_nospec-based-on-firmware-settings.patch
queue-4.14/powerpc-fsl-flush-branch-predictor-when-entering-kvm.patch
queue-4.14/powerpc-powernv-query-firmware-for-count-cache-flush-settings.patch
