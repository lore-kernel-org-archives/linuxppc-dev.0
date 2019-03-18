Return-Path: <SRS0=3pJc=RV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE53EC43381
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 09:56:51 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3EE212083D
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 09:56:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3EE212083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44NBRN3ckjzDqL0
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Mar 2019 20:56:48 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44NBPM5L6ZzDqJX
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Mar 2019 20:55:03 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 44NBPK6j9Tz9s5c;
 Mon, 18 Mar 2019 20:55:01 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Guenter Roeck <linux@roeck-us.net>,
 Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH] powerpc/6xx: fix setup and use of SPRN_PGDIR for hash32
In-Reply-To: <fac535c2-af61-1a1b-ebed-82ca0bd2e4a4@roeck-us.net>
References: <7e45ca3f0283fb24c2642e5b91bd75c55f2ba96f.1552028583.git.christophe.leroy@c-s.fr>
 <20190308160334.GZ3969@gate.crashing.org>
 <7681ad2b-35d4-6e43-f727-21545e3bb223@c-s.fr>
 <72bac00c-d2e3-515e-3ab1-99f20c058ea1@c-s.fr>
 <fac535c2-af61-1a1b-ebed-82ca0bd2e4a4@roeck-us.net>
Date: Mon, 18 Mar 2019 20:54:58 +1100
Message-ID: <87muls7bil.fsf@concordia.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Guenter Roeck <linux@roeck-us.net> writes:
> On 3/15/19 6:20 AM, Christophe Leroy wrote:
>> Michael,
>> 
>> Are you able to get this merged before 5.1-rc1 comes out ?
>
> Looks like this patch got lost. I don't see it in Michael's most recent
> pull request, the one that got merged today.

Sorry, will pick it up for fixes now.

cheers
