Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 51980DDF2C
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jan 2008 04:54:15 +1100 (EST)
Date: Thu, 10 Jan 2008 11:53:48 -0600
From: Scott Wood <scottwood@freescale.com>
To: Rune Torgersen <runet@innovsys.com>
Subject: Re: Help with device tree binding for SMC serial
Message-ID: <20080110175348.GA4317@loki.buserror.net>
References: <DCEAAC0833DD314AB0B58112AD99B93B03D58A34@ismail.innsys.innovsys.com>
	<4785246D.6090206@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B03D58BC9@ismail.innsys.innovsys.com>
	<47854AE1.7080802@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B03D58BEF@ismail.innsys.innovsys.com>
	<47854D6D.2010906@freescale.com>
	<DCEAAC0833DD314AB0B58112AD99B93B03D58C20@ismail.innsys.innovsys.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B03D58C20@ismail.innsys.innovsys.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 09, 2008 at 05:07:23PM -0600, Rune Torgersen wrote:
> > From: Scott Wood [mailto:scottwood@freescale.com] 
> > Rune Torgersen wrote:
> > > Did that, now we get e checkstop resert. Time to hook up the
> > > BDI-2000.... Is there a way to have the bootwrapper use the u-boot
> > > serial for a while (like a early srial port) for debugging?
> > 
> > If you mean calling into u-boot for a console, no, there's no 
> > code for that.
> > 
> > What do your cpm and muram nodes look like?
[snip tree]

The tree looks OK.  The checkstop may be from erratum SIU18;
I had this issue on the ep8248e board.

Try clearing BCR[PLDP].

-Scott
