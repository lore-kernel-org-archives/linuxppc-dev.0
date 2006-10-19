Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id 7157E67B77
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 19 Oct 2006 18:13:42 +1000 (EST)
Date: Thu, 19 Oct 2006 10:13:37 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: status of mpc52xx with arch=powerpc?
Message-ID: <20061019081337.GF6202@localhost.localdomain>
References: <20061018130628.GE6202@localhost.localdomain>
	<528646bc0610180652u2ee8e8b4xe25d555a59a27c85@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <528646bc0610180652u2ee8e8b4xe25d555a59a27c85@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Oct 18, 2006 at 07:52:02AM -0600, Grant Likely wrote:
> On 10/18/06, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> >Is someone working on this already?
> >
> >There are some Kconfig entries, but there seems to be no code, at least
> >not in vanilla.
> 
> I'm slowly working on it.  I've got a .dts written and I've got u-boot
> w/ the fdt patches running on the board.  I need to port the 52xx PIC
> driver into arch/powerpc before I attempt to boot.

Could you post your .dts?
I'm too working on it, so maybe we should stay synchronized. At the
moment I have nothing but a minimal dts and some .progress() messages.

Sascha

-- 
 Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry
    Handelsregister: Amtsgericht Hildesheim, HRA 2686
      Hannoversche Str. 2, 31134 Hildesheim, Germany
    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
