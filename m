Return-Path: <robherring2@gmail.com>
Received: from mail-oi0-f52.google.com (mail-oi0-f52.google.com
 [209.85.218.52])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPzcX28t6zDqtW
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 05:52:44 +1000 (AEST)
Received: by mail-oi0-f52.google.com with SMTP id k23so30257023oih.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jun 2016 12:52:44 -0700 (PDT)
Date: Wed, 8 Jun 2016 14:52:41 -0500
From: Rob Herring <robh@kernel.org>
To: Jia Hongtao <hongtao.jia@nxp.com>
Cc: edubezval@gmail.com, rui.zhang@intel.com, galak@codeaurora.org,
 scott.wood@nxp.com, shawnguo@kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH V2 1/7] dt-bindings: Update QorIQ TMU thermal bindings
Message-ID: <20160608195241.GA6805@rob-hp-laptop>
References: <1465270054-31512-1-git-send-email-hongtao.jia@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1465270054-31512-1-git-send-email-hongtao.jia@nxp.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 07, 2016 at 11:27:34AM +0800, Jia Hongtao wrote:
> For different types of SoC the sensor id and endianness may vary.
> "#thermal-sensor-cells" is used to provide sensor id information.
> "little-endian" property is to tell the endianness of TMU.
> 
> Signed-off-by: Jia Hongtao <hongtao.jia@nxp.com>
> ---
> Changes for V2:
> * Remove formatting chnages.
> 
>  Documentation/devicetree/bindings/thermal/qoriq-thermal.txt | 7 +++++++
>  1 file changed, 7 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
