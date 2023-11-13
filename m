Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F34DBC4332F
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Nov 2023 02:50:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4STDSB3X77z3dKq
	for <linuxppc-dev@archiver.kernel.org>; Mon, 13 Nov 2023 13:50:18 +1100 (AEDT)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4STDR86TVkz2ytV
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Nov 2023 13:49:24 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4STDR45zpTz4xWP;
	Mon, 13 Nov 2023 13:49:20 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Thomas Zimmermann <tzimmermann@suse.de>
In-Reply-To: <20230922080636.26762-1-tzimmermann@suse.de>
References: <20230922080636.26762-1-tzimmermann@suse.de>
Subject: Re: (subset) [PATCH v5 0/5] ppc, fbdev: Clean up fbdev mmap helper
Message-Id: <169984352204.1887074.16685503842131763450.b4-ty@ellerman.id.au>
Date: Mon, 13 Nov 2023 13:45:22 +1100
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
Cc: linux-arch@vger.kernel.org, linux-fbdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, dri-devel@lists.freedesktop.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 22 Sep 2023 10:04:54 +0200, Thomas Zimmermann wrote:
> Clean up and rename fb_pgprotect() to work without struct file. Then
> refactor the implementation for PowerPC. This change has been discussed
> at [1] in the context of refactoring fbdev's mmap code.
> 
> The first two patches update fbdev and replace fbdev's fb_pgprotect()
> with pgprot_framebuffer() on all architectures. The new helper's stream-
> lined interface enables more refactoring within fbdev's mmap
> implementation.
> 
> [...]

Patches 3-5 applied to powerpc/fixes.

[3/5] arch/powerpc: Remove trailing whitespaces
      https://git.kernel.org/powerpc/c/322948c3198cf80e7c10d953ddad24ebd85757cd
[4/5] arch/powerpc: Remove file parameter from phys_mem_access_prot code
      https://git.kernel.org/powerpc/c/1f92a844c35e483c00bab8a7b7d39c555ee799d8
[5/5] arch/powerpc: Call internal __phys_mem_access_prot() in fbdev code
      https://git.kernel.org/powerpc/c/deebe5f607d7f72f83c41163191ad0c1c4356385

cheers
