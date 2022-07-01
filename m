Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1875C43334
	for <linuxppc-dev@archiver.kernel.org>; Fri,  1 Jul 2022 20:55:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4LZSCH0nSyz3chj
	for <linuxppc-dev@archiver.kernel.org>; Sat,  2 Jul 2022 06:55:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=209.85.166.182; helo=mail-il1-f182.google.com; envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Received: from mail-il1-f182.google.com (mail-il1-f182.google.com [209.85.166.182])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LZSBT5Qzlz3cdX
	for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jul 2022 06:54:57 +1000 (AEST)
Received: by mail-il1-f182.google.com with SMTP id w10so2132228ilj.4
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Jul 2022 13:54:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=3LPZ1DizPYBScxcXuGY/3z+PsYKOTpV0UZkb5MuqFe0=;
        b=6HyRlfDkR+6uEnxs+YWfUvYxBzWLTu42YVl7cWlGjBOK9JbazkfmA5T0CqRzN8XBYL
         9IywcE1fdJ0jXo6Z861b+Qp7QdRcP/Db8iQtzMIbnK5C9Mely5fFUCJaC754FrFGtZGC
         6797V9QxNIcadyyOTfPdKC8tDf5YROko/eNQvabLqIG9s4o864JuG2YyGbIR1fMP9th3
         v/tqBJQSdZypnLWV1eNOR6CJFNrIv74sDD/AJC5qnM5/0GzGoTvtK7M3WzMLdR3epW5w
         jG5sOGAu10Sr4DtV6CIZkYyooJeMM0pqduOhittlkS9K1u2PbAW92DUj7gJRNwSxPmZI
         gFMw==
X-Gm-Message-State: AJIora9aJG1FDzm5jXef+H9kDv9skBdmwpey9eQA8ka0CI67MjHriGU8
	FPsDmf5ZXlP62S664GDkMiVi09XN4A==
X-Google-Smtp-Source: AGRyM1vTE3uUzjOrJeeGSTgJ/tO4QiastKGHmlTULq10GRjmMlObeExibr8KirXpiJJiC7qDmehj1Q==
X-Received: by 2002:a05:6e02:1187:b0:2da:97e5:6609 with SMTP id y7-20020a056e02118700b002da97e56609mr9630603ili.274.1656708895013;
        Fri, 01 Jul 2022 13:54:55 -0700 (PDT)
Received: from robh.at.kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id u6-20020a056e02080600b002dbf4c67b1fsm295715ilm.46.2022.07.01.13.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 13:54:54 -0700 (PDT)
Received: (nullmailer pid 1511647 invoked by uid 1000);
	Fri, 01 Jul 2022 20:54:52 -0000
Date: Fri, 1 Jul 2022 14:54:52 -0600
From: Rob Herring <robh@kernel.org>
To: Shengjiu Wang <shengjiu.wang@nxp.com>
Subject: Re: [PATCH v2 6/6] ASoC: dt-bindings: fsl-sai: Add two PLL clock
 source
Message-ID: <20220701205452.GA1511590-robh@kernel.org>
References: <1656667961-1799-1-git-send-email-shengjiu.wang@nxp.com>
 <1656667961-1799-7-git-send-email-shengjiu.wang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1656667961-1799-7-git-send-email-shengjiu.wang@nxp.com>
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
Cc: devicetree@vger.kernel.org, alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org, Xiubo.Lee@gmail.com, festevam@gmail.com, broonie@kernel.org, tiwai@suse.com, lgirdwood@gmail.com, perex@perex.cz, nicoleotsuka@gmail.com, robh+dt@kernel.org, krzk+dt@kernel.org, shengjiu.wang@gmail.com, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 01 Jul 2022 17:32:41 +0800, Shengjiu Wang wrote:
> Add two PLL clock source, they are the parent clocks of root clock
> one is for 8kHz series rates, another one is for 11kHz series rates.
> They are optional clocks, if there are such clocks, then driver
> can switch between them for supporting more accurate rates.
> 
> Signed-off-by: Shengjiu Wang <shengjiu.wang@nxp.com>
> ---
>  Documentation/devicetree/bindings/sound/fsl-sai.txt | 3 +++
>  1 file changed, 3 insertions(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
