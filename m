Date: Thu, 21 Nov 2002 18:10:50 +0000
From: Jess Balint <jbalinc@insight.rr.com>
To: LinuxPPC Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Debug Kernel Crash
Message-Id: <20021121181050.50682d58.jbalinc@insight.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all. I wish to know how to debug the kernel via the serial terminal. I have use the kernel, linux 2.4.19 and 2.4.20-rc2 as trying to load on a Motorola MCP750 (PReP).  The very first compile that I did booted alright, but everyone one after that does not. It stops at when residual data found. I don't know if something in my nvram is screwing it up. Following is the output when loading the kernel. Any pointers on how to debug this would be great. Thanks.

jess

_BEGIN_

PPC1-Bug>nbo
Network Booting from: DEC21140, Controller 0, Device 0
Device Name: /pci@80000000/pci1011,9@e,0:0,0
Loading: zImage.prep

Client IP Address      = 10.0.0.201
Server IP Address      = 10.0.0.73
Gateway IP Address     = 10.0.0.33
Subnet IP Address Mask = 255.0.0.0
Boot File Name         = zImage.prep
Argument File Name     =

Network Boot File load in progress... To abort hit <BREAK>

Bytes Received =&757210, Bytes Loaded =&757210
Bytes/Second   =&378605, Elapsed Time =2 Second(s)

Residual-Data Located at: $01F88000

_END_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
