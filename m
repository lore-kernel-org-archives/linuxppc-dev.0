Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BC12E1A0AC6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Jan 2016 08:35:28 +1100 (AEDT)
Subject: Re: [PATCH 2/3] ASoC: fsl_ssi: mark some registers precious
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Fabio Estevam <festevam@gmail.com>
References: <56771034.5080702@maciej.szmigiero.name>
From: Timur Tabi <timur@tabi.org>
Message-ID: <5692CE9F.9020809@tabi.org>
Date: Sun, 10 Jan 2016 15:35:27 -0600
MIME-Version: 1.0
In-Reply-To: <56771034.5080702@maciej.szmigiero.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Maciej S. Szmigiero wrote:
> Mark some registers precious since their
> reads have side effects (like clearing flags).
>
> Signed-off-by: Maciej S. Szmigiero<mail@maciej.szmigiero.name>

Acked-by: Timur Tabi <timur@tabi.org>
