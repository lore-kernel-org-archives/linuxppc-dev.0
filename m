Return-Path: <rsc@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7EF7CDE0FE
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 16:51:12 +1000 (EST)
Date: Fri, 11 Apr 2008 08:51:00 +0200
From: Robert Schwebel <r.schwebel@pengutronix.de>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: State of the MPC5200 PSC AC97 driver
Message-ID: <20080411065100.GQ13814@pengutronix.de>
References: <47FDEF9B.5000506@semihalf.com> <47FE3160.2060907@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <47FE3160.2060907@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org, Sylvain Munaut <tnt@246tNt.com>,
	spitzauer_77@gmx.de, Marian Balakowicz <m8@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Matt,

On Thu, Apr 10, 2008 at 04:25:20PM +0100, Matt Sealey wrote:
> I have a copy of the driver I hacked to work with the new PSC
> framework but it doesn't "work" anymore - I have no idea why.
>
> Mail me privately if you want it, I have no time to make patches or
> look for a good reason for the breakages, but it compiles at least.
> The Efika hack should be gone now (irrelevant since we released a
> firmware that obseletes it) and the other fixmes should be by the
> wayside considering the fscking thing doesn't play sound anymore...

I'd be interested as well; do I read your mail right that you have
already managed to hear sound coming out of the MPC5200B PSC AC97
interface? You would be the first one I've heared of, so it would
definitely be interesting to see your code. 

Robert
-- 
 Dipl.-Ing. Robert Schwebel | http://www.pengutronix.de
 Pengutronix - Linux Solutions for Science and Industry
   Handelsregister:  Amtsgericht Hildesheim, HRA 2686
     Hannoversche Str. 2, 31134 Hildesheim, Germany
   Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
