Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xtn1M6QjCzDrXP
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Sep 2017 17:23:03 +1000 (AEST)
Date: Fri, 15 Sep 2017 09:13:26 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Nicolas Ferre
 <nicolas.ferre@microchip.com>, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, Rob Herring <robh+dt@kernel.org>,
 devicetree@vger.kernel.org
Subject: Re: [PATCH 3/3] powerpc/5200: dts: digsy_mtc.dts: fix rv3029
 compatible
Message-ID: <20170915091326.4b93bde1@crub>
In-Reply-To: <20170915020004.24272-3-alexandre.belloni@free-electrons.com>
References: <20170915020004.24272-1-alexandre.belloni@free-electrons.com>
 <20170915020004.24272-3-alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 15 Sep 2017 04:00:04 +0200
Alexandre Belloni alexandre.belloni@free-electrons.com wrote:

>The proper compatible for rv3029 is microcrystal,rv3029.
>
>Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Acked-by: Anatolij Gustschin <agust@denx.de>
