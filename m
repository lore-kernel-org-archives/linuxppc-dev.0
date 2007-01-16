Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id F0BB2DDDEF
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jan 2007 19:25:05 +1100 (EST)
Date: Tue, 16 Jan 2007 09:25:00 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Discussion on SOC device tree bindings
Message-ID: <20070116082459.GC25974@localhost.localdomain>
References: <528646bc0701131555n3249b503i3b6e8c37db41dd52@mail.gmail.com>
	<528646bc0701141429q577f87f1oe65aa7033c09b62b@mail.gmail.com>
	<20070115110509.GA25974@localhost.localdomain>
	<5378f4dcd28423047dc3cfb1404f08e1@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5378f4dcd28423047dc3cfb1404f08e1@kernel.crashing.org>
Cc: linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Sven Luther <sven@genesi-usa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 15, 2007 at 04:42:18PM +0100, Segher Boessenkool wrote:
> 
> If that is so, than such a 5200b-specific driver can be
> created (possibly just as some special cases in the
> existing 5200 driver).
> 
> Listing something in the "compatible" property doesn't mean
> the device is 100% compatible, just that it's mostly compatible.
> Earlier entries in there are "more compatible" ;-)
> 
> 

OK, I see ;)

  Sascha

-- 
 Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry
    Handelsregister: Amtsgericht Hildesheim, HRA 2686
      Hannoversche Str. 2, 31134 Hildesheim, Germany
    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
