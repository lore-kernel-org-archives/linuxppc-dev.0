Return-Path: <SRS0=j/g1=IY=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42208C433C1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Mar 2021 11:16:15 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B5EF61A2D
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Mar 2021 11:16:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B5EF61A2D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4F6KCw1Pllz3c2h
	for <linuxppc-dev@archiver.kernel.org>; Fri, 26 Mar 2021 22:16:12 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=GoGD11Hh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ellerman.id.au (client-ip=203.11.71.1; helo=ozlabs.org;
 envelope-from=mpe@ellerman.id.au; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au
 header.a=rsa-sha256 header.s=201909 header.b=GoGD11Hh; 
 dkim-atps=neutral
Received: from ozlabs.org (ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F6KCT5Bvcz300J
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Mar 2021 22:15:48 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4F6KCP2c3Rz9sRf;
 Fri, 26 Mar 2021 22:15:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ellerman.id.au;
 s=201909; t=1616757347;
 bh=aRK3MQjYc8DtzjUuBc8xtlY540Ysa4fJ5l5A1e+TZmE=;
 h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
 b=GoGD11HhuUw1qdgZmx/Tgdnea2zeS5ZMScO9rFgOkLJo3r7GmMiXyNdzEQRXZV2u4
 FhsU9AtTulFd0yq/uSEpQ39ucW6ql6RSTMsDnN5f2xF+ulUWm4Z1Lp6AWJGr3mLJ9W
 fiRGCVkytIoHCXOzWXWFh2W3gULBzh4cJ/xhwFqCx3ls5POyNGqfBI+w67AKR01cOy
 YK6t6VBG9njhtzqlukRW6HRJ2SuU6ib8uZw2amcVGD3ecREBYCudiWZDXxt3569Kaj
 R3PQRp/bLooVYEwVxwhwcLFtS0RxzfQJVKzrxjcJcw1KLo2eS7FOP0vUxwcNaXr1lF
 N6SpcfH8RcKPA==
From: Michael Ellerman <mpe@ellerman.id.au>
To: He Ying <heying24@huawei.com>, benh@kernel.crashing.org,
 paulus@samba.org, corbet@lwn.net, ruscur@russell.cc, oohall@gmail.com,
 heying24@huawei.com
Subject: Re: [PATCH] docs: powerpc: Fix misspellings and grammar errors
In-Reply-To: <20210326100853.173586-1-heying24@huawei.com>
References: <20210326100853.173586-1-heying24@huawei.com>
Date: Fri, 26 Mar 2021 22:15:43 +1100
Message-ID: <878s6ago80.fsf@mpe.ellerman.id.au>
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

He Ying <heying24@huawei.com> writes:
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: He Ying <heying24@huawei.com>
> ---
>  Documentation/powerpc/booting.rst                | 2 +-
>  Documentation/powerpc/dawr-power9.rst            | 2 +-
>  Documentation/powerpc/eeh-pci-error-recovery.rst | 2 +-
>  Documentation/powerpc/elfnote.rst                | 2 +-
>  Documentation/powerpc/firmware-assisted-dump.rst | 2 +-
>  Documentation/powerpc/kaslr-booke32.rst          | 2 +-
>  Documentation/powerpc/mpc52xx.rst                | 2 +-
>  Documentation/powerpc/papr_hcalls.rst            | 4 ++--
>  Documentation/powerpc/transactional_memory.rst   | 4 ++--
>  9 files changed, 11 insertions(+), 11 deletions(-)

LGTM.

Acked-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
