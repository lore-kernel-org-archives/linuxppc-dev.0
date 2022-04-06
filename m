Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D131C433F5
	for <linuxppc-dev@archiver.kernel.org>; Wed,  6 Apr 2022 20:16:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4KYbPv4CPLz3bmT
	for <linuxppc-dev@archiver.kernel.org>; Thu,  7 Apr 2022 06:16:35 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=buserror.net
 (client-ip=165.227.176.147; helo=baldur.buserror.net;
 envelope-from=oss@buserror.net; receiver=<UNKNOWN>)
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest
 SHA256) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4KYbPN26syz2xB1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Apr 2022 06:16:08 +1000 (AEST)
Received: from [2601:449:8480:af0::46ce]
 by baldur.buserror.net with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <oss@buserror.net>)
 id 1ncC2J-006Lmc-Cd; Wed, 06 Apr 2022 15:13:51 -0500
Message-ID: <7c2261ee00920aa6f8e6aeef98d99d34944957ab.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Wed, 06 Apr 2022 15:13:50 -0500
In-Reply-To: <20220323174342.56187-1-andriy.shevchenko@linux.intel.com>
References: <20220323174342.56187-1-andriy.shevchenko@linux.intel.com>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0::46ce
X-SA-Exim-Rcpt-To: andriy.shevchenko@linux.intel.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 mpe@ellerman.id.au, benh@kernel.crashing.org, paulus@samba.org, brgl@bgdev.pl,
 linus.walleij@linaro.org
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH v1 1/1] powerpc/83xx/mpc8349emitx: Get rid of of_node
 assignment
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on baldur.buserror.net)
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
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Paul Mackerras <paulus@samba.org>,
 Linus Walleij <linus.walleij@linaro.org>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 2022-03-23 at 19:43 +0200, Andy Shevchenko wrote:
> Let GPIO library to assign of_node from the parent device.
> This allows to move GPIO library and drivers to use fwnode
> APIs instead of being stuck with OF-only interfaces.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  arch/powerpc/platforms/83xx/mcu_mpc8349emitx.c | 14 +++++---------
>  1 file changed, 5 insertions(+), 9 deletions(-)

Acked-by: Scott Wood <oss@buserror.net>

-Scott


