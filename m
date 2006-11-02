Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id AD8BE67BD5
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Nov 2006 02:25:31 +1100 (EST)
Date: Thu, 2 Nov 2006 16:25:27 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [patch 08/16] powerpc: remove EMBEDDED6xx Kconfig entry
Message-ID: <20061102152527.GB4928@localhost.localdomain>
References: <20061102125555.252338000@localhost.localdomain>
	<20061102125627.149261000@localhost.localdomain>
	<528646bc0611020658le3adc94p30f372f3a1a8b07e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <528646bc0611020658le3adc94p30f372f3a1a8b07e@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 02, 2006 at 07:58:39AM -0700, Grant Likely wrote:
> On 11/2/06, s.hauer@pengutronix.de <s.hauer@pengutronix.de> wrote:
> >remove EMBEDDED6xx Kconfig entry
> >
> >Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> >
> >Index: linux-2.6/arch/powerpc/Kconfig
> >===================================================================
> >--- linux-2.6.orig/arch/powerpc/Kconfig
> >+++ linux-2.6/arch/powerpc/Kconfig
> >@@ -338,10 +338,6 @@ config PPC_MULTIPLATFORM
> >          RS/6000 machine, an Apple machine, or a PReP, CHRP,
> >          Maple or Cell-based machine.
> >
> >-config EMBEDDED6xx
> >-       bool "Embedded 6xx/7xx/7xxx-based board"
> >-       depends on PPC32 && (BROKEN||BROKEN_ON_SMP)
> >-
> > config APUS
> >        bool "Amiga-APUS"
> >        depends on PPC32 && BROKEN
> >
> >--
> 
> If you do this, then where should embedded 6xx board ports go?  For
> example; mpc52xx for which there are currently patches on the mailing
> list.

I'm too working on the mpc52xx (I have nothing to submit though at the
moment, because my port is mainly copy-paste from arch=ppc).
I put my stuff under platforms/mpc52xx. I did this mainly because Nikolas
states his board isn't 'embedded', but mine is. I think this shows there
more a historical difference than a technical difference between 'embedded'
and 'not embedded' boards.
I'm running my board as a normal MULTIPLATFORM board and it works just
fine.

Sascha


-- 
 Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry
    Handelsregister: Amtsgericht Hildesheim, HRA 2686
      Hannoversche Str. 2, 31134 Hildesheim, Germany
    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
