Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29654C2BA1A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 Jun 2024 14:30:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4W4jZB5kKJz3cfn
	for <linuxppc-dev@archiver.kernel.org>; Fri, 21 Jun 2024 00:30:10 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Received: from mail.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4W4jYl6vn6z3cBx
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Jun 2024 00:29:47 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4W4jYl3rsWz4w2H;
	Fri, 21 Jun 2024 00:29:47 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu, aneesh.kumar@kernel.org, naveen.n.rao@linux.ibm.com, corbet@lwn.net, Gautam Menghani <gautam@linux.ibm.com>
In-Reply-To: <20240605113913.83715-1-gautam@linux.ibm.com>
References: <20240605113913.83715-1-gautam@linux.ibm.com>
Subject: Re: [PATCH v2 0/2] Fix doorbell emulation for v2 API on PPC
Message-Id: <171889374983.827284.3419155044368284562.b4-ty@ellerman.id.au>
Date: Fri, 21 Jun 2024 00:29:09 +1000
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
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, stable@vger.kernel.org, kvm@vger.kernel.org, linux-doc@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 05 Jun 2024 17:09:08 +0530, Gautam Menghani wrote:
> Doorbell emulation for KVM on PAPR guests is broken as support for DPDES
> was not added in initial patch series [1].
> Add DPDES support and doorbell handling support for V2 API.
> 
> [1] lore.kernel.org/linuxppc-dev/20230914030600.16993-1-jniethe5@gmail.com
> 
> Changes in v2:
> 1. Split DPDES support into its own patch
> 
> [...]

Applied to powerpc/topic/ppc-kvm.

[1/2] arch/powerpc/kvm: Add DPDES support in helper library for Guest state buffer
      https://git.kernel.org/powerpc/c/55dfb8bed6fe8bda390cc71cca878d11a9407099
[2/2] arch/powerpc/kvm: Fix doorbell emulation for v2 API
      https://git.kernel.org/powerpc/c/54ec2bd9e0173b75daf84675d07c56584f96564b

cheers
