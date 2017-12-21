Return-Path: <caleb@crome.org>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z2jpG2FtXzDsRn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 22 Dec 2017 07:26:13 +1100 (AEDT)
Received: by mail-pf0-x242.google.com with SMTP id u19so14387997pfa.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Dec 2017 12:26:13 -0800 (PST)
MIME-Version: 1.0
From: Caleb Crome <caleb@crome.org>
Date: Thu, 21 Dec 2017 12:25:50 -0800
Message-ID: <CAG5mAdz8BObzsmz6A2t0GZDrENhr1Gu9009dQDTiOPgHJ9+cmQ@mail.gmail.com>
Subject: ASoC: fsl_ssi: Bringing up the SSI port in multi-channel TDM mode
To: Timur Tabi <timur@tabi.org>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>, mail@maciej.szmigiero.name,
 Arnaud Mouiche <arnaud.mouiche@invoxia.com>, lukma@denx.de,
 Sascha Hauer <kernel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,
   I just posted a little write up for helping people get started with
the Freescale SSI port in TDM mode.

https://medium.com/@caleb_22836/how-to-get-the-mx6-ssi-port-up-and-running-in-tdm-mode-dbce02a15e81

I'm just posting here in case anybody is searching the google for this
information and finds this post.

(Also, it assumes that v4.15 will be released by the time anybody
actually uses it...)

-Caleb
