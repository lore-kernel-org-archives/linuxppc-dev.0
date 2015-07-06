Return-Path: <festevam@gmail.com>
Received: from mail-la0-x235.google.com (mail-la0-x235.google.com
 [IPv6:2a00:1450:4010:c03::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 59BB31A0D7D
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jul 2015 20:26:30 +1000 (AEST)
Received: by laar3 with SMTP id r3so149148690laa.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2015 03:26:26 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d626b0b7ad28a96fea0a60e7db29b894fb948166.1436176158.git.zidan.wang@freescale.com>
References: <d626b0b7ad28a96fea0a60e7db29b894fb948166.1436176158.git.zidan.wang@freescale.com>
Date: Mon, 6 Jul 2015 07:26:26 -0300
Message-ID: <CAOMZO5C1uY_qWAd_yEj+-yuXwGZgOOn=7Dcb+5ms16ouQRkmEw@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 1/3] ASoC: fsl_esai: Add driver suspend and
 resume to support MEGA Fast
From: Fabio Estevam <festevam@gmail.com>
To: Zidan Wang <zidan.wang@freescale.com>
Cc: Timur Tabi <timur@tabi.org>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Takashi Iwai <tiwai@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 6, 2015 at 6:50 AM, Zidan Wang <zidan.wang@freescale.com> wrote:
> For i.MX6 SoloX, there is a mode of the SoC to shutdown all power source of
> modules during system suspend and resume procedure. Thus, SAI needs to save

You meant ESAI, not SAI.
