Return-Path: <robherring2@gmail.com>
Received: from mail-oi1-f194.google.com (mail-oi1-f194.google.com
 [209.85.167.194])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42LlMJ4J9gzF37p
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Sep 2018 05:32:43 +1000 (AEST)
Received: by mail-oi1-f194.google.com with SMTP id 13-v6so3259393ois.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Sep 2018 12:32:43 -0700 (PDT)
Date: Thu, 27 Sep 2018 14:32:40 -0500
From: Rob Herring <robh@kernel.org>
To: Vabhav Sharma <vabhav.sharma@nxp.com>
Cc: sudeep.holla@arm.com, oss@buserror.net, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, robh+dt@kernel.org,
 mark.rutland@arm.com, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, mturquette@baylibre.com,
 sboyd@kernel.org, rjw@rjwysocki.net, viresh.kumar@linaro.org,
 linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel-owner@vger.kernel.org, catalin.marinas@arm.com,
 will.deacon@arm.com, gregkh@linuxfoundation.org, arnd@arndb.de,
 kstewart@linuxfoundation.org, yamada.masahiro@socionext.com,
 udit.kumar@nxp.com, linux@armlinux.org.uk,
 Vabhav Sharma <vabhav.sharma@nxp.com>, V.Sethi@nxp.com
Subject: Re: [PATCH v3 1/6] dt-bindings: arm64: add compatible for LX2160A
Message-ID: <20180927193240.GA29253@bogus>
References: <1537747741-6245-1-git-send-email-vabhav.sharma@nxp.com>
 <1537747741-6245-2-git-send-email-vabhav.sharma@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1537747741-6245-2-git-send-email-vabhav.sharma@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 24 Sep 2018 05:38:56 +0530, Vabhav Sharma wrote:
> Add compatible for LX2160A SoC,QDS and RDB board
> 
> Signed-off-by: Vabhav Sharma <vabhav.sharma@nxp.com>
> ---
>  Documentation/devicetree/bindings/arm/fsl.txt | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>
