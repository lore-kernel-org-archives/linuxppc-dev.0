Message-Id: <200402021038.EAA17372@lists.linuxppc.org>
Date: Mon, 2 Feb 2004 18:38:06 +0800
From: Yuxiao Xi <xiyuxiao@harbournetworks.com>
Reply-To: xiyuxiao@harbournetworks.com
To: linuxppc <linuxppc-embedded@lists.linuxppc.org>
Subject: question about big initrd
Mime-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,all
    I have trouble with big ramdisk when I port mvl-2.1(liux kernel
2.4.17) to my board with cpu mpc8240, which has 128Mbyte SDRAM.
    I configure the linux kernel to support initrd and set initrd size
as 20480(kbytes). When the actual size of my total ramdisk files is
about 11Mbytes,the system boots up smoothly; but when the actual size
of the total files is greater than 15Mbytes,the system fails to boot
up and tells me "ramdisk invalid compressed format" or "crc error" or
"incomplete write", and so on.
    Any suggestion?
    Thanks in advance.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
