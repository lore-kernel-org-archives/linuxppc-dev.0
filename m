Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E775C433FE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Nov 2022 09:41:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NMZ2z6dYQz3fdG
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Nov 2022 20:41:15 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NMYqs5F85z30F7
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2022 20:31:37 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4NMYqs3tjNz4xV1;
	Wed, 30 Nov 2022 20:31:37 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Joel Stanley <joel@jms.id.au>, linuxppc-dev@lists.ozlabs.org
In-Reply-To: <20220930065012.2860577-1-joel@jms.id.au>
References: <20220930065012.2860577-1-joel@jms.id.au>
Subject: Re: [PATCH v2] powerpc/microwatt: Add litesd
Message-Id: <166980024344.3017288.952556883567387271.b4-ty@ellerman.id.au>
Date: Wed, 30 Nov 2022 20:24:03 +1100
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
Cc: Jeremy Kerr <jk@codeconstruct.com.au>, Matt Johnston <matt@codeconstruct.com.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 30 Sep 2022 16:20:12 +0930, Joel Stanley wrote:
> This is the register layout of the litesd peripheral for the fusesoc
> based Microwatt SoC.
> 
> It requires a description of the system clock, which is hardcoded to
> 100MHz.
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/microwatt: Add litesd
      https://git.kernel.org/powerpc/c/5825603f67bc5ff445a1847302884154f0afa627

cheers
