Message-ID: <C18BA5DDB58DD511BD0700C0DF0DD45028B299@NTSERVER4>
From: Phil Thompson <philt@4bridgeworks.com>
To: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>
Subject: Serial Driver and IRQ0
Date: Mon, 26 Apr 2004 16:00:42 +0100
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The standard Linux serial driver uses an IRQ number of 0 to indicate a port
has no interrupt - but UART0 on a 4xx is on IRQ 0.  Therefore interrupts are
disabled for UART0 (ttyS0).

It's easy enough to hack the standard driver to work around the problem, but
is there a more elegent solution? I can't believe nobody has had to deal
with it before.

Thanks,
Phil

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
