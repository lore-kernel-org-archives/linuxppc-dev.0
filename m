Message-ID: <3960A691.4934D982@essegi.net>
Date: Mon, 03 Jul 2000 16:43:30 +0200
From: Gianluca Costa <gcosta@essegi.net>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: PReP kernel making
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I am trying  to compile the 2.2.15 kernel sources (Debian potato for the
ppc) for MCPN750 borad but
I am not able to understand why my zImage don't run. The output from
PPCBUG is:
...
PPC1-Bug>nbo

Network Booting from: DEC21143, Controller 0, Device 0
Device Name: /pci@80000000/pci1011,19@e,0:0,0
Loading: zImage

Client IP Address      = 192.168.30.189
Server IP Address      = 192.168.30.181
Gateway IP Address     = 0.0.0.0
Subnet IP Address Mask = 255.255.255.0
Boot File Name         = zImage
Argument File Name     =

Network Boot File load in progress... To abort hit <BREAK>

Bytes Received =&1021571, Bytes Loaded =&1021571
Bytes/Second   =&340523, Elapsed Time=3 Second(s)

Residual-Data Located at: $03F88000

(end)

I am using the default config that came with the kernel, but nothing
changes.

What should I do to make a bootable kernel image? What kind of
difference there can be between the
bootable  image I found on the debian distribution and the one I'm
trying to build?
Is there any patch or something other I should add to the plain sources?

Thanks in advance

Best regards,

Gianluca Costa
gcosta@essegi.net


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
