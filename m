Message-ID: <3F4DEBA3.9020203@imc-berlin.de>
Date: Thu, 28 Aug 2003 13:46:43 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: /dev/ttyS1 vs /dev/ttyS01 ?
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

I know this isn't exactly a PPC related question but maybe someone could give me
a hint anyway:

What's the difference between the /dev/ttySx and the /dev/ttyS0x devices?

The Kernel first reports

ttyS00 at 0x03f8 (irq = 4) is a 16550A
ttyS01 at 0x02f8 (irq = 3) is a 16550A

and calls them later

ttyS0 at 0x03f8 (irq = 4) is a 16550A
ttyS1 at 0x02f8 (irq = 3) is a 16550A

Is that realy just the way it's printed using "%02d" by the kernel or is there a
deeper meaning behind that?

Thanks a million and sorry for the noise.

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
