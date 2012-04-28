Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 140F7B6FCB
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Apr 2012 10:42:45 +1000 (EST)
Message-ID: <1335573757.20866.12.camel@pasglop>
Subject: Re: Regression in 32-bit ppc kernel
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Larry Finger <Larry.Finger@lwfinger.net>
Date: Sat, 28 Apr 2012 10:42:37 +1000
In-Reply-To: <4F9B3398.9060701@lwfinger.net>
References: <4F973026.3020103@lwfinger.net>
 <1335311621.15830.42.camel@pasglop> <4F976352.4060001@lwfinger.net>
 <1335327081.21961.28.camel@pasglop> <4F98117C.7080309@lwfinger.net>
 <1335390257.21961.53.camel@pasglop> <4F9ABD67.3060704@lwfinger.net>
 <1335565573.20866.7.camel@pasglop> <4F9B3398.9060701@lwfinger.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2012-04-27 at 19:02 -0500, Larry Finger wrote:

> It is a 15" Powerbook G4. I think they call it a Titanium. The console is not on 
> a serial port. In fact, the reason that I did not think this patch was a problem 
> is because the serial port does not appear to be connected to an external port. 
> I was unaware that there was a serial port on the motherboard. There is a modem 
> jack, but no 9 or 25-pin connectors that would indicate a standard serial port.
> 
> There are two stack dumps with the same trace. I posted the first, but the 
> second is preceded by the lines
> 
> [<c02adca0] pmz_interrupt
> Disabling IRQ #23
> ttyPZ1: IrDA setup for 57600 bps, dongle version: 4
> ttyPZ1: IrDA setup for 115200 bps, dongle version: 4
> irq23: nobody cared (try booting with the "irqpoll" option
> 
> As I am not sure how to put options in with yaboot, I have not tried that.

Ok, so you do have a serial port, probably two even :-) One of them is
connected to the infra red transceiver and the other one is probably
connected to the internal modem.

(The modem itself might not use it, some of these machines use an
i2s/i2c modem, some use a usb modem, but the serial port is wired to the
connector regardless).

Cheers,
Ben.
