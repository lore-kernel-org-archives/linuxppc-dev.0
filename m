Message-ID: <3E7051A8.A77EAF4C@tataelxsi.co.in>
Date: Thu, 13 Mar 2003 15:08:48 +0530
From: "Kamalesh B" <kamal@tataelxsi.co.in>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: RAMDISK Problem
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hello,

I have a problem in booting linux 2.4.1 with RAMDISK on MPC8260ADS using
PPCBOOT.

After downloading kernel and ramdisk (simple-ramdisk.PPCBoot) image to
RAM using TFTP application and giving bootm command, it just hangs.

As u people suggested to dump "log_buf" contents, i got dump indicating
that it is hanging after reading the command line options in init.c.

--- Memory dump starts ---
=> md 0x127654 0x70
00127654: 3c343e72 343a2030 30656434 3030300a    <4>r4: 00ed4000.
00127664: 3c343e54 6f74616c 206d656d 6f727920    <4>Total memory
00127674: 3d203136 4d423b20 7573696e 67203634    = 16MB; using 64
00127684: 6b422066 6f722068 61736820 7461626c    kB for hash tabl
00127694: 65202861 74206330 31353030 3030290a    e (at c0150000).
001276a4: 3c343e4c 696e7578 20766572 73696f6e    <4>Linux version
001276b4: 20322e34 2e312028 726f6f74 40736869     2.4.1 (root@shi
001276c4: 76612920 28676363 20766572 73696f6e    va) (gcc version
001276d4: 20322e39 352e3320 32303031 30333135     2.95.3 20010315
001276e4: 20287265 6c656173 65292920 23312057     (release)) #1 W
001276f4: 6564204d 61722031 32203135 3a32323a    ed Mar 12 15:22:
00127704: 31352055 54432032 3030330a 3c343e4f    15 UTC 2003.<4>O
00127714: 6e206e6f 64652030 20746f74 616c7061    n node 0 totalpa
00127724: 6765733a 20343039 360a3c34 3e7a6f6e    ges: 4096.<4>zon
00127734: 65283029 3a203430 39362070 61676573    e(0): 4096 pages
00127744: 2e0a3c34 3e7a6f6e 65283129 3a203020    ..<4>zone(1): 0
00127754: 70616765 732e0a3c 343e7a6f 00000000    pages..<4>zo....
00127764: 00000000 00000000 00000000 00000000    ................
00127774: 00000000 00000000 00000000 00000000    ................
00127784: 00000000 00000000 00000000 00000000    ................
00127794: 00000000 00000000 00000000 00000000    ................
001277a4: 00000000 00000000 00000000 00000000    ................
001277b4: 00000000 00000000 00000000 352e302e    ............5.0.
001277c4: 303a7368 6976613a 6f66660a 00000000    0:shiva:off.....
001277d4: 00000000 00000000 00000000 00000000    ................
--- Memory dump ends ---

Iam stuck at this point.

bootargs command passed:
root=/dev/ram ip=10.1.40.175:10.1.40.176:10.1.1.1:255.255.0.0:shiva::off

Is there any problem with this command?

I have selected Ramdisk support during linux configuration settings. Is
there any other option i have missed?

thanks in advance,
with rgds,
kamal


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
