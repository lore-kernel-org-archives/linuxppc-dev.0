Return-Path: <sha@pengutronix.de>
Received: from metis.extern.pengutronix.de (metis.extern.pengutronix.de
	[83.236.181.26]) by ozlabs.org (Postfix) with ESMTP id EA39367B9E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 20 Oct 2006 00:17:19 +1000 (EST)
Date: Thu, 19 Oct 2006 16:17:14 +0200
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Roman Fietze <roman.fietze@telemotive.de>
Subject: Re: status of mpc52xx with arch=powerpc?
Message-ID: <20061019141714.GH6202@localhost.localdomain>
References: <20061018130628.GE6202@localhost.localdomain>
	<528646bc0610180652u2ee8e8b4xe25d555a59a27c85@mail.gmail.com>
	<20061019081337.GF6202@localhost.localdomain>
	<200610191149.10873.roman.fietze@telemotive.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200610191149.10873.roman.fietze@telemotive.de>
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

On Thu, Oct 19, 2006 at 11:49:07AM +0200, Roman Fietze wrote:
> Hello,
> 
> On Thursday 19 October 2006 10:13, Sascha Hauer wrote:
> 
> > Could you post your .dts?
> > I'm too working on it, so maybe we should stay synchronized. At the
> > moment I have nothing but a minimal dts and some .progress() messages.
> 
> Could you both double check e.g. with Sylvain Munaut at
> 
>   http://246tnt.com/mpc52xx/

I have his tree here and and it does not seem to contain bits for
mpc52xx with arch=powerpc (unless there are some git-secrets I'm not
aware of)

> 
> There are many drivers (git heads) available already, including IDE,
> FEC, and so on. There's also new BestComm/FEC/IDE code from Dale
> Farnsworth and John Rigby (Freescale) somewhere on the net.
> 

We have these drivers running already with arch=ppc. I have not looked
into it deeper, but I think (well, hope) they only need minor changes
like a transition from platform_device to of_device.

I just received a patch from nicolas det with a port from ppc to
powerpc, I'll have a look at it. He posted it on linuxppc-dev

Sascha

-- 
 Dipl.-Ing. Sascha Hauer | http://www.pengutronix.de
  Pengutronix - Linux Solutions for Science and Industry
    Handelsregister: Amtsgericht Hildesheim, HRA 2686
      Hannoversche Str. 2, 31134 Hildesheim, Germany
    Phone: +49-5121-206917-0 |  Fax: +49-5121-206917-9
