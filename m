Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DADB0ECAAA1
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Sep 2022 12:11:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4MPFGR2X8Jz3f9p
	for <linuxppc-dev@archiver.kernel.org>; Fri,  9 Sep 2022 22:11:43 +1000 (AEST)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4MPFDZ2Xlpz2xBl
	for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Sep 2022 22:10:06 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4MPFDZ1syJz4xFt;
	Fri,  9 Sep 2022 22:10:06 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
In-Reply-To: <20220901014253.252927-1-mpe@ellerman.id.au>
References: <20220901014253.252927-1-mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/configs: Properly enable PAPR_SCM in pseries_defconfig
Message-Id: <166272521128.2076816.765769894015076256.b4-ty@ellerman.id.au>
Date: Fri, 09 Sep 2022 22:06:51 +1000
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

On Thu, 1 Sep 2022 11:42:53 +1000, Michael Ellerman wrote:
> My commit to add PAPR_SCM to pseries_defconfig failed to add the
> required dependencies, meaning the driver doesn't get built.
> 
> Add the required LIBNVDIMM=m.
> 
> 

Applied to powerpc/next.

[1/1] powerpc/configs: Properly enable PAPR_SCM in pseries_defconfig
      https://git.kernel.org/powerpc/c/aa398d88aea4ec863bd7aea35d5035a37096dc59

cheers
