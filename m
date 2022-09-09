Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494A6ECAAA1
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Sep 2022 12:24:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MPFXm6KRvz3hXp
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Sep 2022 22:24:08 +1000 (AEST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MPFF01Nklz3cf1
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Sep 2022 22:10:28 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4MPFDx0D3Fz4xcD;
	Fri,  9 Sep 2022 22:10:25 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, Liang He <windhl@126.com>, benh@kernel.crashing.org, linmq006@gmail.com, mpe@ellerman.id.au
In-Reply-To: <20220704145233.278539-1-windhl@126.com>
References: <20220704145233.278539-1-windhl@126.com>
Subject: Re: [PATCH] powerpc: sysdev: fsl_msi: Add missing of_node_put() for of_parse_phandle()
Message-Id: <166272523658.2076816.8013070422125846208.b4-ty@ellerman.id.au>
Date: Fri, 09 Sep 2022 22:07:16 +1000
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
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, 4 Jul 2022 22:52:33 +0800, Liang He wrote:
> In fsl_setup_msi_irqs(), we should use of_node_put() for the
> refernece 'np' returned by of_parse_phandle() which increases
> the refcount.
> 
> 

Applied to powerpc/next.

[1/1] powerpc: sysdev: fsl_msi: Add missing of_node_put() for of_parse_phandle()
      https://git.kernel.org/powerpc/c/def435c04ee984a5f9ed2711b2bfe946936c6a21

cheers
