Return-Path: <festevam@gmail.com>
Received: from mail-oi0-x242.google.com (mail-oi0-x242.google.com
 [IPv6:2607:f8b0:4003:c06::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhT0y0rtbzDqfg
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 22:46:58 +1000 (AEST)
Received: by mail-oi0-x242.google.com with SMTP id r203so2879136oih.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 05:46:57 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170829123755.9496-1-robh@kernel.org>
References: <20170829123755.9496-1-robh@kernel.org>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 29 Aug 2017 09:46:55 -0300
Message-ID: <CAOMZO5B7b61AR21M8MHdPg2dX6Pz3jfH6+CskOH70RrwTKQbJQ@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH v3] ASoC: fsl_dma: remove dma_object path
 member
To: Rob Herring <robh@kernel.org>
Cc: Mark Brown <broonie@kernel.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@tabi.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>, Takashi Iwai <tiwai@suse.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Nicolin Chen <nicoleotsuka@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 29, 2017 at 9:37 AM, Rob Herring <robh@kernel.org> wrote:
> dma_object.path is unused, so rather than fix it to work with DT
> full_name changes, just remove it.
>
> Signed-off-by: Rob Herring <robh@kernel.org>

Reviewed-by: Fabio Estevam <fabio.estevam@nxp.com>
