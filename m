Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9D9661A0372
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 19 Sep 2015 10:37:41 +1000 (AEST)
Subject: Re: [RESEND PATCH 1/1] ASoC: fsl_ssi: Fix checking of dai format for
 AC97 mode
To: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>,
 Mark Brown <broonie@kernel.org>, Nicolin Chen <nicoleotsuka@gmail.com>
Cc: Xiubo Li <Xiubo.Lee@gmail.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, support.opensource@diasemi.com
References: <409ab77432bd0553502b75ab98089bb7ecdb5018.1442394728.git.Adam.Thomson.Opensource@diasemi.com>
From: undefined
Message-ID: <55FCAE4F.9040904@tabi.org>
Date: Fri, 18 Sep 2015 19:37:35 -0500
MIME-Version: 1.0
In-Reply-To: <409ab77432bd0553502b75ab98089bb7ecdb5018.1442394728.git.Adam.Thomson.Opensource@diasemi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Adam Thomson wrote:
> Current code incorrectly treats dai format for AC97 as bit mask
> whereas it's actually an integer value. This causes DAI formats
> other than AC97 (e.g. DSP_B) to trigger AC97 related code,
> which is incorrect and breaks functionality. This patch fixes
> the code to correctly compare values to determine AC97 or not.
>
> Signed-off-by: Adam Thomson<Adam.Thomson.Opensource@diasemi.com>

Acked-by: Timur Tabi <timur@tabi.org>
