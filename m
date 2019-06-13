Return-Path: <SRS0=gIJz=UM=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E75BC31E45
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Jun 2019 22:12:13 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17EEB2147A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 13 Jun 2019 22:12:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17EEB2147A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45Pydl05PzzDrPS
	for <linuxppc-dev@archiver.kernel.org>; Fri, 14 Jun 2019 08:12:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=209.85.222.196; helo=mail-qk1-f196.google.com;
 envelope-from=robherring2@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=fail (p=none dis=none) header.from=kernel.org
Received: from mail-qk1-f196.google.com (mail-qk1-f196.google.com
 [209.85.222.196])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45PyXQ3GmTzDrNh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jun 2019 08:07:33 +1000 (AEST)
Received: by mail-qk1-f196.google.com with SMTP id m14so410433qka.10
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jun 2019 15:07:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=BhWdQ+n9lb5V8igkIdjlDGkO+bOshDClHntzHo4xkx4=;
 b=pQw0GDTXD4wy390C6RVanu0ym/HA6mzHRmNuKNBoXSJDTLfAuhgRpzKAvRKjXlZgCE
 lzaaOP6/N9o2F8vNXPFOb8ZUzHKi8+cXft/jQrEVGFptc4286TyjcVg2riZ4FfJnCQlM
 pLaIcYXCrO8igoa9WcDSUzOe5VgBJfXPylkRBAGCyN0GIPhKcDkODfzP90oDCENrcV5h
 S+SOLFoFPpqbYpo0z5MGF3iLckVEA5Jf9+/nIkLmtyhIsl6btj4P2csn1v5/JVEQIV6a
 g6rx6+BEilfh3Z2Rx8hMfHLegzXQ+gukR+iXUNm0mGy/0sV6JVsQR4LBvjBXQRnFMoZv
 Xl+Q==
X-Gm-Message-State: APjAAAVsQ0fYlKSombnbCmdpq/HXQTHtmloxZTXN0svHZZ4k2/E4MJGN
 h9yWfFc2HJ7Cx648K1BM8Q==
X-Google-Smtp-Source: APXvYqzlg3l0HADoNTIkv5SXk7nuuzVo6Jw7oSlbsAolVM+MxEBgZazQrw5oWThYP2sbSY8L9PzBsg==
X-Received: by 2002:a37:6512:: with SMTP id z18mr73992402qkb.158.1560463650992; 
 Thu, 13 Jun 2019 15:07:30 -0700 (PDT)
Received: from localhost ([64.188.179.243])
 by smtp.gmail.com with ESMTPSA id t8sm708240qtc.80.2019.06.13.15.07.30
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Thu, 13 Jun 2019 15:07:30 -0700 (PDT)
Date: Thu, 13 Jun 2019 16:07:29 -0600
From: Rob Herring <robh@kernel.org>
To: Ran Wang <ran.wang_1@nxp.com>
Subject: Re: [PATCH 2/3] Documentation: dt: binding: fsl: Add 'little-endian'
 and update Chassis define
Message-ID: <20190613220729.GA29761@bogus>
References: <20190517024748.15534-1-ran.wang_1@nxp.com>
 <20190517024748.15534-2-ran.wang_1@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190517024748.15534-2-ran.wang_1@nxp.com>
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
Cc: Mark Rutland <mark.rutland@arm.com>, Len Brown <len.brown@intel.com>,
 devicetree@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-pm@vger.kernel.org, "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>,
 Pavel Machek <pavel@ucw.cz>, Ran Wang <ran.wang_1@nxp.com>,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Fri, 17 May 2019 10:47:47 +0800, Ran Wang wrote:
> By default, QorIQ SoC's RCPM register block is Big Endian. But
> there are some exceptions, such as LS1088A and LS2088A, are Little
> Endian. So add this optional property to help identify them.
> 
> Actually LS2021A and other Layerscapes won't totally follow Chassis
> 2.1, so separate them from powerpc SoC.
> 
> Signed-off-by: Ran Wang <ran.wang_1@nxp.com>
> ---
>  Documentation/devicetree/bindings/soc/fsl/rcpm.txt |    8 +++++++-
>  1 files changed, 7 insertions(+), 1 deletions(-)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
