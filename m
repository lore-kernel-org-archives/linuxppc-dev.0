Return-Path: <SRS0=QhAZ=NY=denx.de=sr@srs.kundenserver.de>
From: Stefan Roese <sr@denx.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/3] [POWERPC] Add PCI support for AMCC 440EPx (sequoia)
Date: Mon, 27 Aug 2007 10:05:19 +0200
References: <20070825091440.4087.1428.stgit@localhost.localdomain>
	<20070827015719.GD12804@localhost.localdomain>
	<20070827105507.768b1aad@localhost.localdomain>
In-Reply-To: <20070827105507.768b1aad@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200708271005.19740.sr@denx.de>
Cc: David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 27 August 2007, Vitaly Bordug wrote:
> On Mon, 27 Aug 2007 11:57:19 +1000
>
> David Gibson wrote:
> > > + * Free Software Foundation;  either version 2 of the  License, or
> > > (at your
> > > + * option) any later version.
> > > + */
> >
> > Unless there really is something peculiar about the EPx bridge
> > compared to say the GP, EP and other 4xx bridges, this should have a
> > more general name.
>
> well, I'd rather extend the name once/when it would be validated to work on
> those GR, EP etc. But, if preferred, it does not hurt to change all the
> prefixes to ppc4xx_ with such a sole implementation, and fork() if required
> later.
>
> opinions?

I would prefer to move to a more generic name now (as already suggest). 
Perhaps somebody (Josh?) has a chance to test this on Bamboo (440EP) soon.

Best regards,
Stefan
