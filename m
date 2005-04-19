Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15805.mail.cnb.yahoo.com (web15805.mail.cnb.yahoo.com
	[202.165.102.85]) by ozlabs.org (Postfix) with SMTP id D1F4767A6B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 19 Apr 2005 23:53:03 +1000 (EST)
Message-ID: <20050419135257.50676.qmail@web15805.mail.cnb.yahoo.com>
Date: Tue, 19 Apr 2005 21:52:57 +0800 (CST)
From: Sam Song <samlinuxppc@yahoo.com.cn>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 824x Sandpoint with 2.6.x
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

"Mark A. Greer" <mgreer@mvista.com> wrote:
> Sorry for the delay, I was on vacation last week.

Not at all. I experienced a lot during your vacation:)

> It could be lots of things. Can you dump __log_buf?
> If so, please dump
> and send it so we can have a look. If not, try
> adding more progress
> stmts and telling us exactly where its stopping.

OK, I am now up to the joint of early_console and
normal console. Switch problem. Perhaps I miss sth
or what?

## Booting image at 01200000 ...
   Image Name:   Linux-2.6.11
   Image Type:   PowerPC Linux Kernel Image (gzip
compressed)
   Data Size:    442401 Bytes = 432 kB
   Load Address: 00000000
   Entry Point:  00000000
   Uncompressing Kernel Image ... OK
## Loading RAMDisk Image at ff950000 ...
   Image Name:   Ramdisk Image
   Image Type:   PowerPC Linux RAMDisk Image (gzip
compressed)
   Data Size:    4479838 Bytes =  4.3 MB
   Load Address: 00000000
   Entry Point:  00000000
   Loading Ramdisk to 03b02000, end 03f47b5e ... OK
   Loading kernel ......
Linux version 2.6.11 (root@localhost.localdomain) (gcc
version 3.2.2 20030217 (Y
[snip]
Kernel command line:
console=uart,mmio,0xfdfce500,115200n8
console=ttyS0,115200
root=/dev/ram rw ramdisk_size=200000
ip=192.168.0.3:192.168..2:::sandpoint:et
h0:off panic=1
OpenPIC Version 1.2 (1 CPUs and 6 IRQ sources) at
fdfcf000
OpenPIC timer frequency is 100.000000 MHz
PID hash table entries: 512 (order: 9, 8192 bytes)
time_init: decrementer frequency = 25.000000 MHz
first init port.membase = 0x-34585344
Early serial console at MMIO 0xfdfce500 (options
'115200n8')
Dentry cache hash table entries: 16384 (order: 4,
65536 bytes)
Inode-cache hash table entries: 8192 (order: 3, 32768
bytes)
Memory: 63872k available (684k kernel code, 228k data,
92k init, 0k highmem)
Mount-cache hash table entries: 512 (order: 0, 4096
bytes)
Linux NoNET1.0 for Linux 2.6
PCI: Probing PCI hardware
PCI: Cannot allocate resource region 1 of device
0000:00:00.0
Serial: 8250/16550 driver $Revision: 1.90 $ 1 ports,
IRQ sharing enabled
io scheduler noop registered
RAMDISK driver initialized: 16 RAM disks of 200000K
size 1024 blocksize
No ttyS device at MMIO 0xfdfce500 for console

No matter how I changed the uart parameter, still no
luck to get any further info. I looked into 
old_serial_port value and found that all invaild. So
how to deal with it next?

Thanks,

Sam


_________________________________________________________
Do You Yahoo!?
150万曲MP3疯狂搜，带您闯入音乐殿堂
http://music.yisou.com/
美女明星应有尽有，搜遍美图、艳图和酷图
http://image.yisou.com
1G就是1000兆，雅虎电邮自助扩容！
http://cn.rd.yahoo.com/mail_cn/tag/1g/*http://cn.mail.yahoo.com/event/mail_1g/
