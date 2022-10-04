Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0263C4332F
	for <linuxppc-dev@archiver.kernel.org>; Tue,  4 Oct 2022 13:52:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MhfJz2vbzz3fRc
	for <linuxppc-dev@archiver.kernel.org>; Wed,  5 Oct 2022 00:52:19 +1100 (AEDT)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4Mhf1f5ztgz3drp
	for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Oct 2022 00:39:02 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4Mhf1f59nPz4xHR;
	Wed,  5 Oct 2022 00:39:02 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <20220928130951.1732983-1-mpe@ellerman.id.au>
References: <20220928130951.1732983-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc: Drops STABS_DEBUG from linker scripts
Message-Id: <166488997031.779920.6259179561918399131.b4-ty@ellerman.id.au>
Date: Wed, 05 Oct 2022 00:26:10 +1100
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

On Wed, 28 Sep 2022 23:09:51 +1000, Michael Ellerman wrote:
> No toolchain we support should be generating stabs debug information
> anymore. Drop the sections entirely from our linker scripts.
> 
> We removed all the manual stabs annotations in commit
> 12318163737c ("powerpc/32: Remove remaining .stabs annotations").
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: Drops STABS_DEBUG from linker scripts
      https://git.kernel.org/powerpc/c/7673335e2a0b8e68a2a238773a34e287a089a8fe

cheers
