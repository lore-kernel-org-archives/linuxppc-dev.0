Message-ID: <20000630035407.29012.qmail@web2105.mail.yahoo.com>
Date: Thu, 29 Jun 2000 20:54:07 -0700 (PDT)
From: Wentao Xu <xuwentao@yahoo.com>
Subject: a further question
To: benb@m2tech.co.nz
Cc: linuxppc-embedded@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


ben,

Thanks for your help.

I replace the 4xx_tlb.c with your file, and enable
some
printk msg. And changed the 2 exception functions's
name to fit with head_4xx.S. Here is the output, can
you do me a favor to give me an idea about what may
cause the error? I am a beginner of linux kernel and
now is completely lost. Thanks,

BTW, I added a printk in  PPC4xx_tlb_miss() like this:
..
bad:
 printk("PPC4xx_tlb_miss: bad\n");


output:
-----------------------------------------------------
Entry point at 0x250000 ...
----------  progress:  0x200 id mach(): done
before lock_kernel()
Linux version 2.3.39 (xwt@stb_dev) (gcc version 2.95.2
19991024 (release)) #314
Fri Jun 30 10:18:27 CST 2000
walnut_setup_arch()
----------  progress:  0x3eab arch: exit
On node 0 totalpages: 00001800
zone(0): 6144 pages.
zone(1): 0 pages.
zone(2): 0 pages.
ERROR: ppc4xx_pic_init() detected wrong PVR_VER

-----  in walnut_calibrate_decr()

  bip:

    bi_s_version      1.3
    bi_r_version      1.13
    bi_memsize        0x1800000
    bi_enetaddr       123456-7890ab
    bi_pci_enetaddr   000002-f34f60
    bi_procfreq       0x2f34f60
    bi_plb_busfreq    0x4e800021
    bi_pci_busfreq    0x0

Calibrating delay loop... 49.25 BogoMIPS
Memory: 22620k available (480k kernel code, 468k data,
28k init) [c0000000,c1800
000]
Buffer-cache hash table entries: 1024 (order: 0, 4096
bytes)
Page-cache hash table entries: 8192 (order: 3, 32768
bytes)
POSIX conformance testing by UNIFIX
start_kernel() -- calling smp_init()
start_kernel() -- calling kernel_thread()
start_kernel() -- calling cpu_idle()
----------  progress:  0xffff
Linux NET4.0 for Linux 2.3
Based upon Swansea University Computer Society
NET3.039
Starting kswapd v1.6
tty_init() -- calling rs_init()
Serial driver version 4.91 (1999-11-17) with no serial
options enabled
ttyS00 at 0x0000 (irq = 20) is a 16550A
tty_init() -- returned from rs_init()
RAMDISK driver initialized: 16 RAM disks of 4096K size
1024 blocksize
loop: registered device at major 7
loop: enabling 8 loop devices
RAMDISK: Compressed image found at block 0
Freeing initrd memory: 4194302k freed
VFS: Mounted root (ext2 filesystem).
Freeing unused kernel memory: 28k init
init/main.c init() before unlock_kernel
init/main.c init() before open(/dev/console)
init/main.c init() before dup(0)
 began execve(/sbin/sash)
process.c: before do_execve
do_execve(), filename = /sbin/sash  regs = 0xc016de70
do_execve() -----  calling open_namei()
do_execve() -----  returned from open_namei()  retval
= -1049119904  0xc177b360
exec.c:291: bad pte d9e35cd1.
PPC4xx_tlb_miss: bad
do_wp_page: bogus page at address 7fffffb0 (nr 892469)
PPC4xx_tlb_miss: bad
attempted data access at 7fffffb0 from c0042c8c
PPC4xx_tlb_miss: bad
do_wp_page: bogus page at address 7fffffb0 (nr 892469)
PPC4xx_tlb_miss: bad
attempted data access at 7fffffb0 from c0042c8c
PPC4xx_tlb_miss: bad
do_wp_page: bogus page at address 7fffffb0 (nr 892469)
PPC4xx_tlb_miss: bad
attempted data access at 7fffffb0 from c0042c8c
PPC4xx_tlb_miss: bad
do_wp_page: bogus page at address 7fffffb0 (nr 892469)
PPC4xx_tlb_miss: bad
attempted data access at 7fffffb0 from c0042c8c
PPC4xx_tlb_miss: bad
do_wp_page: bogus page at address 7fffffb0 (nr 892469)
PPC4xx_tlb_miss: bad
attempted data access at 7fffffb0 from c0042c8c


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
