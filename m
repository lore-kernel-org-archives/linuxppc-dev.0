Return-Path: <glikely@secretlab.ca>
Message-ID: <fa686aa40708301415g15df8bf1na84f437ac8f17dcb@mail.gmail.com>
Date: Thu, 30 Aug 2007 15:15:45 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: [PATCH] mpc5200: add cuimage support for mpc5200 boards
In-Reply-To: <20070830210507.GA7757@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070830205550.11315.98506.stgit@trillian.cg.shawcable.net>
	<20070830210507.GA7757@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 8/30/07, Scott Wood <scottwood@freescale.com> wrote:
> On Thu, Aug 30, 2007 at 02:57:40PM -0600, Grant Likely wrote:
> > diff --git a/arch/powerpc/boot/mpc52xx-psc.c b/arch/powerpc/boot/mpc52xx-psc.c
> > new file mode 100644
> > index 0000000..46eecf0
> > --- /dev/null
> > +++ b/arch/powerpc/boot/mpc52xx-psc.c
> > @@ -0,0 +1,89 @@
> > +/*
> > + * CPM serial console support.
> > + *
> > + * Copyright 2007 Freescale Semiconductor, Inc.
> > + * Author: Scott Wood <scottwood@freescale.com>
> > + *
> > + * It is assumed that the firmware (or the platform file) has already set
> > + * up the port.
>
> Might want to update that comment block... :-)

HAHAHAHAHAHAHA!  Yeah, I'll fix that.  :-)

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
