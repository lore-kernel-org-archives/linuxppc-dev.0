Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30E18C433F5
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Mar 2022 12:50:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4K7v9K0DDGz3dQb
	for <linuxppc-dev@archiver.kernel.org>; Wed,  2 Mar 2022 23:50:29 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4K7v543lKyz3bsq
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Mar 2022 23:46:48 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4K7v551swwz4xvR;
 Wed,  2 Mar 2022 23:46:49 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <20220215112858.304779-1-mpe@ellerman.id.au>
References: <20220215112858.304779-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/Makefile: Don't pass -mcpu=powerpc64 when
 building 32-bit
Message-Id: <164622491014.2052779.5949150542826181280.b4-ty@ellerman.id.au>
Date: Wed, 02 Mar 2022 23:41:50 +1100
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 15 Feb 2022 22:28:58 +1100, Michael Ellerman wrote:
> When CONFIG_GENERIC_CPU=y (true for all our defconfigs) we pass
> -mcpu=powerpc64 to the compiler, even when we're building a 32-bit
> kernel.
> 
> This happens because we have an ifdef CONFIG_PPC_BOOK3S_64/else block in
> the Makefile that was written before 32-bit supported GENERIC_CPU. Prior
> to that the else block only applied to 64-bit Book3E.
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/Makefile: Don't pass -mcpu=powerpc64 when building 32-bit
      https://git.kernel.org/powerpc/c/2863dd2db23e0407f6c50b8ba5c0e55abef894f1

cheers
