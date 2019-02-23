Return-Path: <SRS0=sHkL=Q6=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F2DBC10F00
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Feb 2019 03:18:36 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAE92206A3
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Feb 2019 03:18:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAE92206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 445thV0k8CzDqX7
	for <linuxppc-dev@archiver.kernel.org>; Sat, 23 Feb 2019 14:18:34 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 445tfC5XvHzDqXd
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Feb 2019 14:16:35 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 445tfC3S7yz9s71;
 Sat, 23 Feb 2019 14:16:35 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Sasha Levin <sashal@kernel.org>, Sasha Levin <sashal@kernel.org>,
 Russell Currey <ruscur@russell.cc>, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH] powerpc/kvm: Save and restore AMR instead of zeroing
In-Reply-To: <20190222152432.A27CA2070D@mail.kernel.org>
References: <20190220045958.14966-1-ruscur@russell.cc>
 <20190222152432.A27CA2070D@mail.kernel.org>
Date: Sat, 23 Feb 2019 14:16:35 +1100
Message-ID: <87o973kxd8.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
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
Cc: linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Sasha Levin <sashal@kernel.org> writes:
> Hi,
>
> [This is an automated email]
>
> This commit has been processed because it contains a "Fixes:" tag,
> fixing commit: cf43d3b26452 powerpc: Enable pkey subsystem.
>
> The bot has tested the following trees: v4.20.11, v4.19.24.
>
> v4.19.24: Failed to apply! Possible dependencies:
>     41f4e631daf8 ("KVM: PPC: Book3S HV: Extract PMU save/restore operations as C-callable functions")
>     95a6432ce903 ("KVM: PPC: Book3S HV: Streamlined guest entry/exit path on P9 for radix guests")
>     d24ea8a7336a ("KVM: PPC: Book3S: Simplify external interrupt handling")
>     df709a296ef7 ("KVM: PPC: Book3S HV: Simplify real-mode interrupt handling")
>     f7035ce9f1df ("KVM: PPC: Book3S HV: Move interrupt delivery on guest entry to C code")
>
>
> How should we proceed with this patch?

Ignore it. The patch needs more work.

cheers
