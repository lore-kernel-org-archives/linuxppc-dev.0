Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 8DFDBDDED2
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Jul 2007 06:05:26 +1000 (EST)
Date: Sat, 21 Jul 2007 15:18:37 -0500
From: Olof Johansson <olof@lixom.net>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v3] pcmcia: CompactFlash driver for PA Semi Electra boards
Message-ID: <20070721201837.GA17814@lixom.net>
References: <20070625010311.GA31355@lixom.net>
	<20070625171221.GA6684@lixom.net>
	<20070625193909.GA26021@infradead.org>
	<20070625204341.GA8865@lixom.net>
	<20070705144914.GA14284@lixom.net>
	<20070720164823.95608e43.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070720164823.95608e43.akpm@linux-foundation.org>
Cc: Christoph Hellwig <hch@infradead.org>, linuxppc-dev@ozlabs.org,
	linux-pcmcia@lists.infradead.org, linux-kernel@vger.kernel.org,
	miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jul 20, 2007 at 04:48:23PM -0700, Andrew Morton wrote:

> > Who's maintaining PCMCIA? MAINTAINERS only lists a mailing list, no person. Seems
> > weird for a component that's marked as maintained.
> 
> Dominik Brodowski.  He's having a bit of downtime at present (exams, I
> think).  He expects to return.  Meanwhile, cc'ing me usually has some
> effect.

Thanks!

> > +static const char driver_name[] = "electra-cf";
> >
> > ...
> >
> > +static struct of_device_id electra_cf_match[] =
> > +{
> > +	{
> > +		.compatible   = "electra-cf",
> > +	},
> > +	{},
> > +};
> 
> Could have reused driver_name[] here, if that was appropriate.

Driver name and device tree compatible field is not neccessarily the same,
even though they do coincide here.

> > --- mainline.orig/arch/powerpc/platforms/pasemi/setup.c
> > +++ mainline/arch/powerpc/platforms/pasemi/setup.c
> 
> I never know who maintains random-scruffy-ppc code like this.  From a peek
> in the git-whatchanged output, it appears to be yourself.

Check the top of the file. :)  (Kumar started doing that, I kept it up,
seems useful). And yes, we do tend to have per-platform maintainers
on ppc.

> Have a few little fixies:

Thanks!

Acked-by: Olof Johansson <olof@lixom.net>

> --- a/drivers/pcmcia/electra_cf.c~pcmcia-compactflash-driver-for-pa-semi-electra-boards-fix
> +++ a/drivers/pcmcia/electra_cf.c
[...]
