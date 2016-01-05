Return-Path: <festevam@gmail.com>
Received: from mail-io0-x229.google.com (mail-io0-x229.google.com
 [IPv6:2607:f8b0:4001:c06::229])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id ABC8A1A114D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Jan 2016 01:57:29 +1100 (AEDT)
Received: by mail-io0-x229.google.com with SMTP id o67so468097370iof.3
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 05 Jan 2016 06:57:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAOZdJXVK-_j+pF+dXsnWd0AQZWD3p9+=ziS3Byw5e2ED1W_W=g@mail.gmail.com>
References: <56770FE1.4060202@maciej.szmigiero.name>
 <CAOZdJXVK-_j+pF+dXsnWd0AQZWD3p9+=ziS3Byw5e2ED1W_W=g@mail.gmail.com>
Date: Tue, 5 Jan 2016 12:57:27 -0200
Message-ID: <CAOMZO5CQ_jeEQTri9eFsib1yPDLCCRDkvk8+7Y=S==8VMOpA9g@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 1/3] ASoC: fsl_ssi: mark SACNT register
 volatile
From: Fabio Estevam <festevam@gmail.com>
To: Timur Tabi <timur@tabi.org>
Cc: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
 "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
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

Timur,

On Thu, Dec 24, 2015 at 2:12 PM, Timur Tabi <timur@tabi.org> wrote:
> On Sun, Dec 20, 2015 at 2:30 PM, Maciej S. Szmigiero
> <mail@maciej.szmigiero.name> wrote:
>> SACNT register should be marked volatile since
>> its WR and RD bits are cleared by SSI after
>> completing the relevant operation.
>> This unbreaks AC'97 register access.
>>
>> Fixes: 05cf237972fe ("ASoC: fsl_ssi: Add driver suspend and resume to support MEGA Fast")
>>
>> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
>
> These patches seem okay, but can we hold off merging them until I get
> back from vacation and have a chance to review them?

Have you had a chance to review these patches?
