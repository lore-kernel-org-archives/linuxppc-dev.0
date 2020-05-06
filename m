Return-Path: <SRS0=xicG=6U=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD768C28CBC
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2020 06:34:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C70F206E6
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2020 06:34:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ellerman.id.au header.i=@ellerman.id.au header.b="WLZEwpJw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C70F206E6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 49H6JJ2D9XzDqsM
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 May 2020 16:34:24 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 49H62M1kYQzDqp7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 May 2020 16:22:19 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=WLZEwpJw; 
 dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 49H62K5cz7z9sRY;
 Wed,  6 May 2020 16:22:17 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1588746138;
 bh=G3Z6HoHYd6geL9nF1n1OLlMWHSetC862Eqtc2CC7NUY=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=WLZEwpJwZOMApJCIktUBNCy+p6Eatb3o9IoiUEO/FKw5eAaoXrKRUaD64xYH33Swd
 sCMVcHP9OpWt6cJJbMpCEYFjIHme9Xd0ujWyzQydQTBCnQtASeOYis6+p6HcWbGx8o
 h0YREBz/jeLf32TI2tRVwz2YHH8H7d6648dK0DyiQ3E4BVKBfw3ye2kDJJHQR5u/xK
 tuXlXKGbS/z/7c8xjfWSuZbPZKQ0mU6gqdX4E9fofiFDtGB/y8eJLD7pmKIe/1Yl/f
 jzErh5ITSr8IOeqOylK20G3hHBKdPC6zyMn/YyL7v2zJhUHU81nFQlkGXp49Ozkj3l
 tFVMTmvmXIaEA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Wolfram Sang <wsa@kernel.org>
Subject: Re: [PATCH] powerpc/5200: update contact email
In-Reply-To: <20200505160410.GH2468@ninjato>
References: <20200502142642.18979-1-wsa@kernel.org>
 <877dxsdl5e.fsf@mpe.ellerman.id.au> <20200505160410.GH2468@ninjato>
Date: Wed, 06 May 2020 16:22:33 +1000
Message-ID: <87imh9d1li.fsf@mpe.ellerman.id.au>
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
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Rob Herring <robh+dt@kernel.org>, Paul Mackerras <paulus@samba.org>,
 kernel@pengutronix.de, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Wolfram Sang <wsa@kernel.org> writes:
>> > My 'pengutronix' address is defunct for years. Merge the entries and use
>> > the proper contact address.
>> 
>> Is there any point adding the new address? It's just likely to bit-rot
>> one day too.
>
> At least, this one is a group address, not an individual one, so less
> likey.
>
>> I figure the git history is a better source for more up-to-date emails.
>
> But yes, can still be argued. I won't persist if you don't like it.

That's fine, I'll merge this. You've already gone to the trouble to send
it and it's better than what we have now.

cheers
