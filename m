Message-ID: <20040227143725.94263.qmail@web12603.mail.yahoo.com>
Date: Fri, 27 Feb 2004 06:37:25 -0800 (PST)
From: Deepu Paulose Thachil <dpthachil@yahoo.com>
Subject: Porting Linux into IBM Spruce
To: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am trying to port linux into the IBM spruce board
(PPC750, CPC700..). The board currently works with
VxWorks.. I am using the linux-2.4.20 kernel..

I am not having a linux boot-loader right now. I have
to place the image into the SDRAM using a hardware
debugger tool. The tool that I amusing is Trace32.

There seems to be a problem loading the image into
SDRAm.. I tried to make the variables KERNELBASE and
KERNELLOAD to be 0x00000000.. Is that a correct
approach?? What are the problems that I should take
care of when I make such a change??

I have come to know that there seems to be an "offset"
parameter in the Hardware debugger tool.. Is it of any
use??

Regards,
DP


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
