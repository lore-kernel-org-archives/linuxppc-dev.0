Return-Path: <SRS0=CqhW=BD=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6989C433DF
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2020 15:18:24 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 447DB206D7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Jul 2020 15:18:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 447DB206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BCtBQ0YX4zDrKb
	for <linuxppc-dev@archiver.kernel.org>; Sat, 25 Jul 2020 01:18:22 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BCqgn6TkBzDr48
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jul 2020 23:25:09 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 4BCqgn2ryWz9sV9; Fri, 24 Jul 2020 23:25:09 +1000 (AEST)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 4BCqgl4D1hz9sVP; Fri, 24 Jul 2020 23:25:04 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
In-Reply-To: <20200508130633.2532759-1-mpe@ellerman.id.au>
References: <20200508130633.2532759-1-mpe@ellerman.id.au>
Subject: Re: [PATCH v2] powerpc/spufs: Rework fcheck() usage
Message-Id: <159559696762.1657499.10154979007283332185.b4-ty@ellerman.id.au>
Date: Fri, 24 Jul 2020 23:25:04 +1000 (AEST)
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
Cc: hch@lst.de, jk@ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 8 May 2020 23:06:33 +1000, Michael Ellerman wrote:
> Currently the spu coredump code triggers an RCU warning:
> 
>   =============================
>   WARNING: suspicious RCU usage
>   5.7.0-rc3-01755-g7cd49f0b7ec7 #1 Not tainted
>   -----------------------------
>   include/linux/fdtable.h:95 suspicious rcu_dereference_check() usage!
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc/spufs: Rework fcheck() usage
      https://git.kernel.org/powerpc/c/38b407be172d3d15afdbfe172691b7caad98120f

cheers
