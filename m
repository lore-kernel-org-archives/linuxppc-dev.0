Return-Path: <SRS0=6gsd=N2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5126C43441
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 12:50:14 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F0AC20869
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 12:50:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F0AC20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42wh6D2r6gzF3dT
	for <linuxppc-dev@archiver.kernel.org>; Thu, 15 Nov 2018 23:50:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42wh1X5D5DzF3dT
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Nov 2018 23:46:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPSA id 42wh1W4Jhqz9s9G;
 Thu, 15 Nov 2018 23:46:07 +1100 (AEDT)
Authentication-Results: ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
From: Michael Ellerman <mpe@ellerman.id.au>
To: Joel Stanley <joel@jms.id.au>, Oliver O'Halloran <oohall@gmail.com>
Subject: Re: [PATCH] powerpc/powernv: Remove PCI_MSI ifdef checks
In-Reply-To: <CACPK8XdtCZFM1WC+Lnku5rZ5ZwNZRV9NnFc6nSJMdYiVsCqt2g@mail.gmail.com>
References: <20181114061958.3462-1-oohall@gmail.com>
 <CACPK8XdtCZFM1WC+Lnku5rZ5ZwNZRV9NnFc6nSJMdYiVsCqt2g@mail.gmail.com>
Date: Thu, 15 Nov 2018 23:46:07 +1100
Message-ID: <87zhuatsog.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Joel Stanley <joel@jms.id.au> writes:

> On Wed, 14 Nov 2018 at 16:50, Oliver O'Halloran <oohall@gmail.com> wrote:
>>
>> CONFIG_PCI_MSI was made mandatory by commit a311e738b6d8
>> ("powerpc/powernv: Make PCI non-optional") so the #ifdef
>> checks around CONFIG_PCI_MSI here can be removed entirely.
>>
>> Signed-off-by: Oliver O'Halloran <oohall@gmail.com>
>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
>
> Can we do the same to the CONFIG_PCI_MSI in
> arch/powerpc/sysdev/xics/ics-opal.c ?

Yes.

cheers
