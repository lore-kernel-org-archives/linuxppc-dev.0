Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CC46C48BF6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Feb 2024 06:02:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4TjqlG6mv3z3vZD
	for <linuxppc-dev@archiver.kernel.org>; Mon, 26 Feb 2024 17:02:18 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Tjqkn5ls9z3bT8
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 26 Feb 2024 17:01:53 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Tjqkj2kjBz4wcQ;
	Mon, 26 Feb 2024 17:01:49 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org, Geoff Levand <geoff@infradead.org>
In-Reply-To: <cover.1705654669.git.geoff@infradead.org>
References: <cover.1705654669.git.geoff@infradead.org>
Subject: Re: [PATCH 0/4] powerpc/ps3 Add ELFv2 support
Message-Id: <170892700815.3915597.9318219980822974261.b4-ty@ellerman.id.au>
Date: Mon, 26 Feb 2024 16:56:48 +1100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
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

On Fri, 19 Jan 2024 10:27:51 +0000, Geoff Levand wrote:
> The following changes since commit 44a1aad2fe6c10bfe0589d8047057b10a4c18a19:
> 
>   Merge branch 'topic/ppc-kvm' into next (2023-12-29 15:30:45 +1100)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/geoff/ps3-linux.git for-merge-elfv2
> 
> [...]

Patch 4 applied to powerpc/next.

[4/4] Revert "powerpc/ps3_defconfig: Disable PPC64_BIG_ENDIAN_ELF_ABI_V2"
      https://git.kernel.org/powerpc/c/914d081ead115f7ba685ab57f977716bdd09c894

cheers
