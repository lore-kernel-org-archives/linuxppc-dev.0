Return-Path: <SRS0=3Onk=JS=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2B55C433ED
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Apr 2021 13:12:02 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16C826144A
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Apr 2021 13:12:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16C826144A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FQLYX3xrlz3d3y
	for <linuxppc-dev@archiver.kernel.org>; Wed, 21 Apr 2021 23:12:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.org (client-ip=2401:3900:2:1::2; helo=ozlabs.org;
 envelope-from=michael@ozlabs.org; receiver=<UNKNOWN>)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FQLVL4VNVz2yy9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Apr 2021 23:09:14 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4FQLVK4GTYz9vFX; Wed, 21 Apr 2021 23:09:13 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Ganesh Goudar <ganeshgr@linux.ibm.com>, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20210407045816.352276-1-ganeshgr@linux.ibm.com>
References: <20210407045816.352276-1-ganeshgr@linux.ibm.com>
Subject: Re: [PATCH] powerpc/mce: save ignore_event flag unconditionally for UE
Message-Id: <161901050296.1961279.14875938612170335400.b4-ty@ellerman.id.au>
Date: Wed, 21 Apr 2021 23:08:22 +1000
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
Cc: mahesh@linux.ibm.com, npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 7 Apr 2021 10:28:16 +0530, Ganesh Goudar wrote:
> When we hit an UE while using machine check safe copy routines,
> ignore_event flag is set and the event is ignored by mce handler,
> And the flag is also saved for defered handling and printing of
> mce event information, But as of now saving of this flag is done
> on checking if the effective address is provided or physical address
> is calculated, which is not right.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/mce: save ignore_event flag unconditionally for UE
      https://git.kernel.org/powerpc/c/92d9d61be519f32f16c07602db5bcbe30a0836fe

cheers
