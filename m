From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alain RICHARD <alain.richard@equation.fr>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: benh 2.4.4-pre3, Titanium and AirPort
Date: Wed, 18 Apr 2001 13:52:24 +0200
Message-Id: <20010418115224.25139@mailhost.mipsys.com>
In-Reply-To: <a05010404b703232d1b66@[192.168.240.10]>
References: <a05010404b703232d1b66@[192.168.240.10]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>I am currently using Benjamin Herrenschmidt 2.4.4-pre3 kernel on my
>Titanium. The only problem I am currently experiencing is that the
>kernel PCMCIA i82365.c driver do not recognized the PCI cardbus
>adaptator.

Looks like I'll really have to find a PCMCIA card...

>Is there any solution (patch) to get it recognized ?
>
>Also as the current airport driver is now based on the orinoco_cs
>(and hermes) driver that depends on PCMCIA support, I am unable to
>get airport working. Is there any solution to get it working without
>PCMCIA ?

The airport driver should work if you built PCMCIA in the kernel
(no need to actually have a working PCMCIA).

I'm working on a separation of the airport and pcmcia stuffs so
that the airport driver can be used without pcmcia, but it's not
done yet.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
