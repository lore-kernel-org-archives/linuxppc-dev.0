Message-ID: <3F8CEA04.9020805@imc-berlin.de>
Date: Wed, 15 Oct 2003 08:32:36 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Lokesh Kumar <kumar.lokesh@wrx-us.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: mpc8xx memory mapped 16550 extrenal uart driver
References: <3439AB3A99ECD5409F3A52ACF814744D158D9C@norcom2.norcom.net>
In-Reply-To: <3439AB3A99ECD5409F3A52ACF814744D158D9C@norcom2.norcom.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Lokesh Kumar wrote:

> I got the serial.c from DENX and am using it as a module. When I start it,
> it correctly recognizes that I have a 16550A serial and at correct IRQ.
> However, when I open and send something through the port, I get garbage on
> the other side. My 16550 has a crystal of 3.6864MHz and the processor runs
> at 49MHz. I thought that this kind of garbage problem is generally due to
> baud rate not set correctly. I see the divisor correctly calculated as
> 3686400/16/9600 = 24 and being sent to 16550. What else could be wrong?

Hmm. No idea. Sorry.

Did you try this?

Send one character over and over again over you serial line and use a scope to
measure the bit time. Just to make sure that timing is correct.

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
