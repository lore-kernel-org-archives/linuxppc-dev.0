Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 0BC8267A2E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 12 May 2005 22:55:22 +1000 (EST)
From: David Jander <david.jander@protonic.nl>
To: Wolfgang Denk <wd@denx.de>
Date: Thu, 12 May 2005 14:55:15 +0200
References: <20050511132810.E7228C1512@atlas.denx.de>
In-Reply-To: <20050511132810.E7228C1512@atlas.denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200505121455.15864.david.jander@protonic.nl>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Status of isp116x driver... (on mpc8xx)?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 11 May 2005 15:28, Wolfgang Denk wrote:
>[...]
> > Is the isp1160 chip really supported by the driver? tested?
>
> We only use (and tested) this driver with a ISP1361 ...

Ok. The sources of your driver and the one from Roman Weissgaerber look very 
different, so I can't really tell: did you start from scratch and picked some 
things from RW's driver, or did you modify (beyond recognition) and extend 
his driver?
I ask, because now I have RW's driver (version 0.9.6) working almost 100% 
alright. The issues we still have are most probably related to bus-timing 
problems (the ISP1160 is connected via a CPLD on an 8-bit wide bus controlled 
by UPMA!) and occur sporadically. Your driver OTOH still doesn't manage to 
receive Atl packets that are not entirely filled with zeroes ;-)

> > Is someone using a isp116x on a mpc8xx and can tell his experience on
> > getting it working?
>
> Sorry, we don't have any experience with a 1160. The  driver  in  our
> tree  works fine with the 1362, both as host driver and as device (as
> a gadget driver).

I'll work on the problem, and if I get your driver working, I'll send a patch 
that hopefully fixes 116x support again ;-)

Greetings,

-- 
David Jander
Protonic Holland.
