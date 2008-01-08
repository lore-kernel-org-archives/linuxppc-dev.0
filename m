Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E3FBCDE050
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 03:46:03 +1100 (EST)
Date: Tue, 8 Jan 2008 10:40:44 -0600
From: Scott Wood <scottwood@freescale.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] i2c-ibm_iic driver - new patch
Message-ID: <20080108164044.GA4949@loki.buserror.net>
References: <477EF225.4070505@pikatech.com>
	<20080108155240.503ca3ab.sfr@canb.auug.org.au>
	<4783108B.6070308@pikatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4783108B.6070308@pikatech.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Stefan Roese <sr@denx.de>,
	Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 08, 2008 at 12:56:27AM -0500, Sean MacLennan wrote:
> Stephen Rothwell wrote:
> > On Mon, 07 Jan 2008 21:03:12 -0500 Sean MacLennan <smaclennan@pikatech.com> wrote:
> >> +static int __devinit iic_probe(struct of_device *ofdev,
> >> +							   const struct of_device_id *match)
> >>     
> >
> > Indenting could be better.
> >   
> Sorry. Since this kernel is in a "work" directory and not in 
> /usr/src/linux* my rules for deciding on the tab size didn't work :( I 
> tried to correct the tabbing.

Better to tab to the semantic indentation level (in this case there is
none), and then use spaces to align -- that way it looks right regardless of
what the tab size is set to.

-Scott
