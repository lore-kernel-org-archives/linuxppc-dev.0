Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61FAC19F2B
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Jul 2022 13:23:36 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LvSrl28DCz3hSW
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Jul 2022 23:23:35 +1000 (AEST)
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LvSls1Rr5z3gX1
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Jul 2022 23:19:21 +1000 (AEST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4LvSls0pYTz4x1d;
	Fri, 29 Jul 2022 23:19:21 +1000 (AEST)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>, Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>
In-Reply-To: <20220707061441.193869-1-u.kleine-koenig@pengutronix.de>
References: <20220707061441.193869-1-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH 1/3] powerpc/platforms/83xx/suspend: Reorder to get rid of a forward declaration
Message-Id: <165909978289.253830.17613768941450474747.b4-ty@ellerman.id.au>
Date: Fri, 29 Jul 2022 23:03:02 +1000
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
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 7 Jul 2022 08:14:39 +0200, Uwe Kleine-König wrote:
> By moving up pmc_types and pmc_match, the forward declaration for pmc_match
> can be dropped.
> 
> 

Applied to powerpc/next.

[1/3] powerpc/platforms/83xx/suspend: Reorder to get rid of a forward declaration
      https://git.kernel.org/powerpc/c/fde345e4d39a4f16697a8060564fff1dbac05035
[2/3] powerpc/platforms/83xx/suspend: Prevent unloading the driver
      https://git.kernel.org/powerpc/c/ccc1439b924bca5d5a5d81cf6b0d4b10b321282e
[3/3] powerpc/platforms/83xx/suspend: Remove write-only global variable
      https://git.kernel.org/powerpc/c/95b002e4e47a36d88deec70808ef36674fb33cf5

cheers
