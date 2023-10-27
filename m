Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B1F0C25B67
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Oct 2023 09:49:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4SGyY94T4tz3cRh
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Oct 2023 20:49:01 +1100 (AEDT)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4SGyXf2HXGz30gH
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Oct 2023 20:48:34 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4SGyXb23hkz4xPd;
	Fri, 27 Oct 2023 20:48:31 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <20231023112500.1550208-1-mpe@ellerman.id.au>
References: <20231023112500.1550208-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/mm: Fix boot crash with FLATMEM
Message-Id: <169840001174.2695453.14189570436148855598.b4-ty@ellerman.id.au>
Date: Fri, 27 Oct 2023 20:46:51 +1100
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
Cc: erhard_f@mailbox.org, willy@infradead.org, aneesh.kumar@linux.ibm.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 23 Oct 2023 22:25:00 +1100, Michael Ellerman wrote:
> Erhard reported that his G5 was crashing with v6.6-rc kernels:
> 
>   mpic: Setting up HT PICs workarounds for U3/U4
>   BUG: Unable to handle kernel data access at 0xfeffbb62ffec65fe
>   Faulting instruction address: 0xc00000000005dc40
>   Oops: Kernel access of bad area, sig: 11 [#1]
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/mm: Fix boot crash with FLATMEM
      https://git.kernel.org/powerpc/c/daa9ada2093ed23d52b4c1fe6e13cf78f55cc85f

cheers
