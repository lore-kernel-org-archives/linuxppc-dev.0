Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by ozlabs.org (Postfix) with ESMTP id D4107DDE41
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Aug 2007 14:38:00 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1217955wag
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Aug 2007 21:37:59 -0700 (PDT)
Message-ID: <fa686aa40708102137o25b83daar82a40471756a3f2b@mail.gmail.com>
Date: Fri, 10 Aug 2007 22:37:59 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Wolfgang Reissnegger" <wolfgang.reissnegger@xilinx.com>
Subject: Re: [PATCH] Consolidate XILINX_VIRTEX board support
In-Reply-To: <fa686aa40708091142n520f222amec7c6a76786c7fcc@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070806225642.7D72A7B005B@mail34-fra.bigfish.com>
	<fa686aa40708091142n520f222amec7c6a76786c7fcc@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 8/9/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> On 8/6/07, Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com> wrote:
> > Make support for Xilinx boards more generic, making it easier
> > to add new boards.  Add initial support for xupv2p and ml410 boards.
> >
> > Thanks,
> >    Wolfgang
> >
> >
> > Signed-off-by: Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com>
> > Signed-off-by: Stephen Neuendorffer <stephen.neuendorffer@xilinx.com>
>
> Comments below...
>
> > diff --git a/arch/ppc/boot/simple/embed_config.c b/arch/ppc/boot/simple/embed_config.c
> > index 840bff2..e0b8954 100644
> > --- a/arch/ppc/boot/simple/embed_config.c
> > +++ b/arch/ppc/boot/simple/embed_config.c
> > @@ -744,7 +744,7 @@ embed_config(bd_t **bdp)
> >  }
> >  #endif /* WILLOW */
> >
> > -#if defined(CONFIG_XILINX_ML300) || defined(CONFIG_XILINX_ML403)
> > +#if defined(CONFIG_XILINX_VIRTEX)
>
> You need to rebase your patch to mainline.  This change has already been applied

Oops, my mistake.  This change is in my tree, but not in mainline.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
