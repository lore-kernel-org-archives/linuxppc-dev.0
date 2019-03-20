Return-Path: <SRS0=4bR/=RX=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3374C43381
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 12:45:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 505C7213F2
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 12:45:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 505C7213F2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44PV5C2CJbzDqM6
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 Mar 2019 23:45:35 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44PV1n31x0zDqMX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Mar 2019 23:42:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44PV1l1ChVz9sP7;
 Wed, 20 Mar 2019 23:42:34 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Qian Cai <cai@lca.pw>, Christophe Leroy <christophe.leroy@c-s.fr>,
 benh@kernel.crashing.org, paulus@samba.org
Subject: Re: [RESEND PATCH v2] powerpc: mute unused-but-set-variable warnings
In-Reply-To: <b3e7d016-74ca-aaaa-02e7-39fbc2200013@lca.pw>
References: <20190317220516.92654-1-cai@lca.pw>
 <1ffdc5ae-2d5f-6c81-3997-0e6c81c67516@c-s.fr>
 <b3e7d016-74ca-aaaa-02e7-39fbc2200013@lca.pw>
Date: Wed, 20 Mar 2019 23:42:11 +1100
Message-ID: <877ectzpi4.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Qian Cai <cai@lca.pw> writes:
> On 3/19/19 5:21 AM, Christophe Leroy wrote:
>> Is there a reason for resending ? AFAICS, both are identical and still marked
>> new in patchwork:
>> https://patchwork.ozlabs.org/project/linuxppc-dev/list/?submitter=76055
>> 
>
> "RESEND" because of no maintainer response for more than one week.

I don't know who told you to RESEND after a week, but especially at this
point in the development cycle a week is *way* too short.

And for trivial patches like this I may not get to them for several
weeks, I have other problems to fix like time going backward :)

In future please check patchwork and then if the patch is still new
after several weeks just send a ping in reply to that patch. A full
RESEND means I now have two identical patches to deal with in patchwork,
which makes more work for me.

cheers
