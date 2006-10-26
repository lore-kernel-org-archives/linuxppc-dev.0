Return-Path: <sven.luther@wanadoo.fr>
Date: Thu, 26 Oct 2006 18:45:11 +0200
From: Sven Luther <sven@genesi-usa.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] General CHRP/MPC5K2 platform support patch
Message-ID: <20061026164511.GA2378@powerlinux.fr>
References: <453FB582.20802@bplan-gmbh.de>
	<1161816783.22582.132.camel@localhost.localdomain>
	<45409760.7030902@bplan-gmbh.de>
	<1161866964.27827.2.camel@localhost.localdomain>
	<4540B0A9.6070404@bplan-gmbh.de>
	<528646bc0610260902o4d4996a4i3dcf2a9b874037c7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <528646bc0610260902o4d4996a4i3dcf2a9b874037c7@mail.gmail.com>
Cc: akpm@osdl.org, linuxppc-embedded@ozlabs.org, sl@bplan-gmbh.de,
	linuxppc-dev@ozlabs.org, sven@genesi-usa.com, sha@pengutronix.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 26, 2006 at 10:02:00AM -0600, Grant Likely wrote:
> >+config PPC_MPC52xx_PIC
> >+        bool
> >+       depends on PPC_CHRP
> >        default y
> 
> This isn't good for embedded 52xx boards.  Anything u-boot based
> cannot be CHRP.  Please drop the "depends on" line

This was a direct suggestion from benh, ppc_chrp should not be dropped, but
ored with whatever you are using, or somethiung like it.

Friendly,

Sven Luther
