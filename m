Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17034C28D13
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Aug 2022 03:11:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4M8kDD65Xkz3dwl
	for <linuxppc-dev@archiver.kernel.org>; Sat, 20 Aug 2022 13:11:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=k1xq5LiW;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4M8kCT1Jcvz3bxt
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Aug 2022 13:10:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=k1xq5LiW;
	dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4M8kCR6KHTz4x1d;
	Sat, 20 Aug 2022 13:10:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1660965044;
	bh=VwNw6EZalUWQbeHPTHkC3NV0qlBnZ42I9JJo3ZONXB4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=k1xq5LiW3h2+xEFFGDP9ievLpuxz6DciTi4h5IYhmIChna2/fDmIv4Yxk2h8t4+Jv
	 L7c1M7aPiXsoGNfcYHftPGJsCvxaYI5bJNTxnJA2aWDToKG7I7eMqYveze/rE1GJgA
	 4XBF9E/cGwgm5UQCvpKNzn4iCS2kvLNbM/OTIkAAScDWQFxAdZ4gHq1dXctQzN+ub7
	 ok+xgpbWnaXMNABgrUwevMiAYalfA8vGz3clV7aZ9eWAqLtrJdWWCPMG6Bn/tFmOEd
	 fiHYN7dyPyk0KgiALNYqcR9BkVkN6YjEsPB751EmtjrR2CS0VUj6i2W2/MVtYVZU8f
	 6wt8b4VCRNEbA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] powerpc/boot: Convert more files to use SPDX tags
In-Reply-To: <Yv90ZxeQbf7smJCH@kroah.com>
References: <20220819110430.433984-1-mpe@ellerman.id.au>
 <Yv90ZxeQbf7smJCH@kroah.com>
Date: Sat, 20 Aug 2022 13:10:35 +1000
Message-ID: <87zgfzlidw.fsf@mpe.ellerman.id.au>
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
Cc: linux-spdx@vger.kernel.org, tglx@linutronix.de, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Greg KH <gregkh@linuxfoundation.org> writes:
> On Fri, Aug 19, 2022 at 09:04:30PM +1000, Michael Ellerman wrote:
>> These files are all plain GPL 2.0, with a second sentence about being
>> licensed as-is.
>> 
>> Similar to the rule in commit 577b61cee5b2 ("treewide: Replace GPLv2
>> boilerplate/reference with SPDX - gpl-2.0_398.RULE").
>> 
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>> ---
>>  arch/powerpc/boot/44x.h          | 5 +----
>>  arch/powerpc/boot/4xx.h          | 5 +----
>>  arch/powerpc/boot/ops.h          | 6 ++----
>>  arch/powerpc/boot/serial.c       | 6 ++----
>>  arch/powerpc/boot/simple_alloc.c | 6 ++----
>>  5 files changed, 8 insertions(+), 20 deletions(-)
>
>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Thanks.

> Do you want this to go through the SPDX tree, or will you route it
> through the normal ppc tree?  Either is fine with me, just let me know
> if you want me to take it in the SPDX tree.

I'll take it via powerpc, less likely to generate conflicts that way.

cheers
