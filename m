Return-Path: <SRS0=7Eaw=QE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FB1C433EF
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Nov 2021 11:28:43 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C783C61B9F
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Nov 2021 11:28:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C783C61B9F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4HvLKP3VNJz3dq1
	for <linuxppc-dev@archiver.kernel.org>; Wed, 17 Nov 2021 22:28:41 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org
 [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4HvLFy2XwBz30Bl
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Nov 2021 22:25:42 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4HvLFy0mFYz4xdd;
 Wed, 17 Nov 2021 22:25:42 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>, Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
In-Reply-To: <20211110110739.1072634-1-u.kleine-koenig@pengutronix.de>
References: <20211110003932.51a605ef@canb.auug.org.au>
 <20211110110739.1072634-1-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] powerpc/83xx/mpc8349emitx: Drop unused variable
Message-Id: <163714820970.1508509.13083421770022046388.b4-ty@ellerman.id.au>
Date: Wed, 17 Nov 2021 22:23:29 +1100
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
Cc: Anders Roxell <anders.roxell@linaro.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>, Paul Mackerras <paulus@samba.org>,
 kernel@pengutronix.de, Linux Kernel Functional Testing <lkft@linaro.org>,
 linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 10 Nov 2021 12:07:39 +0100, Uwe Kleine-König wrote:
> Commit 5d354dc35ebb ("powerpc/83xx/mpc8349emitx: Make
> mcu_gpiochip_remove() return void") removed the usage of the variable
> ret, but failed to remove the variable itself, resulting in:
> 
> 	arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c: In function ‘mcu_remove’:
> 	arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c:189:6: error: unused variable ‘ret’ [-Werror=unused-variable]
> 	  189 |  int ret;
> 	      |      ^~~
> 
> [...]

Applied to powerpc/fixes.

[1/1] powerpc/83xx/mpc8349emitx: Drop unused variable
      https://git.kernel.org/powerpc/c/2da516d7ed0865bf9835830907f2f6631006d628

cheers
