Return-Path: <SRS0=T/s6=PD=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 4F023DDFBF
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 21:34:43 +1000 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/3] [POWERPC] Add AMCC Kilauea eval board support to
	platforms/40x
Date: Tue, 9 Oct 2007 13:34:16 +0200
References: <200710081108.51625.sr@denx.de> <20071008193404.GA10348@lixom.net>
In-Reply-To: <20071008193404.GA10348@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200710091334.16682.sr@denx.de>
Cc: Olof Johansson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Olof,

On Monday 08 October 2007, Olof Johansson wrote:
> > +config KILAUEA
> > +	bool "Kilauea"
> > +	depends on 40x
> > +	default y
> > +	select 405EX
> > +	help
> > +	  This option enables support for the AMCC PPC405EX evaluation board.
> > +
> >  #config REDWOOD_5
> >  #	bool "Redwood-5"
> >  #	depends on 40x
> > @@ -89,14 +97,17 @@ config 403GCX
> >  	#depends on OAK
> >  	select IBM405_ERR51
> >
> > +config 405EP
> > +	bool
> > +
> > +config 405EX
> > +	bool
> > +
>
> Do you really need config options for 405EP/EX? I don't seem them used
> anywhere else in the code (and it's also contradictory to the whole new
> multiplatform way of looking at stuff :).
>
> I know the 405/440 is still somewhat #ifdef:ed on the cpu here and there,
> but since this doesn't add any such code I don't see a need for the config
> options?

Yes, I'm still used to needing these defines from arch/ppc (for example for 
the 4xx EMAC driver). But its possible, that we really don't need it at all 
in arch/powerpc with all the device tree information. Not sure though.

Josh, what do you think? Should I remove the 405EX define completely?

Best regards,
Stefan
