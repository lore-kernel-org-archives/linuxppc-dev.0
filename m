Message-ID: <20030512222504.6830.qmail@kunk.qbjnet.com>
Subject: 3Ware controller on PREP error
To: linuxppc-dev@lists.linuxppc.org
Date: Mon, 12 May 2003 17:25:04 -0500 (CDT)
From: Robert E Brose II <bob@kunk.jriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm running debian 3.0 on this machine with a 2.4.20-benh10 kernel.
It's a 43p 133. The controller is a 3ware 7000 that I've used with
intel linux before. I'm trying to get a hardware raid controller
working. I tried a Adaptec 3200s, the machine freezes during PCI
bus scans with that in. The 3ware ide raid controller gets past that
part but still doesn't work. For reference a 2940uw works fine.

dmesg says this:

PCI: Probing PCI hardware
Scanning bus 00
Found 00:00 [1057/0001] 000600 00
Found 00:58 [1014/000a] 000601 00
Found 00:60 [1022/2000] 000200 00
Found 00:70 [5333/88c1] 000001 00
Fixup res 6 (7200) of dev 00:0e.0: c0000 -> c00c0000
Found 00:80 [1000/0001] 000100 00
Fixup res 1 (200) of dev 00:10.0: 80000 -> c0080000
Found 00:90 [13c1/1001] 000104 00
Found 00:b0 [9004/8178] 000100 00
Fixups for bus 00
Bus scan for 00 returning with max=00
IBM ID: 000000f7
Setting PCI interrupts for a "IBM PS830/PS850/7248 (Carolina)"
Relocating PCI address 20000000 -> 1000000
resource conflict with: 3c0..3df (0), name: vga+
PCI:00:0b.0: Resource 0: 00001000-00001007 (f=101), vd: 1014, dev: 000a
PCI:00:0c.0: Resource 0: 01000200-0100021f (f=101), vd: 1022, dev: 2000
PCI:00:10.0: Resource 0: 01000000-010000ff (f=101), vd: 1000, dev: 0001
PCI:00:10.0: Resource 1: c0080000-c00800ff (f=200), vd: 1000, dev: 0001
3ware Storage Controller device driver for Linux v1.02.00.031.
PCI: Enabling device 00:12.0 (0000 -> 0003)
3w-xxxx: tw_aen_drain_queue(): Unexpected request id.
3w-xxxx: AEN drain failed for card 0.
3w-xxxx: tw_aen_drain_queue(): Unexpected request id.
3w-xxxx: AEN drain failed for card 0.
3w-xxxx: tw_aen_drain_queue(): Unexpected request id.
3w-xxxx: AEN drain failed for card 0.
3w-xxxx: Controller errors, card not responding, check all cabling for card 0.
3w-xxxx: No cards with valid units found.

lspci -v says this:

00:12.0 RAID bus controller: 3ware Inc 3ware 7000-series ATA-RAID (rev 01)
        Subsystem: 3ware Inc 3ware 7000-series ATA-RAID
        Flags: medium devsel, IRQ 15
        I/O ports at 1010 [size=16]
        Memory at c0000020 (32-bit, non-prefetchable) [size=16]
        Memory at c1000000 (32-bit, non-prefetchable) [size=8M]
        Expansion ROM at <unassigned> [disabled] [size=64K]
        Capabilities: [40] Power Management version 1


Thanks for any pointers...

Bob
--
/~\ The ASCII       | Robert E. Brose II    N0QBJ
\ / Ribbon Campaign | http://www.qbjnet.com/
 X  Help cure       | mailto:bob@qbjnet.com
/ \ HTML Email      | public key at http://www.qbjnet.com/key.html

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
