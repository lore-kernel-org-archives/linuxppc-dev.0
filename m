Return-Path: <frowand.list@gmail.com>
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com
 [IPv6:2607:f8b0:4864:20::641])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Bpdr1K5GzF35x
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Sep 2018 07:32:47 +1000 (AEST)
Received: by mail-pl1-x641.google.com with SMTP id s17-v6so4739669plp.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Sep 2018 14:32:46 -0700 (PDT)
Subject: Re: [PATCH 3/3] scripts/dtc: Update to upstream version
 v1.4.7-14-gc86da84d30e4
To: Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org
References: <20180913202828.15372-1-robh@kernel.org>
 <20180913202828.15372-3-robh@kernel.org>
From: Frank Rowand <frowand.list@gmail.com>
Message-ID: <f9684222-fae0-c305-d48a-be77ebb985a3@gmail.com>
Date: Fri, 14 Sep 2018 14:32:43 -0700
MIME-Version: 1.0
In-Reply-To: <20180913202828.15372-3-robh@kernel.org>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/13/18 13:28, Rob Herring wrote:
> Major changes are I2C and SPI bus checks, YAML output format (for
> future validation), some new libfdt functions, and more libfdt
> validation of dtbs.
> 
> The YAML addition adds an optional dependency on libyaml. pkg-config is
> used to test for it and pkg-config became a kconfig dependency in 4.18.

For Ubuntu, the libyaml dependency is provided by the packages:

   libyaml-0-2
   libyaml-dev


-Frank

> 
> This adds the following commits from upstream:
> 
> c86da84d30e4 Add support for YAML encoded output
> 361b5e7d8067 Make type_marker_length helper public


< snip >
