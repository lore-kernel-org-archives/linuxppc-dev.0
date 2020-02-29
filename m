Return-Path: <SRS0=CCeT=4R=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.3 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F75DC3F2C6
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Feb 2020 23:30:37 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CF56222C2
	for <linuxppc-dev@archiver.kernel.org>; Sat, 29 Feb 2020 23:30:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7CF56222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=buserror.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 48VN1j0XMwzDrCs
	for <linuxppc-dev@archiver.kernel.org>; Sun,  1 Mar 2020 10:30:33 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 48VN040Fj3zDqjk
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Mar 2020 10:29:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=buserror.net
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 48VN0340TVz8t5m
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Mar 2020 10:29:07 +1100 (AEDT)
Received: by ozlabs.org (Postfix)
 id 48VN033jSRz9sSN; Sun,  1 Mar 2020 10:29:07 +1100 (AEDT)
Authentication-Results: ozlabs.org;
 spf=none (no SPF record) smtp.mailfrom=buserror.net
 (client-ip=165.227.176.147; helo=baldur.buserror.net;
 envelope-from=oss@buserror.net; receiver=<UNKNOWN>)
Authentication-Results: ozlabs.org;
 dmarc=none (p=none dis=none) header.from=buserror.net
X-Greylist: delayed 1846 seconds by postgrey-1.36 at bilbo;
 Sun, 01 Mar 2020 10:29:07 AEDT
Received: from baldur.buserror.net (baldur.buserror.net [165.227.176.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 48VN031Bfhz9sSR
 for <linuxppc-dev@ozlabs.org>; Sun,  1 Mar 2020 10:29:06 +1100 (AEDT)
Received: from [2601:449:8480:af0:12bf:48ff:fe84:c9a0]
 by baldur.buserror.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.89) (envelope-from <oss@buserror.net>)
 id 1j8B1i-0002GE-9Q; Sat, 29 Feb 2020 16:56:06 -0600
Message-ID: <79d6c3104e4fbb9b38150d2f8d336daa2f13a844.camel@buserror.net>
From: Scott Wood <oss@buserror.net>
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@ozlabs.org
Date: Sat, 29 Feb 2020 16:56:05 -0600
In-Reply-To: <20200224233146.23734-8-mpe@ellerman.id.au>
References: <20200224233146.23734-1-mpe@ellerman.id.au>
 <20200224233146.23734-8-mpe@ellerman.id.au>
Organization: Red Hat
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.1 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2601:449:8480:af0:12bf:48ff:fe84:c9a0
X-SA-Exim-Rcpt-To: mpe@ellerman.id.au, linuxppc-dev@ozlabs.org,
 linux-kernel@vger.kernel.org, galak@kernel.crashing.org
X-SA-Exim-Mail-From: oss@buserror.net
Subject: Re: [PATCH 8/8] powerpc: Update 83xx/85xx MAINTAINERS entry
X-SA-Exim-Version: 4.2.1 (built Tue, 02 Aug 2016 21:08:31 +0000)
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
Cc: linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Tue, 2020-02-25 at 10:31 +1100, Michael Ellerman wrote:
> Scott said he was still maintaining this "sort of", so change the
> status to Odd Fixes.
> 
> Kumar has long ago moved on to greener pastures.
> 
> Remove the dead penguinppc.org link.
> 
> Cc: Scott Wood <oss@buserror.net>
> Cc: Kumar Gala <galak@kernel.crashing.org>
> Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> ---
>  MAINTAINERS | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index febffee28d00..2e917116ef6a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -9650,11 +9650,9 @@ F:	arch/powerpc/platforms/44x/
>  
>  LINUX FOR POWERPC EMBEDDED PPC83XX AND PPC85XX
>  M:	Scott Wood <oss@buserror.net>
> -M:	Kumar Gala <galak@kernel.crashing.org>
> -W:	http://www.penguinppc.org/
>  L:	linuxppc-dev@lists.ozlabs.org
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/scottwood/linux.git
> -S:	Maintained
> +S:	Odd fixes

Acked-by: Scott Wood <oss@buserror.net>

-Scott


