Return-Path: <g.jaeger@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id 0856468528
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Oct 2005 16:44:02 +1000 (EST)
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: linuxppc-embedded@ozlabs.org
Date: Wed, 12 Oct 2005 08:43:43 +0200
References: <DADA32856852FC458E0F96B664A6F55E73A8EF@kom-mailsrv1.kontron-modular.com>
	<4BD1885F-AD59-4FFF-8694-AB66BE80DF96@freescale.com>
In-Reply-To: <4BD1885F-AD59-4FFF-8694-AB66BE80DF96@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200510120843.43750.g.jaeger@sysgo.com>
Cc: Stefan Nickl <stefan.nickl@kontron.com>
Subject: Re: Which PHY connection to use on MPC8541...
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tuesday 11 October 2005 20:05, Andy Fleming wrote:
> On Oct 11, 2005, at 05:57, Stefan Nickl wrote:
> > Hi,
> >
> > about a year ago we resorted to using port pin MDIO in this situation
> > for the FCCs because the fcc_enet driver and the gianfar driver live
> > in separate worlds, so to speak.
> >
> > But in the meantime, Andy Fleming was very active regarding the PHY
> > abstraction layer. I still haven't seen patches that migrate fcc_enet
> > to using this layer, but the gianfar driver seems to use this code  
> > now.
> >
> The work to migrate the new fs_enet driver to use the TSEC MDIO is in  
> progress.  I have a few other things I'm working on right now, and  
> I've been having some hardware issues, but I've already done most of  
> the work to get the FCC to use the TSEC's MDIO bus.
> >
> > So I'd say quick solution: use TSEC1 MDIO for TSECs and cpm port pins
> > for FCC, clean solution: change fcc_enet to use the PHY abstraction
> > layer.
> >
> I'd say it depends on how long until your hardware is ready.  You  
> might want to wire up the cpm IO pins, just in case.  I have yet to  
> actually get the fs_enet driver to send packets on the 8560, so  
> there's no telling how long it will be before that driver works on 8541.
> 
> Andy
> 

Thank you guys for the quick answers. We already thought of additionally 
wireing up the cpm IO pins to have some kind of backup ;) We expect the
hardware to be available in february/march next year so I guess there's
pretty much time. 

Gerhard
