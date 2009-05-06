Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 594ABDDD0B
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 08:01:22 +1000 (EST)
To: Grant Likely <grant.likely@secretlab.ca>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 02/12] fs_enet: Add MPC5121 FEC support.
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <fa686aa40905061333q29c263c8p24856c048e30f4d0@mail.gmail.com>
References: <1241640919-4650-1-git-send-email-wd@denx.de>
	<1241640919-4650-3-git-send-email-wd@denx.de>
	<fa686aa40905061333q29c263c8p24856c048e30f4d0@mail.gmail.com>
Date: Thu, 07 May 2009 00:01:19 +0200
Message-Id: <20090506220119.7322783420E8@gemini.denx.de>
Cc: Piotr Ziecik <kosmo@semihalf.com>, Detlev Zundel <dzu@denx.de>,
	netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Grant,

in message <fa686aa40905061333q29c263c8p24856c048e30f4d0@mail.gmail.com> you wrote:
>
...
> > #ifdef CONFIG_FS_ENET_HAS_FEC
> > +#ifdef CONFIG_FS_ENET_MPC5121_FEC
> > +    {
> > +        .compatible = "fsl,mpc5121-fec",
> > +        .data = (void *)&fs_fec_ops,
> > +    },
> > +#else
> >    {
> >        .compatible = "fsl,pq1-fec-enet",
> >        .data = (void *)&fs_fec_ops,
> >    },
> > #endif
> > +#endif
>
> Hmmm.  A lot of these #ifdefs in here.  Does this have a multiplatform
> impact?  Not to mention the fact that it's just plain ugly.  :-)

Agreed that it's ugly, but duplicatio9ng the code would have been even
worse. I don't think that it has multiplatform - at least not as long
as you don't ask for one image that runs on 83xx and on 512x.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Our business is run on trust.  We trust you will pay in advance.
