From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Iain Sandoe <iain@sandoe.co.uk>, <linuxppc-dev@lists.linuxppc.org>
Subject: Re: pmud monitoring temperature (Re: powerbook doubles)
Date: Mon, 29 Jan 2001 17:18:59 +0100
Message-Id: <19341224095043.1630@mailhost.mipsys.com>
In-Reply-To: <20010129151910.792132EF9B@apollo.valhalla.net>
References: <20010129151910.792132EF9B@apollo.valhalla.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>> What is the maximum CPU speed for machines without clock_frequency
>> present in the device tree?
>
>wouldn't you have to go back quite a long way to find one?
>My 9600 has it - and that's nearly prehistoric ;-)

The problem is that this property is often wrong...

I think Troy's temperature code (in bk _2_5) is an hard-coded value that
should be good enough for most CPUs speeds. We did however notice quite
wrong results with some G4s used in Apple's dual G4s.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
