Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 0DAEF2C0082
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Aug 2013 22:51:32 +1000 (EST)
Message-ID: <1375447861.15999.1.camel@pasglop>
Subject: Re: therm_pm72 units, interface
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michel =?ISO-8859-1?Q?D=E4nzer?= <michel@daenzer.net>
Date: Fri, 02 Aug 2013 22:51:01 +1000
In-Reply-To: <1375437816.3852.12.camel@thor.local>
References: <alpine.LNX.2.01.1208151941010.22695@frira.zrqbmnf.qr>
 <1345066616.11751.2.camel@pasglop>
 <alpine.LNX.2.01.1301142240140.30171@nerf07.vanv.qr>
 <1358465885.2782.24.camel@pasglop>
 <20130719174300.GL14385@blackmetal.musicnaut.iki.fi>
 <1374275809.19894.562.camel@pasglop>
 <20130720203346.GM14385@blackmetal.musicnaut.iki.fi>
 <1375437816.3852.12.camel@thor.local>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Ben Hutchings <ben@decadent.org.uk>, Jan Engelhardt <jengelh@inai.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Aaro Koskinen <aaro.koskinen@iki.fi>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-08-02 at 12:03 +0200, Michel Dänzer wrote:
> Could a similar change fix the same problem on desktop G5s? The same
> values for slots_param in windfarm_pm112.c don't help, unfortunately.

You have a 11,2 and a noisy fan ? Odd, mine(s) don't.... I can dbl check
the values vs. what Darwin uses tomorrow...

The one that is known to have a noisy slot fan is the 7,2/7,3 one
because the Apple algorithm relies on sensors on the video card to
control the slots fan and I don't have the infrastructure for that in
Linux, so I set it to a fixed speed.

But the 11,2 should be fine.

Cheers,
Ben.
