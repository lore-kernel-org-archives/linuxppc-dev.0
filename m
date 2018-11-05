Return-Path: <SRS0=pi+/=NQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 094E2C0044C
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 20:29:49 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53AFD20827
	for <linuxppc-dev@archiver.kernel.org>; Mon,  5 Nov 2018 20:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53AFD20827
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42pkn55m3fzF35Q
	for <linuxppc-dev@archiver.kernel.org>; Tue,  6 Nov 2018 07:29:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.167.194; helo=mail-oi1-f194.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
 [209.85.167.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42pkks2tLszF20f
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Nov 2018 07:27:49 +1100 (AEDT)
Received: by mail-oi1-f194.google.com with SMTP id v83-v6so8708357oia.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Nov 2018 12:27:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=dwVwoXa1nLilTRsAqCXbVt56WbbEgnkkcw+An0l4VKk=;
 b=DSSqBWLh7027UDL6wfVkzEgNKT1KQQ+MLXrrBgoiBvJ4z+AM4+CKhUGuadiXtH2oyI
 B5y2SZMRTUa9Rhxa8By6ug4CnWjyw0xxhEICkBLbPhBgqixV27g7hu1D/YaLGnYaseQE
 m7gwbQiKIa1Fzma46nBqGqMWcW3OnN5nwnbmr1qfldDQXKpvWa8KWMJdODUnnCiWcUPv
 cjXRF2RQyg6O6Nf5NY9Dp1yZ4qLahuKMH5i31Se6SuxHujKGeRHAbm1vcAnaSJK1Puq1
 ZzPaez0huwaJ0cTfpzojoG2PxdAJs4ilVh5iDfV4SzHQPDorIBC0ZpA18aUZw7mINpRK
 v6+w==
X-Gm-Message-State: AGRZ1gIKs49VAqpOcCJWJyh+3u4PQixE6MhEWsjK+X3/RISBoQh7HtLS
 kYIMXq3apqY4kISwiNlEbQ==
X-Google-Smtp-Source: AJdET5cJetAFxzAaO0q5o6bFwQT8iBelOGkbAy6XPUhefDfkJItJ456gh52QcOZICukZOLA29ig57g==
X-Received: by 2002:aca:4742:: with SMTP id
 u63-v6mr13051416oia.212.1541449666688; 
 Mon, 05 Nov 2018 12:27:46 -0800 (PST)
Received: from localhost (24-155-109-49.dyn.grandenetworks.net.
 [24.155.109.49])
 by smtp.gmail.com with ESMTPSA id u128-v6sm964306oig.21.2018.11.05.12.27.45
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 05 Nov 2018 12:27:45 -0800 (PST)
Date: Mon, 5 Nov 2018 14:27:45 -0600
From: Rob Herring <robh@kernel.org>
To: Yuantian Tang <andy.tang@nxp.com>
Subject: Re: [PATCH 2/2 v3] clk: qoriq: add more compatibles strings
Message-ID: <20181105202745.GA21644@bogus>
References: <20181031065736.32719-1-andy.tang@nxp.com>
 <20181031065736.32719-2-andy.tang@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181031065736.32719-2-andy.tang@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
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
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 Yuantian Tang <andy.tang@nxp.com>, sboyd@kernel.org, mturquette@baylibre.com,
 linux-kernel@vger.kernel.org, oss@buserror.net, robh+dt@kernel.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org, linux-clk@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Wed, 31 Oct 2018 14:57:36 +0800, Yuantian Tang wrote:
> Add more SoC compatible strings to support more chips.
> 
> Signed-off-by: Yuantian Tang <andy.tang@nxp.com>
> ---
> v3:
>   - undo deleting old bindings
>   - split the dts and driver to different patchset
> 
>  .../devicetree/bindings/clock/qoriq-clock.txt      |    6 ++++++
>  1 files changed, 6 insertions(+), 0 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
