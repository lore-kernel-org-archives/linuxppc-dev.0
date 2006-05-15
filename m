Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DC912679E0
	for <linuxppc-dev@ozlabs.org>; Mon, 15 May 2006 11:46:22 +1000 (EST)
Subject: Re: Load average 1.0 on idle machine
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Brian D. Carlstrom" <bdc@carlstrom.com>
In-Reply-To: <17510.55656.607530.491585@zot.electricrain.com>
References: <87wtcplejw.fsf@blackdown.de>
	<17510.55656.607530.491585@zot.electricrain.com>
Content-Type: text/plain
Date: Mon, 15 May 2006 11:45:58 +1000
Message-Id: <1147657558.21291.65.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2006-05-14 at 00:16 -0700, Brian D. Carlstrom wrote:
> Juergen Kreileder writes:
>  > with both 2.6.16.11 and 2.6.17-rc4 my PowerMac G5 Quad shows a load
>  > average of 1.0 when the machine is completely idle (just kernel, init,
>  > and bash running).
> 
> I see this as well, with the load coming from "kwindfarm". I just
> assumed this was expected because of the userlevel thermal control
> versus the older in kernel code for the PowerMac7,2 and 7,3 machines.

I double checked and the driver should sleep for a second every second
unless there the activity of actually doing the thermal control & i2c
fan control is really taking that much time... hrm... I suppose I should
dig a bit more but I don't have time at the moment. For now, consider
the load avergage value bogus :)

Ben.
