Return-Path: <festevam@gmail.com>
Received: from mail-la0-x22e.google.com (mail-la0-x22e.google.com
 [IPv6:2a00:1450:4010:c03::22e])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B1F2A1A0D8A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jul 2015 22:20:28 +1000 (AEST)
Received: by lagx9 with SMTP id x9so152316851lag.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Jul 2015 05:20:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <dfaae3aacf6cf985adfd4394429cc90518c00dc0.1436176158.git.zidan.wang@freescale.com>
References: <d626b0b7ad28a96fea0a60e7db29b894fb948166.1436176158.git.zidan.wang@freescale.com>
 <dfaae3aacf6cf985adfd4394429cc90518c00dc0.1436176158.git.zidan.wang@freescale.com>
Date: Mon, 6 Jul 2015 09:20:24 -0300
Message-ID: <CAOMZO5Cf8cY09QU83xkJwVyadJdszBowKbFw1Bg+NeJzMEf5Jw@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 2/3] ASoC: fsl_spdif: Add driver suspend and
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

s/SAI/SPDIF
