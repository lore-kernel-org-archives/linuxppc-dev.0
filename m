From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Jeglinski <jeglin@4pi.com>,
	linux <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4.2 USB and "mon>" (was Re: All 6 cards!!!)
Date: Tue, 6 Mar 2001 17:55:15 +0100
Message-Id: <20010306165515.9932@mailhost.mipsys.com>
In-Reply-To: <p04330103b6caab5dee89@[38.205.4.5]>
References: <p04330103b6caab5dee89@[38.205.4.5]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Running 2.4.2 (kfukui) on 9500-class machine with an OrangeMicro USB
>firewire card [ADB keyboard + USB mouse], have noted 2 things:
>

Can you try a couple of things:

 - First, check if the kernel works without the USB card

 - Then, edit prom.c, and looks for the code that calls OF "quiesce" call.
   This code might be inside a if () checking OF version. If it is, then
remove
   the if () to force a call on all OF versions

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
