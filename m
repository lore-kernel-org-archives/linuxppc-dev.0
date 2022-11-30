Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7533DC433FE
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Nov 2022 09:48:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4NMZCH0Mhrz3h1V
	for <linuxppc-dev@archiver.kernel.org>; Wed, 30 Nov 2022 20:48:27 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4NMYth6c2Nz3fQC
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2022 20:34:04 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4NMYtg6NjXz4xV1;
	Wed, 30 Nov 2022 20:34:03 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>, Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <20221010165721.106267e6@canb.auug.org.au>
References: <20221010165721.106267e6@canb.auug.org.au>
Subject: Re: [PATCH] powerpc: suppress some linker warnings in recent linker versions
Message-Id: <166980024734.3017288.12071068399388319871.b4-ty@ellerman.id.au>
Date: Wed, 30 Nov 2022 20:24:07 +1100
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
Cc: PowerPC <linuxppc-dev@lists.ozlabs.org>, Joel Stanley <joel@jms.id.au>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 10 Oct 2022 16:57:21 +1100, Stephen Rothwell wrote:
> This is a follow on from commit
> 
>   0d362be5b142 ("Makefile: link with -z noexecstack --no-warn-rwx-segments")
> 
> for arch/powerpc/boot to address wanrings like:
> 
>   ld: warning: opal-calls.o: missing .note.GNU-stack section implies executable stack
>   ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
>   ld: warning: arch/powerpc/boot/zImage.epapr has a LOAD segment with RWX permissions
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: suppress some linker warnings in recent linker versions
      https://git.kernel.org/powerpc/c/579aee9fc594af94c242068c011b0233563d4bbf

cheers
