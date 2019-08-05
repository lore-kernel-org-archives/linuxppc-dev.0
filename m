Return-Path: <SRS0=0OA4=WB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 381E8C433FF
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Aug 2019 09:37:30 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4CA320B1F
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Aug 2019 09:37:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4CA320B1F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 462CNR6ycPzDqVV
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Aug 2019 19:37:27 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 462CL83Pd5zDq9y
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Aug 2019 19:35:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 462CL73Nknz9sDB;
 Mon,  5 Aug 2019 19:35:27 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] Please pull powerpc/linux.git powerpc-5.3-3 tag
In-Reply-To: <CAADWXX-B=twNfqs=2hbp0UFpnhqmUDMFZA3tjXFEjDp2dAD_YA@mail.gmail.com>
References: <87a7cpw3on.fsf@concordia.ellerman.id.au>
 <CAADWXX-B=twNfqs=2hbp0UFpnhqmUDMFZA3tjXFEjDp2dAD_YA@mail.gmail.com>
Date: Mon, 05 Aug 2019 19:35:25 +1000
Message-ID: <877e7svtsy.fsf@concordia.ellerman.id.au>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, santosh@fossix.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 lkml <linux-kernel@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 Christian Brauner <christian@brauner.io>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Linus Torvalds <torvalds@linux-foundation.org> writes:
> On Sun, Aug 4, 2019 at 4:49 AM Michael Ellerman <mpe@ellerman.id.au> wrote:
>>
>> Please pull some more powerpc fixes for 5.3:
>
> Hmm. This was caught by the gmail spam-filter for some reason. I don't
> see anything particularly different from your normal pull requests, so
> don't ask me why.
>
> The fact that you have no email authentication (dkim/spf/whatever) for
> your email address tends to make gmail more suspicious of emails, so
> it's probably then some random other pattern that just happened to
> trigger it.
>
> I do check my spam fairly religiously, so it's not like it's usually a
> problem - and I obviously marked it as ham to hopefully teach gmail
> the error of its ways. So this is just a heads up.

Thanks.

> But if you do have the possibility of enabling DKIM or similar on
> ellerman.id.au, then that is always a good thing, of course. I hate
> spam, even even if DKIM and friends certainly aren't perfect, they are
> better than nothing.

I'll talk to sfr about getting DKIM/SPF setup, he's the brains behind my
mail setup.

cheers
