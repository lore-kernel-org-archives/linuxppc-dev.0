Return-Path: <sergei.shtylyov@cogentembedded.com>
Received: from mail-lb0-f174.google.com (mail-lb0-f174.google.com
 [209.85.217.174])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DB8961A0037
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 22:40:08 +1000 (EST)
Received: by mail-lb0-f174.google.com with SMTP id c11so6786676lbj.33
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Aug 2014 05:40:04 -0700 (PDT)
Message-ID: <53F49721.1000407@cogentembedded.com>
Date: Wed, 20 Aug 2014 16:40:01 +0400
From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
MIME-Version: 1.0
To: Philipp Zabel <p.zabel@pengutronix.de>, devicetree@vger.kernel.org
Subject: Re: [RFC PATCH 6/6] rtc: rtc-isl12057: Change vendor prefix for
 Intersil Corporation to isil
References: <1408524184-31928-1-git-send-email-p.zabel@pengutronix.de>
 <1408524184-31928-7-git-send-email-p.zabel@pengutronix.de>
In-Reply-To: <1408524184-31928-7-git-send-email-p.zabel@pengutronix.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: Mark Rutland <mark.rutland@arm.com>,
 Alessandro Zummo <a.zummo@towertech.it>, Russell King <linux@arm.linux.org.uk>,
 Pawel Moll <pawel.moll@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>,
 Kumar Gala <galak@codeaurora.org>, Rob Herring <robh+dt@kernel.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello.

On 8/20/2014 12:43 PM, Philipp Zabel wrote:

> Currently there is a wild mixture of isl, isil, and intersil
> compatibles in the kernel. At this point, changing the vendor
> symbol to the most often used variant, which is equal to the
> NASDAQ symbol, isil, should not hurt, since the isl1208 driver
> doesn't care either way.
> Patch 70e123373c05 added this driver with device tree support

    Please also specify that commit's summary line in parens.

> using the then documented isl vendor prefix, so we keep that
> around for backwards compatibility.

> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

WBR, Sergei
