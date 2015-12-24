Return-Path: <timur@tabi.org>
Received: from muin.pair.com (muin.pair.com [209.68.1.55])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 549A21A0211
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Dec 2015 03:20:47 +1100 (AEDT)
Received: from mail-io0-f182.google.com (mail-io0-f182.google.com
 [209.85.223.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by muin.pair.com (Postfix) with ESMTPSA id CAE1BF1840
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Dec 2015 11:12:41 -0500 (EST)
Received: by mail-io0-f182.google.com with SMTP id q126so245415197iof.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Dec 2015 08:12:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <56770FE1.4060202@maciej.szmigiero.name>
References: <56770FE1.4060202@maciej.szmigiero.name>
Date: Thu, 24 Dec 2015 10:12:41 -0600
Message-ID: <CAOZdJXVK-_j+pF+dXsnWd0AQZWD3p9+=ziS3Byw5e2ED1W_W=g@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 1/3] ASoC: fsl_ssi: mark SACNT register
 volatile
From: Timur Tabi <timur@tabi.org>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
 Xiubo Li <Xiubo.Lee@gmail.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Liam Girdwood <lgirdwood@gmail.com>,
 Nicolin Chen <nicoleotsuka@gmail.com>, Mark Brown <broonie@kernel.org>,
 Fabio Estevam <festevam@gmail.com>,
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

On Sun, Dec 20, 2015 at 2:30 PM, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
> SACNT register should be marked volatile since
> its WR and RD bits are cleared by SSI after
> completing the relevant operation.
> This unbreaks AC'97 register access.
>
> Fixes: 05cf237972fe ("ASoC: fsl_ssi: Add driver suspend and resume to support MEGA Fast")
>
> Signed-off-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>

These patches seem okay, but can we hold off merging them until I get
back from vacation and have a chance to review them?
