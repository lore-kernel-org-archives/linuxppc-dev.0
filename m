Return-Path: <festevam@gmail.com>
Received: from mail-oi0-x235.google.com (mail-oi0-x235.google.com
 [IPv6:2607:f8b0:4003:c06::235])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xmycC0cKyzDrJ5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Sep 2017 06:14:34 +1000 (AEST)
Received: by mail-oi0-x235.google.com with SMTP id h70so31271078oic.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Sep 2017 13:14:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <819784e1-910b-6833-997a-2097e147bd0c@denx.de>
References: <1504436701-20700-1-git-send-email-lukma@denx.de>
 <AM5PR0401MB262706674539BFE651706CC6E3900@AM5PR0401MB2627.eurprd04.prod.outlook.com>
 <07e54d28-3bbc-aad2-146b-30867c0bc337@denx.de>
 <20170905052031.GB2774@Asurada-CZ80>
 <819784e1-910b-6833-997a-2097e147bd0c@denx.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Tue, 5 Sep 2017 17:14:31 -0300
Message-ID: <CAOMZO5DULuCZowTeNKXGKJjtiguN+ZX9hPgKvWSAx-r4E-NpdQ@mail.gmail.com>
Subject: Re: [PATCH] sound: soc: fsl: Do not set DAI sysclk when it is equal
 to system freq
To: =?UTF-8?Q?=C5=81ukasz_Majewski?= <lukma@denx.de>
Cc: Nicolin Chen <nicoleotsuka@gmail.com>,
 Fabio Estevam <fabio.estevam@nxp.com>,
 Timur Tabi <timur@tabi.org>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Lukasz,

On Tue, Sep 5, 2017 at 5:35 AM, =C5=81ukasz Majewski <lukma@denx.de> wrote:

> Note:
> [*] - I could workaround this problem by setting:
>
> system-clock-frequency =3D <0> in
>
>                         dailink_master: cpu {
>                             sound-dai =3D <&ssi2>;
>                         };
>

Which mx6 type are you using? Can you post the complete audio related
bindings of your dts?

Still trying to understand why we do not see this error on other imx6 board=
s.
