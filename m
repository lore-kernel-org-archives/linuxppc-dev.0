Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27E38C433EF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jun 2022 10:08:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LSfGH3G5fz3brl
	for <linuxppc-dev@archiver.kernel.org>; Wed, 22 Jun 2022 20:08:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=lnPWueoR;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LSfFf29Bzz2xKf
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2022 20:07:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=lnPWueoR;
	dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4LSfFf18HYz4xYD;
	Wed, 22 Jun 2022 20:07:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1655892454;
	bh=l+iD2EE6xQv33e0wnmJmpDsfWmvcHiLJ9x1/wjMu/js=;
	h=From:To:Subject:In-Reply-To:References:Date:From;
	b=lnPWueoRRMEnfgsD/pfCyaT7aiyyg2E/r0KEy9aIqpx9Dk0uuu0CPzTb7fSFEsljX
	 etLMMS0UV6jB3go6dIeMeP0Rcl6zx2VFO+4WImVDrFWE7lPjQBZtq9o66ebc5/fVk2
	 T0dojbYhZo/TkB068Q3sAjJceOJ6gdwSUTQ4rNSJ2pURHk9O+PiHHEPie+fHvLh41O
	 PY0gPtUltJIbdES1Yon6c5WUJtAZCaZ5uN3scpSzX5d0RYySEvtjbmA+oX3CDtrmvy
	 PJtevsQBVvIsoz2oEZvKMMgcEWtKfrNGAox7C9aWsauNCz2ZjBLC9Rmqi23xvcdxNY
	 aC+oJMIHQj1Fw==
From: Michael Ellerman <mpe@ellerman.id.au>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerc: Update asm-prototypes.h comment
In-Reply-To: <da25a411031208310b63dd652a9ae5a2e65c037a.camel@russell.cc>
References: <20220617080243.2177583-1-mpe@ellerman.id.au>
 <da25a411031208310b63dd652a9ae5a2e65c037a.camel@russell.cc>
Date: Wed, 22 Jun 2022 20:07:32 +1000
Message-ID: <875yktypsr.fsf@mpe.ellerman.id.au>
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Russell Currey <ruscur@russell.cc> writes:
> On Fri, 2022-06-17 at 18:02 +1000, Michael Ellerman wrote:
>> This header was recently cleaned up in commit 76222808fc25 ("powerpc:
>> Move C prototypes out of asm-prototypes.h"), update the comment to
>> reflect it's proper purpose.
>> 
>> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
>
> Hi Michael, subject says "powerc" instead of "powerpc".

Thanks.

I actually do have a script that checks for that, although I don't
always remember to run it :}

cheers
