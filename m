Message-ID: <3F8D57F6.6020708@imc-berlin.de>
Date: Wed, 15 Oct 2003 16:21:42 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Lokesh Kumar <kumar.lokesh@wrx-us.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mpc8xx memory mapped 16550A uart garbage
References: <3439AB3A99ECD5409F3A52ACF814744D158DA0@norcom2.norcom.net>
In-Reply-To: <3439AB3A99ECD5409F3A52ACF814744D158DA0@norcom2.norcom.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Lokesh Kumar wrote:

> Hi,
> I got the serial.c from DENX linuxppc_2.4._devel tree which has support for
> 16550A as memory mapped uart, and am using it as a module. I made
> modifications to match my board. When I start it, it correctly recognizes
> that I have a 16550A and at correct IRQ. However, when I open and send
> something through the port (I just do cat>/dev/ttySe0), I get garbage on the
> other side. My 16550 has a crystal of 3.6864MHz and the processor runs at
> 49MHz. I thought that this kind of garbage problem is generally due to baud
> rate not set correctly. I see the divisor correctly calculated as
> 3686400/16/9600 = 24 and being sent to 16550. What else could I be doing
> wrong?

Did you verify the baudrate using a scope to measure the bittime?

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
