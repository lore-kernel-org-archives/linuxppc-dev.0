Message-ID: <002601bf81dc$184f9480$0a01010a@gamma>
From: "Damjan Lampret" <damjan.lampret@arnes.si>
To: <linuxppc-embedded@lists.linuxppc.org>
Cc: "Jurkas Vasja RDSS" <jurkas@iskratel.si>
Subject: Data TLB error exception
Date: Mon, 28 Feb 2000 12:08:08 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

I am playing with 2.2.13 kernel on custom MPC860 board and I have a problem
with DTLB error (1400h) exception. I downloaded my kernel via BDM and it
boots ok until it starts /sbin/init (or any other user application). Most of
the time I get DTLB error usually in do_load_elf_binary() followed by data
access exception (data access exception normaly follows DTLB error exception
as far as I can tell from kernel sources) and a fatal machine check
exception in data access exception.

Another strange thing was happening with caches enabled when kernel hanged
almost instantly after booting to the point where it starts init. When I
disabled insn/data caches it is much more stable but it still hangs after a
couple of minutes. Althougth in this case I don't get DTLB error exception
AFAIK (I checked this only once). Perhaps this has something to do with BDM
(MPC860 that I have is revision 1 and it does not have a commonly known data
cache bug AFAIK)?

Any idea what is happening with my system? I would be happy to provide more
information if someone would care to help me.

regards, Damjan

PS Also I have MBX860 that I could use for a reference. But I get "Network
Boot Logic Error \ Packet Status: 0500" when trying to download kernel via
TFTP. Also nping in EPPC-Bug is not working. In fact I can't make any
network activity. Any idea? (I didn't yet tried to download kernel via
serial)


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
