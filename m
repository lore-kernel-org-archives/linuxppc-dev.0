Message-ID: <408CF268.9050105@cs.fujitsu.co.jp>
Date: Mon, 26 Apr 2004 20:28:40 +0900
From: Takeharu KATO <tkato@cs.fujitsu.co.jp>
MIME-Version: 1.0
To: Matt Porter <mporter@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PPC440GX GigE support
References: <20040419115634.A19863@home.com>
In-Reply-To: <20040419115634.A19863@home.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Porter:

I have exported your linux-2.5-ocp source and build the kernel.
But it did not work. According to kernel messages,
it may release the same memory pages twice.

Did you fix this problem?

Regards,

-- kernel message
mal0: Initialized, 4 tx channels, 4 rx channels
emac: IBM EMAC Ethernet driver, version 2.0
Maintained by Benjamin Herrenschmidt <benh@kernel.crashing.org>
zmii0: input 0 in SMII mode
eth0: IBM e15 (release)) #10 Thu Apr 22 18:00:34 JST 2004
IBM Ocotea port (MontaVista Software, Inc. <source@mvista.com>)
On node 0 totalpages: 65536
  DMA zone: 65536 pages, LIFO batch:16
  Normal zone: 0 pages, LIFO batch:1
  HighMem zone: 0 pages, LIFO batch:1
Built 1 zonelists
Kernel command line: console=ttyS0,115200
nfsroot=192.168.0.1:/opt/hardhat/devkit/ppc/405/target
ip=192.168.0.2:192.168.0.1::255.255.255.0
PID hash table entries: 2048 (order 11: 16384 bytes)
Console: colour dummy device 80x25
Memory: 256000k available (1724k kernel code, 624k data, 260k init, 0k
highmem)
Calibrating delay loop... 796.67 BogoMIPS
        ...
