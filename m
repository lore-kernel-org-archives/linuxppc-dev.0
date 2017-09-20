Return-Path: <robherring2@gmail.com>
Received: from mail-pf0-f195.google.com (mail-pf0-f195.google.com
 [209.85.192.195])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xyBky0pKnzDqSL
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Sep 2017 06:52:25 +1000 (AEST)
Received: by mail-pf0-f195.google.com with SMTP id f84so1629521pfj.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Sep 2017 13:52:25 -0700 (PDT)
Date: Wed, 20 Sep 2017 15:52:22 -0500
From: Rob Herring <robh@kernel.org>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Nicolas Ferre <nicolas.ferre@microchip.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Anatolij Gustschin <agust@denx.de>, linuxppc-dev@lists.ozlabs.org,
 devicetree@vger.kernel.org
Subject: Re: [PATCH 1/3] RTC: rv3029: fix vendor string
Message-ID: <20170920205222.u445mraruddz3ufl@rob-hp-laptop>
References: <20170915020004.24272-1-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170915020004.24272-1-alexandre.belloni@free-electrons.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 15, 2017 at 04:00:02AM +0200, Alexandre Belloni wrote:
> The vendor string for Microcrystal is microcrystal.
> 
> Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>
> ---
>  Documentation/devicetree/bindings/trivial-devices.txt | 2 +-
>  drivers/rtc/rtc-rv3029c2.c                            | 2 ++
>  2 files changed, 3 insertions(+), 1 deletion(-)

Acked-by: Rob Herring <robh@kernel.org>
