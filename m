Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by ozlabs.org (Postfix) with ESMTP id EDCE8DDE19
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Nov 2007 09:03:41 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so2309365wag
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 14:03:41 -0800 (PST)
Message-ID: <9e4733910711131403o51e6d3fbk8be141ca67119a65@mail.gmail.com>
Date: Tue, 13 Nov 2007 17:03:41 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: Hardware debuggers for PPC74xx G4 CPUs
In-Reply-To: <fa686aa40711131357r6b072f4cgcd43c5cb8e73abdb@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071113214845.85820@gmx.net>
	<fa686aa40711131357r6b072f4cgcd43c5cb8e73abdb@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 11/13/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> On 11/13/07, Gerhard Pircher <gerhard_pircher@gmx.net> wrote:
> > I'm trying to debug a kernel lockup that occurs on my machine with all kernel
> > versions >2.6.16. I don't have a clue what the root cause of this lockup is,
> > thus I'm thinking about using a hardware debugger. Can anybody recommend a
> > reasonably cheap hardware debugger that works with G4 CPUs and can interact
> > with GDB/DDD?
>
> Abatron BDI-2000.

Does anyone have the detailed doc needed to implement the software for
a PPC hardware debugger? Dominic, the author of OpenOCD, has said he
will take a look at adding PPC support if someone can supply him with
the right doc.

I've requested it from my Freescale rep. They sent me all of the
hardware info but none of the software info. They can't seem to figure
out what I'm asking for.

-- 
Jon Smirl
jonsmirl@gmail.com
