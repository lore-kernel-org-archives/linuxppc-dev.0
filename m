Return-Path: <mturquette@linaro.org>
Received: from mail-pa0-f54.google.com (mail-pa0-f54.google.com
 [209.85.220.54])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E98931A09A9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 27 Sep 2014 09:29:29 +1000 (EST)
Received: by mail-pa0-f54.google.com with SMTP id ey11so2336964pad.41
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 26 Sep 2014 16:29:27 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>, 
From: Mike Turquette <mturquette@linaro.org>
In-Reply-To: <1411685780.13320.209.camel@snotra.buserror.net>
References: <1411454806-8214-1-git-send-email-jingchang.lu@freescale.com>
 <d4a375f40b544cf1ae78ac82dc20569c@BL2PR03MB467.namprd03.prod.outlook.com>
 <1411675680.13320.201.camel@snotra.buserror.net>
 <20140925225406.19023.25065@quantum>
 <1411685780.13320.209.camel@snotra.buserror.net>
Message-ID: <20140926232900.19023.35854@quantum>
Subject: Re: [PATCHv4] clk: ppc-corenet: rename to ppc-qoriq and add
 CLK_OF_DECLARE support
Date: Fri, 26 Sep 2014 16:29:00 -0700
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Lu Jingchang-B35083 <jingchang.lu@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Quoting Scott Wood (2014-09-25 15:56:20)
> On Thu, 2014-09-25 at 15:54 -0700, Mike Turquette wrote:
> > Quoting Scott Wood (2014-09-25 13:08:00)
> > > Well, like I said, I'd rather see the CLK_OF_DECLARE stuff be made to
> > > work on PPC rather than have the driver carry around two binding
> > > methods.
> > =

> > I guess that is an existing problem, and not related directly to this
> > patch? This patch is essentially just renames (though the V1.0/V2.0
> > stuff seems weird).
> =

> This patch is adding CLK_OF_DECLARE.

I'm fine taking this patch but your comments are still unresolved. What
do you think needs to be done to fix the problems that you see?

Regards,
Mike

> =

> -Scott
> =

>=20
