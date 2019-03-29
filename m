Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 649D9C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 15:44:25 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D344F21871
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 15:44:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="COUVXzfE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D344F21871
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44W5dM0VHpzDqHb
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 02:44:23 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44W4Yn08r9zDqGh
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 01:56:13 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="COUVXzfE"; 
 dkim-atps=neutral
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 44W4Yk5VTqz8t23
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 01:56:10 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 44W4Yk3MsFz9sQq; Sat, 30 Mar 2019 01:56:10 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linuxfoundation.org
 (client-ip=198.145.29.99; helo=mail.kernel.org;
 envelope-from=gregkh@linuxfoundation.org; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=linuxfoundation.org
Authentication-Results: ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=kernel.org header.i=@kernel.org header.b="COUVXzfE"; 
 dkim-atps=neutral
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 44W4Yj6J0jz9sPx
 for <linuxppc-dev@ozlabs.org>; Sat, 30 Mar 2019 01:56:09 +1100 (AEDT)
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl
 [83.86.89.107])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 4B03F206C0;
 Fri, 29 Mar 2019 14:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1553871367;
 bh=GHfGzYVlAaMGZz/6quCZwbS7WPFGG1COHfF5mc4Sg6M=;
 h=Subject:To:Cc:From:Date:In-Reply-To:From;
 b=COUVXzfEFRWM2zIg6HrbP+WFettC08JbB4bS+ImdbRwAWqAeI71OS4mFkNH/UWt4r
 BdXgmUodK5Eeaz30Lh6r+A8gGNvDnlz94iktUSAudfPRcf7qF1AFctkvJRVw9Et+Vc
 c06IZUdc39QZcyGtJO/s5AYC2pkfLga7y3dPV0VA=
Subject: Patch "[PATCH stable v4.14 14/32] powerpc/fsl: Sanitize the syscall
 table for NXP PowerPC 32 bit platforms" has been added to the 4.14-stable
 tree
To: christophe.leroy@c-s.fr, diana.craciun@nxp.com, gregkh@linuxfoundation.org,
 linuxppc-dev@ozlabs.org, mpe@ellerman.id.au, msuchanek@suse.de
From: <gregkh@linuxfoundation.org>
Date: Fri, 29 Mar 2019 15:54:47 +0100
In-Reply-To: <20190329112620.14489-15-mpe@ellerman.id.au>
Message-ID: <155387128723537@kroah.com>
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

    [PATCH stable v4.14 14/32] powerpc/fsl: Sanitize the syscall table for NXP PowerPC 32 bit platforms

to the 4.14-stable tree which can be found at:
    http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary

The filename of the patch is:
     powerpc-fsl-sanitize-the-syscall-table-for-nxp-powerpc-32-bit-platforms.patch
and it can be found in the queue-4.14 subdirectory.

If you, or anyone else, feels it should not be added to the stable tree,
please let <stable@vger.kernel.org> know about it.


From foo@baz Fri Mar 29 15:53:50 CET 2019
From: Michael Ellerman <mpe@ellerman.id.au>
Date: Fri, 29 Mar 2019 22:26:02 +1100
Subject: [PATCH stable v4.14 14/32] powerpc/fsl: Sanitize the syscall table for NXP PowerPC 32 bit platforms
To: stable@vger.kernel.org, gregkh@linuxfoundation.org
Cc: linuxppc-dev@ozlabs.org, diana.craciun@nxp.com, msuchanek@suse.de, christophe.leroy@c-s.fr
Message-ID: <20190329112620.14489-15-mpe@ellerman.id.au>

From: Michael Ellerman <mpe@ellerman.id.au>

From: Diana Craciun <diana.craciun@nxp.com>

commit c28218d4abbf4f2035495334d8bfcba64bda4787 upstream.

Used barrier_nospec to sanitize the syscall table.

Signed-off-by: Diana Craciun <diana.craciun@nxp.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/powerpc/kernel/entry_32.S |   10 ++++++++++
 1 file changed, 10 insertions(+)

--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -33,6 +33,7 @@
 #include <asm/unistd.h>
 #include <asm/ptrace.h>
 #include <asm/export.h>
+#include <asm/barrier.h>
 
 /*
  * MSR_KERNEL is > 0x10000 on 4xx/Book-E since it include MSR_CE.
@@ -358,6 +359,15 @@ syscall_dotrace_cont:
 	ori	r10,r10,sys_call_table@l
 	slwi	r0,r0,2
 	bge-	66f
+
+	barrier_nospec_asm
+	/*
+	 * Prevent the load of the handler below (based on the user-passed
+	 * system call number) being speculatively executed until the test
+	 * against NR_syscalls and branch to .66f above has
+	 * committed.
+	 */
+
 	lwzx	r10,r10,r0	/* Fetch system call handler [ptr] */
 	mtlr	r10
 	addi	r9,r1,STACK_FRAME_OVERHEAD


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
