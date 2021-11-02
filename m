Return-Path: <SRS0=jSa2=PV=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92948C433F5
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 11:52:04 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1269D61076
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 11:52:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1269D61076
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Hk7YG5K13z3gqS
	for <linuxppc-dev@archiver.kernel.org>; Tue,  2 Nov 2021 22:52:02 +1100 (AEDT)
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org
 [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4Hk7G80BGQz2ynk
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Nov 2021 22:38:56 +1100 (AEDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by mail.ozlabs.org (Postfix) with ESMTPSA id 4Hk7G73Wdkz4xdn;
 Tue,  2 Nov 2021 22:38:55 +1100 (AEDT)
From: Michael Ellerman <patch-notifications@ellerman.id.au>
To: Scott Wood <oss@buserror.net>, Michael Ellerman <mpe@ellerman.id.au>, Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
In-Reply-To: <20211021105657.72572-1-u.kleine-koenig@pengutronix.de>
References: <20211021105657.72572-1-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH] powerpc: mpc8349emitx: Make mcu_gpiochip_remove() return
 void
Message-Id: <163584792173.1845480.8901860932693104869.b4-ty@ellerman.id.au>
Date: Tue, 02 Nov 2021 21:12:01 +1100
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
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 kernel@pengutronix.de
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Thu, 21 Oct 2021 12:56:57 +0200, Uwe Kleine-König wrote:
> Up to now mcu_gpiochip_remove() returns zero unconditionally. Make it
> return void instead which makes it easier to see in the callers that
> there is no error to handle.
> 
> Also the return value of i2c remove callbacks is ignored anyway.
> 
> 
> [...]

Applied to powerpc/next.

[1/1] powerpc: mpc8349emitx: Make mcu_gpiochip_remove() return void
      https://git.kernel.org/powerpc/c/5d354dc35ebb0b224d627264c60f60dbda3a1bc3

cheers
