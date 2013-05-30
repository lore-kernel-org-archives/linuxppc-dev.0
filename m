Return-Path: <mturquette@linaro.org>
Received: from mail-pd0-f178.google.com (mail-pd0-f178.google.com
 [209.85.192.178])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2F6ED2C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 May 2013 05:21:49 +1000 (EST)
Received: by mail-pd0-f178.google.com with SMTP id w11so886989pde.23
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 12:21:47 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Mike Turquette <mturquette@linaro.org>,  <Yuantian.Tang@freescale.com>, 
From: Mike Turquette <mturquette@linaro.org>
In-Reply-To: <20130530185732.4470.91176@quantum>
References: <1369210939-25087-1-git-send-email-Yuantian.Tang@freescale.com>
 <20130530185732.4470.91176@quantum>
Message-ID: <20130530192143.4470.23214@quantum>
Subject: Re: [PATCH] clk/mpc85xx: Update the compatible string
Date: Thu, 30 May 2013 12:21:43 -0700
Cc: Tang Yuantian <Yuantian.Tang@freescale.com>,
 devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Quoting Mike Turquette (2013-05-30 11:57:32)
> Quoting Yuantian.Tang@freescale.com (2013-05-22 01:22:19)
> > From: Tang Yuantian <yuantian.tang@freescale.com>
> > =

> > The compatible string of clock is changed from *-2 to *-2.0
> > on chassis 2. So updated it accordingly.
> > =

> > Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> =

> Taken into clk-next.
> =


One small nitpick.  I updated the $SUBJECT to:

clk: mpc85xx: Update the compatible string

The difference being "clk: mpc85xx:" versus "clk/mpc85xx:".  Please use
the former format in the future.

Thanks,
Mike

> Regards,
> Mike
> =

> > ---
> >  drivers/clk/clk-ppc-corenet.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > =

> > diff --git a/drivers/clk/clk-ppc-corenet.c b/drivers/clk/clk-ppc-corene=
t.c
> > index a2d483f..e958707 100644
> > --- a/drivers/clk/clk-ppc-corenet.c
> > +++ b/drivers/clk/clk-ppc-corenet.c
> > @@ -260,7 +260,7 @@ static int __init ppc_corenet_clk_probe(struct plat=
form_device *pdev)
> >  =

> >  static const struct of_device_id ppc_clk_ids[] __initconst =3D {
> >         { .compatible =3D "fsl,qoriq-clockgen-1.0", },
> > -       { .compatible =3D "fsl,qoriq-clockgen-2", },
> > +       { .compatible =3D "fsl,qoriq-clockgen-2.0", },
> >         {}
> >  };
> >  =

> > -- =

> > 1.8.0
