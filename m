Return-Path: <SRS0=d/0/=NJ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C89DC4338F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Aug 2021 13:47:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96DF86108F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Aug 2021 13:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 96DF86108F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4GqTjJ2Vmyz3cPP
	for <linuxppc-dev@archiver.kernel.org>; Wed, 18 Aug 2021 23:47:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with UTF8SMTPS id 4GqTgp0h9Jz3cLf
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Aug 2021 23:45:58 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4GqTgn150Yz9sX5; Wed, 18 Aug 2021 23:45:57 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Cédric Le Goater <clg@kaod.org>
In-Reply-To: <20210720134209.256133-1-clg@kaod.org>
References: <20210720134209.256133-1-clg@kaod.org>
Subject: Re: [PATCH 0/2] KVM: PPC: Book3S HV: XIVE: Improve guest entries and
 exits
Message-Id: <162929391725.3619265.6275894105335009777.b4-ty@ellerman.id.au>
Date: Wed, 18 Aug 2021 23:38:37 +1000
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
Cc: Paul Mackerras <paulus@samba.org>, kvm-ppc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 20 Jul 2021 15:42:07 +0200, Cédric Le Goater wrote:
> The XIVE interrupt controller on P10 can automatically save and
> restore the state of the interrupt registers under the internal NVP
> structure representing the VCPU. This saves a costly store/load in
> guest entries and exits.
> 
> Thanks,
> 
> [...]

Applied to powerpc/next.

[1/2] KVM: PPC: Book3S HV: XIVE: Add a 'flags' field
      https://git.kernel.org/powerpc/c/b68c6646cce5ee8caefa6333ee743f960222dcea
[2/2] KVM: PPC: Book3S HV: XIVE: Add support for automatic save-restore
      https://git.kernel.org/powerpc/c/f5af0a978776b710f16dc99a85496b1e760bf9e0

cheers
