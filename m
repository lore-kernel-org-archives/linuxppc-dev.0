Return-Path: <festevam@gmail.com>
Received: from mail-la0-x22d.google.com (mail-la0-x22d.google.com
 [IPv6:2a00:1450:4010:c03::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0FFA51A076B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 May 2015 01:13:50 +1000 (AEST)
Received: by laat2 with SMTP id t2so51059045laa.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 May 2015 08:13:45 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20150525151127.GA8184@Asurada>
References: <1432455161-4924-1-git-send-email-nicoleotsuka@gmail.com>
 <20150525115812.GG21391@sirena.org.uk>
 <20150525151127.GA8184@Asurada>
Date: Mon, 25 May 2015 12:13:45 -0300
Message-ID: <CAOMZO5B+GQdXZDfKV6Hz3wXmJCUcXBeWWQxR_jY0n28OnA_gJg@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] ASoC: fsl_spdif: Don't try to round-up for
 clock divisor calculation
From: Fabio Estevam <festevam@gmail.com>
To: Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Mark Brown <broonie@kernel.org>,
 Fabio Estevam <fabio.estevam@freescale.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Zidan Wang <zidan.wang@freescale.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
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

Hi Nicolin,

On Mon, May 25, 2015 at 12:11 PM, Nicolin Chen <nicoleotsuka@gmail.com> wrote:

> Hi Mark,
>
> Is that possible for you to provisionally revert this patch?
> I wanted to wait for the test result from Fabio or Zidan in
> the Cc list because I don't have a test environment for SPDIF
> even though this change seems to make sense.

I currently don't have access to a SPDIF receiver to test it.

Regards,

Fabio Estevam