mal0: Initialized, 4 tx channels, 4 rx channels
emac: IBM EMAC Ethernet driver, version 2.0
Maintained by Benjamin Herrenschmidt <benh@kernel.crashing.org>
zmii0: input 0 in SMII mode
eth0: IBM emac, MAC 00:04:ac:e3:28:26
eth0: Found Generic MII PHY (0x01)
zmii0: input 1 in SMII mode
eth1: IBM emac, MAC 00:04:ac:e3:28:27
eth1: Found Generic MII PHY (0x02)
zmii0: input 2 in SMII mode
rgmii0: input 0 in RGMII mode
eth2: IBM emac, MAC 00:04:ac:e3:28:28
eth2: Found CIS8201 Gigabit Ethernet PHY (0x10)
zmii0: input 3 in SMII mode
rgmii0: input 1 in RGMII mode
eth3: IBM emac, MAC 00:04:ac:e3:28:29
eth3: Found CIS8201 Gigabit Ethernet PHY (0x18)
mice: PS/2 mouse device common for all mice
i8042.c: i8042 controller self test timeout.
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET: Registered protocol family 1
NET: Registered protocol family 17
Slab corruption: start=c0798890, len=2048
Redzone: 0x5a2cf071/0x170fc2a5.
Last user: [<c013d23c>](alloc_skb+0x44/0xd8)
7f0: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a a5
Prev obj: start=c0798084, len=2048
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<00000000>](0x0)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=c079909c, len=2048
Redzone: 0x756e6978/0x170fc2a5.
Last user: [<c013d23c>](alloc_skb+0x44/0xd8)
000: 00 04 ac e3 28 26 00 90 27 a3 a7 5a 08 00 45 10
010: 01 48 00 00 00 00 10 11 28 42 c0 a8 00 01 c0 a8
slab error in cache_alloc_debugcheck_after(): cache `size-2048': double
free, or memory outside objmac, MAC 00:04:ac:e3:28:26
eth0: Found Generic MII PHY (0x01)
zmii0: input 1 in SMII mode
eth1: IBM emac, MAC 00:04:ac:e3:28:27
eth1: Found Generic MII PHY (0x02)
zmii0: input 2 in SMII mode
rgmii0: input 0 in RGMII mode
eth2: IBM emac, MAC 00:04:ac:e3:28:28
eth2: Found CIS8201 Gigabit Ethernet PHY (0x10)
zmii0: input 3 in SMII mode
rgmii0: input 1 in RGMII mode
eth3: IBM emac, MAC 00:04:ac:e3:28:29
eth3: Found CIS8201 Gigabit Ethernet PHY (0x18)
mice: PS/2 mouse device common for all mice
i8042.c: i8042 controller self test timeout.
NET: Registered protocol family 2
IP: routing cache hash table of 2048 buckets, 16Kbytes
TCP: Hash tables configured (established 16384 bind 16384)
NET: Registered protocol family 1
NET: Registered protocol family 17
Slab corruption: start=c0798890, len=2048
Redzone: 0x5a2cf071/0x170fc2a5.
Last user: [<c013d23c>](alloc_skb+0x44/0xd8)
7f0: 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a 5a a5
Prev obj: start=c0798084, len=2048
Redzone: 0x5a2cf071/0x5a2cf071.
Last user: [<00000000>](0x0)
000: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
010: 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b 6b
Next obj: start=c079909c, len=2048
Redzone: 0x756e6978/0x170fc2a5.
Last user: [<c013d23c>](alloc_skb+0x44/0xd8)
000: 00 04 ac e3 28 26 00 90 27 a3 a7 5a 08 00 45 10
010: 01 48 00 00 00 00 10 11 28 42 c0 a8 00 01 c0 a8
slab error in cache_alloc_debugcheck_after(): cache `size-2048': double
free, or memory outside object was overwritten
Call trace:
 [c0008e80] dump_stack+0x18/0x28
 [c0045234] __slab_error+0x2c/0x3c
 [c004761c] __kmalloc+0x1b4/0x268
 [c013d23c] alloc_skb+0x44/0xd8
 [c0130fc4] emac_rx_fill+0x4c/0x120
 [c01322f4] emac_init_rings+0x10c/0x148
 [c0132534] emac_reset_configure+0x204/0x218
 [c0132eb4] emac_open+0x44/0x164
 [c01420bc] dev_open+0xa0/0x138
 [c0143d0c] dev_change_flags+0x6c/0x144
 [c024a1e4] ic_open_devs+0x134/0x2c8
 [c024ba0c] ip_auto_config+0x78/0x2dc
 [c02366cc] do_initcalls+0x90/0x10c
 [c0236768] do_basic_setup+0x20/0x30
 [c00011cc] init+0x40/0x11c

....  repeats above messages

--

Matt Porter wrote:

>I've pushed a bunch of code for this to the linux-2.5-ocp tree. It
>overhauls the EMAC driver a bit and adds a number of fields to the
>new OCP EMAC .additions field that are set per SoC or by the board
>specific code.  There's support for GigE on EMAC2/3, the TAH,
>zerocopy, and jumbo frames.
>
>There's still work to be done on jumbo frames > 4062 MTU since
>the RX side requires a copy. If we get some assumptions about
>linear skbs in various protocol implementations removed, this can
>be fixed. TSO support is the only major thing unimplemented.
>
>Performance is right on par with an e1000 in the same platform,
>showing anywhere from 700-850Mbps TX throughput depending on
>MTU size and sendfile usage. RX range is slightly less.
>
>Pull from bk://source.mvista.com/linux-2.5-ocp
>
>Once the new OCP stuff goes into linux-2.5, I'll send some
>version of this (plus previous EMAC driver work for 2.6) to
>jgarzik.
>
>-Matt
>
>
>
>
>
>

--
Takeharu KATO
Fujitsu Limited
Email:tkato@cs.fujitsu.co.jp (ext. 7112-4621)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
