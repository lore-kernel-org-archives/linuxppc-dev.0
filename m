Message-ID: <3A13B00C.988212F9@inf.ethz.ch>
Date: Thu, 16 Nov 2000 10:59:40 +0100
From: Leonhard Jaschke <jaschke@inf.ethz.ch>
MIME-Version: 1.0
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: G4 internal modem
References: <3A13D8D9.20F0F22@denise.shiny.it>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Giuliano Pochini wrote:
>
> When I send something to ttyS0 I see from /proc/interrupts
> that interrupt counters for SCC change. Perhaps the serial
> interface works, but the modem is a winmodem... :(

I have a problem with the internal modem on the dual G4 450. When I try
to use minicom on /dev/ttyS0 it tells me that it can't find that device.

This happens allthough the kernel (2.2.18pre18) told me that he
recognized the internal modem (cobalt modem on tty00 .... is that right?
I mean - there is no /dev/tty00)

When minicom tries to access /dev/ttyS0 the speakers go on an off. Then
minicom tells me that the device can't be found. That's kind of wierd.
Could it be that there is some device driver inferring with the serial
device driver? How can I check that?

Can anybody help me?

Regards
	Leonhard

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
