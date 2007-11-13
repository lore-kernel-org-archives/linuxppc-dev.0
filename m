Return-Path: <sprasad@bivio.net>
Received: from corpexc01.corp.networkrobots.com (nofear-snat.bivio.net
	[216.142.75.231]) by ozlabs.org (Postfix) with ESMTP id 73DE9DDD0C
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 13:58:09 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: printk/console_init
Date: Mon, 12 Nov 2007 18:54:49 -0800
Message-ID: <D83235F0F3C86D4D889D8B9A0DA8C6D7F73BF1@corpexc01.corp.networkrobots.com>
From: "Siva Prasad" <sprasad@bivio.net>
To: <linuxppc-dev@ozlabs.org>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I am using 2.6.19 Linux on 8641D based system.

I am using early printk's and it works fine until console_init() is
executed. After that it does not, as the early printk's get disabled,
which is fine. However, I don't see any prints after that at all, that
are based on regular printk statements. I looked directly into the
memory at __log_buf and found all the print messages. It is just not
coming out to the serial port properly.

It would be great if some one can tell me various parameters that I need
to consider changing, to successfully port the serial driver for a new
board.

Based on the early printk's, I am getting the following messages...

Using MPC86xx HPCN machine description
Total memory =3D 1024MB; using 2048kB for hash table (at cfe00000)
Linux version 2.6.19 (sprasad@cider.bivio.net) (gcc version 4.1.1
20060525 (Red Hat 4.1.1-1)) #115 SMP Mon Nov 12 18:21:43 PST 2007
Found legacy serial port 0 for /soc8641@ff700000/serial@4500
  mem=3Dff704500, taddr=3Dff704500, irq=3D1a, clk=3D1496250, speed=3D0
Found MPC86xx PCIE host bridge at 0x00000000ff708000. Firmware bus
number: 0->254
Found MPC86xx PCIE host bridge at 0x00000000ff709000. Firmware bus
number: 0->255
MPC86xx HPCN board from Freescale Semiconductor
Zone PFN ranges:
  DMA             0 ->   196608
  Normal     196608 ->   196608
  HighMem    196608 ->   262144
early_node_map[1] active PFN ranges
    0:        0 ->   262144
start_kernel: 8 22000000.
Built 1 zonelists.  Total pages: 260096
Kernel command line: console=3DttyS0,115200 root=3D/dev/sda8
mpic: Setting up MPIC " MPIC     " version 1.2 at ff740000, max 2 CPUs
mpic: ISU size: 16, shift: 4, mask: f
mpic: Initializing for 80 sources
PID hash table entries: 4096 (order: 12, 16384 bytes)
time_init: decrementer frequency =3D 150.000000 MHz
time_init: processor frequency   =3D 1496.250000 MHz
<........ Nothing gets printed after this .......>

Thanks
Siva
