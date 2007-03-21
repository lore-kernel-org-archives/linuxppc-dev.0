Return-Path: <sr@denx.de>
Received: from mo-p07-ob.rzone.de (mo-p07-ob.rzone.de [81.169.146.190])
	by ozlabs.org (Postfix) with ESMTP id BC99ADDFFD
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Mar 2007 03:07:02 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] PPC440EPx/440GRx Sequoia/Rainier board support.
Date: Wed, 21 Mar 2007 17:06:53 +0100
References: <20070321154317.924703535D3@atlas.denx.de>
In-Reply-To: <20070321154317.924703535D3@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200703211706.54260.sr@denx.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 21 March 2007 16:43, Wolfgang Denk wrote:
> > --- linux.orig/arch/ppc/platforms/4xx/ppc440epx.c	1970-01-01
> > 03:00:00.000000000 +0300 +++
> > linux/arch/ppc/platforms/4xx/ppc440epx.c	2007-03-20 14:43:37.000000000
> > +0300 @@ -0,0 +1,284 @@
> > +/*
> > + * arch/ppc/platforms/4xx/ppc440epx.c
> > + *
> > + * PPC440EPx I/O descriptions
> > + *
> > + * Wade Farnsworth <wfarnsworth@mvista.com>
> > + * Copyright 2004-2007 MontaVista Software Inc.
> > + * Copyright 2006 AMCC
>
> The same file in our repository looks like this:
>
> /*
>  * arch/ppc/platforms/4xx/ppc440epx.c
>  *
>  * PPC440EPx I/O descriptions
>  *
>  * Copyright 2007 DENX Software Engineering, Stefan Roese <sr@denx.de>
>  *
>  * Wade Farnsworth <wfarnsworth@mvista.com>
>  * Copyright 2004 MontaVista Software Inc.
>  * Copyright 2006 AMCC
>
>
> In other words: You *removed* Stefan Roese's (resp.  DENX)  Copyright
> entry, and replaced it by one for MV?

Just to make things clear: 

The copyright in our version was added just a few days ago. So I think
the Mvista code is based on an older version without the copyright.

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH, HRB 165235 Munich, CEO: Wolfgang Denk
Office:  Kirchenstr. 5,       D-82194 Groebenzell,            Germany
=====================================================================
