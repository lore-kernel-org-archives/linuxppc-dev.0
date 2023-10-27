Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06572C25B67
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Oct 2023 10:24:08 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SGzKf5B1Qz3wWR
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Oct 2023 21:24:06 +1100 (AEDT)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SGz234Vl5z3dLj
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Oct 2023 21:10:35 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SGz233KQ0z4xWS;
	Fri, 27 Oct 2023 21:10:35 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Stanislav Kinsburskii <skinsburskii@linux.microsoft.com>
In-Reply-To: <168155718437.13678.714141668943813263.stgit@skinsburskii.localdomain>
References: <168155718437.13678.714141668943813263.stgit@skinsburskii.localdomain>
Subject: Re: [PATCH 0/7] Expect immutable pointer in virt_to_phys/isa_virt_to_bus prototypes
Message-Id: <169840079674.2701453.2906749813304412928.b4-ty@ellerman.id.au>
Date: Fri, 27 Oct 2023 20:59:56 +1100
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
Cc: linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Sat, 15 Apr 2023 04:17:19 -0700, Stanislav Kinsburskii wrote:
> This series is aimed to address compilation warnings when a constant pointer
> is passed to virt_to_phys and isa_virt_to_bus functions:
> 
>   warning: passing argument 1 of ‘virt_to_phys’ discards ‘const’ qualifier from pointer target type
>   warning: passing argument 1 of ‘isa_virt_to_bus’ discards ‘const’ qualifier from pointer target type
> 
> The change(s) is the same for all architectures, but it's split into a series on
> per-arch basis to simplify applying and testing on the maintainers side.
> 
> [...]

Patch 6 applied to powerpc/next.

[6/7] powerpc: asm/io.h: Expect immutable pointer in virt_to_phys prototype
      https://git.kernel.org/powerpc/c/b28d1ccf921a4333be14017d82066386d419e638

cheers
