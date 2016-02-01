Return-Path: <mail@maciej.szmigiero.name>
Received: from vps-vb.mhejs.net (vi37-28-154-113.vibiznes.pl [37.28.154.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256
 bits)) (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7C06D1A0176
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Feb 2016 23:26:05 +1100 (AEDT)
Message-ID: <56AF4ED0.7030801@maciej.szmigiero.name>
Date: Mon, 01 Feb 2016 13:25:52 +0100
From: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
MIME-Version: 1.0
To: Fabio Estevam <festevam@gmail.com>
CC: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Timur Tabi <timur@tabi.org>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Xiubo Li <Xiubo.Lee@gmail.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] ASoC: fsl_ssi: remove explicit register defaults
References: <569D3800.2040801@maciej.szmigiero.name>	<CAOMZO5DwQza+jDdkA80v4wkrB56y53tOjkP2-36YNq2WBLodaA@mail.gmail.com>	<56AF4A9F.4060401@maciej.szmigiero.name>
 <CAOMZO5DK86JCs_KivZ5MMFKsiP6aVpopG-zgXPE-+_GWjQNuMw@mail.gmail.com>
In-Reply-To: <CAOMZO5DK86JCs_KivZ5MMFKsiP6aVpopG-zgXPE-+_GWjQNuMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01.02.2016 13:13, Fabio Estevam wrote:
> Hi Maciej,
> 
> On Mon, Feb 1, 2016 at 10:07 AM, Maciej S. Szmigiero
> <mail@maciej.szmigiero.name> wrote:
>> Is regmap patch from
>> http://www.spinics.net/lists/kernel/msg2161934.html
>> applied to the tested tree?
> 
> Yes, linux-next 20160201 contains this patch.

Hmm, I will try to build this tree on UDOO board
today and see what happens.

Maciej
