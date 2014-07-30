Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 82A351A021A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Jul 2014 22:25:44 +1000 (EST)
Message-ID: <53D8E2B4.6060009@tabi.org>
Date: Wed, 30 Jul 2014 07:19:00 -0500
From: Timur Tabi <timur@tabi.org>
MIME-Version: 1.0
To: Nicolin Chen <nicoleotsuka@gmail.com>, broonie@kernel.org
Subject: Re: [PATCH 4/4] ASoC: fsl_ssi: Add stream names for DPCM usage
References: <cover.1406688048.git.nicoleotsuka@gmail.com>
 <891b9f4edbba81a03c2b8350abc5ccf923db9260.1406688049.git.nicoleotsuka@gmail.com>
In-Reply-To: <891b9f4edbba81a03c2b8350abc5ccf923db9260.1406688049.git.nicoleotsuka@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: alsa-devel@alsa-project.org, tiwai@suse.de, b42378@freescale.com,
 b02247@freescale.com, linux-kernel@vger.kernel.org, lgirdwood@gmail.com,
 Li.Xiubo@freescale.com, perex@perex.cz, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicolin Chen wrote:
> DPCM needs extra dapm routes in the machine driver to route audio
> between Front-End and Back-End. In order to differ the stream names
> in the route map from CODECs, we here add specific stream names to
> SSI driver so that we can implement ASRC via DPCM to it.
>
> Signed-off-by: Nicolin Chen<nicoleotsuka@gmail.com>

Acked-by: Timur Tabi <timur@tabi.org>
