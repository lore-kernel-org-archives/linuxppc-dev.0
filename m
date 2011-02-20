Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D6448B718A
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 21 Feb 2011 08:36:58 +1100 (EST)
Subject: Re: Info : Using a PowerMac G5 as a server
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Romain Goyet <r.goyet@gmail.com>
In-Reply-To: <1298232300.8833.20.camel@pasglop>
References: <AANLkTi=bkvv0E6VhHtq9vEvADhPxWfQROkfUMaBqZq4f@mail.gmail.com>
	<1298232300.8833.20.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 21 Feb 2011 08:36:43 +1100
Message-ID: <1298237803.8833.23.camel@pasglop>
Mime-Version: 1.0
Cc: Tony Breeds <tonyb@au1.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2011-02-21 at 07:05 +1100, Benjamin Herrenschmidt wrote:

> Yes, there is. We reverse engineered that a while back and somebody even
> wrote a little tool to control it, though I don't remember where that
> can be found... If necessary, we can try to dig again, the RE wasn't
> that hard.

a quick look seems to indicate that a bunch of the necessary command
definitions are present in smu.h already. Search for SMU_POWER_EVENTS
and below.

You probably need to send a SMU_CMD_POWER_EVENTS_COMMAND with
SET_POWERUP_EVENTS and SMU_PWR_WAKEUP_AC_INSERT as arguments.

You can find examples of how to send SMU commands there:

http://gate.crashing.org/~benh/smu_wink.c

Fell free to submit your resulting new utility to powerpc-utils :-)

Cheers,
Ben.
