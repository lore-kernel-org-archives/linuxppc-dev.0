Subject: Error in loading shared libraries: invalid ELF header 
To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF31327F98.5BC0D876-ON85256B05.004B0D9F@pok.ibm.com>
From: "Alda Sanomiya" <sanomiya@us.ibm.com>
Date: Thu, 15 Nov 2001 08:42:29 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,
I'm using mvista PPC 405  embedded linux  and I'm getting the error
highlighted in the log bellow.
Does anybody know where the problem is?

TCP: Hash tables configured (established 16384 bind 16384)
ppc4xx_enet_tx=d1000000
 PPC405 MAL0  open completed
OPEN MAC 00:b3:02:e6:16:2d
MAL Chan Start mal_num = 1 chna_type =1 in_chan = 0
MAL Chan Start mal_num = 1 chna_type =2 in_chan = 0
RX CHAN stting to 20001030
DCRN_MAL0RXCASR 190
eth0: PPC4XX Emac open completed
OPEN MAC 00:00:00:00:00:00
MAL Chan Start mal_num = 1 chna_type =1 in_chan = 2
MAL Chan Start mal_num = 1 chna_type =2 in_chan = 1
RX CHAN stting to 20001030
DCRN_MAL0RXCASR 190
eth1: PPC4XX Emac open completed
IP-Config: Incomplete network configuration information.
NET4: Unix domain sockets 1.0/SMP for Linux NET4.0.
EXT2-fs warning: mounting unchecked fs, running e2fsck is recommended
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 176k init 4k openfirmware
init: error in loading shared libraries: libc.so.6: invalid ELF header
Kernel panic: Attempted to kill init!
Rebooting in 180 seconds..


thanks,
Alda Sanomiya
phone: (914) 945-3599  T/L 862-3599


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
