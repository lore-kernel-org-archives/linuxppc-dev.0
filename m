From: Michael Thompson <mickey@berkeley.innomedia.com>
Message-Id: <200010040653.XAA18312@berkeley.innomedia.com>
Subject: PCI resource allocation
To: linuxppc-dev@lists.linuxppc.org
Date: Tue, 3 Oct 2000 23:53:12 -0700 (PDT)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

I'm porting linux to a custom 8240 based board. This board has
two PCI buses; bus 0 is a 66MHz bus, and bus 1 is a 33MHz bus, so there
is a PCI-PCI bridge (1011/0023) on bus 0.

On bus 1, there is one ethernet device (1022:2000) and a PCI-ISA
bridge (100b/0021).

There is a problem allocating resources for the ethernet device, and
I'm afraid I'm clueless at the moment. Can anybody give me an idea
what might be going on?

Thanks!

-Michael Thompson
mickey@berkeley.innomedia.com

----

Total memory = 3136MB; using 0kB for hash table (at 00000000)
Linux version 2.4.0-test9 (mickey@richter) (gcc version 2.95.2 19991024 (release/franzo)) #17 Tue Oct 3 23:38:55 PDT 2000
Boot arguments: root=nfs console=ttyS0,9600
On node 0 totalpages: 802816
zone(0): 802816 pages.
zone(1): 0 pages.
zone(2): 0 pages.
Kernel command line: root=nfs console=ttyS0,9600
OpenPIC Version 1.2 (1 CPUs and 24 IRQ sources) at fc040000
OpenPIC timer frequency is not set
time_init: decrementer frequency = 66.000000 MHz
Calibrating delay loop... 439.09 BogoMIPS
Memory: 8864k available (0k kernel code, 0k data, 0k init, 0k highmem)
Dentry-cache hash table entries: 262144 (order: 9, 2097152 bytes)
Buffer-cache hash table entries: 262144 (order: 8, 1048576 bytes)
Page-cache hash table entries: 524288 (order: 9, 2097152 bytes)
Inode-cache hash table entries: 262144 (order: 9, 2097152 bytes)
POSIX conformance testing by UNIFIX
PCI: Probing PCI hardware
Scanning bus 00
Found 00:00 [1057/0003] 000600 00
Found 00:80 [11ab/4809] 000200 00
Found 00:88 [1011/0023] 000604 01
Fixups for bus 00
Scanning behind PCI bridge 00:11.0, config 010100, pass 0
Scanning bus 01
Found 01:00 [1022/2000] 000200 00
Found 01:10 [100b/0021] 000601 00
Fixups for bus 01
Bus scan for 01 returning with max=01
Scanning behind PCI bridge 00:11.0, config 010100, pass 1
Bus scan for 00 returning with max=01
PCI: Resource 80100000-80100fff (f=200, d=0, p=0)
PCI: Cannot allocate resource region 1 of device 00:00.0
PCI: Resource 80200000-803fffff (f=200, d=1, p=1)
PCI: Cannot allocate resource region 0 of device 00:10.0
PCI: Resource 00801000-00801003 (f=101, d=1, p=1)
PCI: Resource 00800000-0080001f (f=101, d=1, p=1)
PCI: Cannot allocate resource region 0 of device 01:00.0
PCI: Resource a0100000-a010001f (f=200, d=1, p=1)
  got res[10000000:101fffff] for resource 0
PCI: Failed to allocate resource 0 for PCI device 1022:2000
Linux NET4.0 for Linux 2.4
Based upon Swansea University Computer Society NET3.039


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
