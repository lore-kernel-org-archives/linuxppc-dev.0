Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z3MDq6f67zF0CF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 23 Dec 2017 08:32:58 +1100 (AEDT)
Message-ID: <1513978351.2743.84.camel@kernel.crashing.org>
Subject: Re: [RFC] macio airport how standard pccard?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: =?ISO-8859-1?Q?Ren=E9?= Rebe <rene@exactco.de>,
 linuxppc-dev@lists.ozlabs.org
Date: Sat, 23 Dec 2017 08:32:31 +1100
In-Reply-To: <5892E0F5-B2E2-44A3-B6DA-4D57833EF67F@exactco.de>
References: <5892E0F5-B2E2-44A3-B6DA-4D57833EF67F@exactco.de>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-12-22 at 16:18 +0100, René Rebe wrote:
> Hi all,
> 
> I have a nice 1.2 GHz G4 Cube on my desk, and if I could somehow get USB 2 into it, it would be way more useful as a “thin client” ;-)
> 
> I was looking at the macio airport kernel glue, but could not immediately figure out how much standard pcmcia/cardbus that is.
> Is there any chance I could hack up some kernel patch glue to get a pcmcia/pccard USB 2.0 NEC chip based card working in there - or is it totally hopeless?
> 
> Thanks for any tip and merry christmas!

I'm not 100% sure. I think it's some kind of PCMCIA card but PCMCIA is
basically just some kind of ISA bus with control lines.

I honestly don't know much more about it.

Cheers,
Ben.
 
