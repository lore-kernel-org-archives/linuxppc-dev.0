Return-Path: <SRS0=o3RY=O7=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D1FCC433FE
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Oct 2021 12:11:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D017C60F57
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Oct 2021 12:11:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D017C60F57
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HSd1j4Db8z3dj4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 11 Oct 2021 23:11:21 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org
 [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HScxn1DDvz2yw7
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Oct 2021 23:07:57 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4HScxn0VBMz4xqT;
 Mon, 11 Oct 2021 23:07:57 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Nathan Lynch <nathanl@linux.ibm.com>
In-Reply-To: <20210928214147.312412-1-nathanl@linux.ibm.com>
References: <20210928214147.312412-1-nathanl@linux.ibm.com>
Subject: Re: [PATCH v2 0/2] powerpc/paravirt: vcpu_is_preempted() tweaks
Message-Id: <163395400924.4094789.17078523956784942222.b4-ty@ellerman.id.au>
Date: Mon, 11 Oct 2021 23:06:49 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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
Cc: srikar@linux.vnet.ibm.com, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 28 Sep 2021 16:41:45 -0500, Nathan Lynch wrote:
> Minor changes arising from discovering that this code throws warnings with
> DEBUG_PREEMPT kernels.
> 
> Changes since v1:
> * Additional commentary to (1) distinguish hypervisor dispatch and preempt
>   behavior from kernel scheduler preemption; and (2) more clearly justify
>   the use of raw_smp_processor_id().
> * Additional patch to update existing comments before making the functional
>   change.
> 
> [...]

Applied to powerpc/next.

[1/2] powerpc/paravirt: vcpu_is_preempted() commentary
      https://git.kernel.org/powerpc/c/799f9b51db688608b50e630a57bee5f699b268ca
[2/2] powerpc/paravirt: correct preempt debug splat in vcpu_is_preempted()
      https://git.kernel.org/powerpc/c/fda0eb220021a97c1d656434b9340ebf3fc4704a

cheers
