Message-ID: <0B0A39652BB0D411BCCF00508B9512EC08AEB469@tx14exm05.ftw.mot.com>
From: Yu Bo-BOYU1 <Bo.Yu@motorola.com>
To: "'acurtis@onz.com'" <acurtis@onz.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: RE: 8260 core/bus/cpm clock
Date: Thu, 10 Oct 2002 09:05:16 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


It is vxWorks bootrom. I could not (don't know) pass boot line
into linux. This is the default boot line.

# cat /proc/cmdline
root=/dev/nfs rw ip=auto

Bo


-----Original Message-----
From: Allen Curtis [mailto:acurtis@onz.com]
Sent: Thursday, October 10, 2002 9:02 AM
To: Yu Bo-BOYU1; linuxppc-embedded@lists.linuxppc.org
Subject: RE: 8260 core/bus/cpm clock


> After dumping cpu information,
>
> # cat /proc/cpuinfo
> cpu             : 82xx
> core clock      : 132 MHz
> CPM  clock      : 66 MHz
> bus  clock      : 33 MHz
> revision        : 1.1 (pvr 0081 0101)
> bogomips        : 54.88
>
> I found this is NOT correct for the custom board. It should be
> 66/133/166MHZ. However
> I did not find any configurable entry in "make xconfig".

What is your bootloader? Some loaders pass this information to the kernel at
boot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
