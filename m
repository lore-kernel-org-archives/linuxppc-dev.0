Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Content-Type: text/plain;
  charset="iso-8859-1"
From: Gerhard Jaeger <g.jaeger@sysgo.com>
To: =?iso-8859-1?q?I=F1igo=20Lopez=20Barranco?= <ilopez@albatros-sl.es>,
	<linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Lite5200 PCI not working
Date: Mon, 21 Jun 2004 12:26:24 +0200
References: <42A622EB18325843894BB8E1040E3DF5022753@sinaexchf>
In-Reply-To: <42A622EB18325843894BB8E1040E3DF5022753@sinaexchf>
MIME-Version: 1.0
Message-Id: <200406211226.24580.g.jaeger@sysgo.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

On Monday 21 June 2004 12:03, Iñigo Lopez Barranco wrote:
> Hi.
> I've bought a 3.3V PCI ethernet card (US Robotics 7900) and tried to use it
> with the Lite5200 kit, but when I power it, it doesn't even turn on, with
> both power LEDs (3.3V and 5V) off.

I don't understand, what do you mean "with both power LEDs off", the LEDs on
the Lite5200? If yes, then I guess you have a problem!

> What may be the problem and where should I look for it? Thanks.

One problem is, that not every 3.3V PCI card will work on the 5200Lite,
as of some problems of the MPC5200 with PCI timings (see the errata-sheet):
http://e-www.motorola.com/files/microcontrollers/doc/errata/MPC5200E.pdf

And of course it should be inserted correctly - sorry if this is too
obvious!

One card, that is known to work in this slot is the Intel eepro100 NIC.

Ciao,
  Gerhard


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
