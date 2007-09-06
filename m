Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 7019ADDE35
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 09:45:26 +1000 (EST)
Date: Thu, 6 Sep 2007 18:45:37 -0500
From: Olof Johansson <olof@lixom.net>
To: Scott Wood <scottwood@freescale.com>,
	Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 8/9] 8xx: Adder 875 support
Message-ID: <20070906234537.GA23338@lixom.net>
References: <20070906141620.GB16353@ld0162-tx32.am.freescale.net>
	<f26578467468e38345e795ea5f1f7c42@kernel.crashing.org>
	<20070906180922.GA18750@ld0162-tx32.am.freescale.net>
	<598e0baf0dc1ca63b91f2a80ec8abe19@kernel.crashing.org>
	<20070906191255.GA22663@ld0162-tx32.am.freescale.net>
	<20070906192025.GA22775@ld0162-tx32.am.freescale.net>
	<43ad9218d498e2d01922a57ebfee2327@kernel.crashing.org>
	<20070906195614.GA23333@ld0162-tx32.am.freescale.net>
	<143f0a1c76539260fd41fe953e6d1bdf@kernel.crashing.org>
	<20070906213023.GA6399@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070906213023.GA6399@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Sep 06, 2007 at 04:30:23PM -0500, Scott Wood wrote:
> On Thu, Sep 06, 2007 at 10:57:28PM +0200, Segher Boessenkool wrote:
> > >>>BTW, IEEE1275 seems to disagree:
> > >>
> > >>No it doesn't.
> > >
> > >"...in conventional usage the string begins with the name of the 
> > >device's
> > >manufacturer".
> > 
> > You cut that sentence short here, it continues: "as with the name
> > property."
> 
> You ignored the next sentence, which addressed exactly that point.

Give it up guys.

Segher, can you please stop riding everybody for every single little
detail in the device trees. Noone will be hurt by the fact that a company
name is part of a machine model string.

This is just a huge productivity sink. How about spending the time
(and bandwidth) on something useful instead?


Thanks,

-Olof
