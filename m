From: =?gb2312?B?tqG68dPA?= <nari_dhy@nari-china.com>
To: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Message-ID: <00b501c33aee$7c7bee30$4a44900a@hydingnb>
Subject: partitions info of CF flash
Date: Wed, 25 Jun 2003 15:50:41 +0800
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


hi
    My evaluation board is Xilinx ML300. RTOS is MVL pro3.0.
    I have two problems.
    One is how I pass the partition info to kernel. There are three parts in CF flash. The first saves .cfgs with FAT FS(which fs should i select? msdos/vfat). The second saves zImage. The last one is used as root device with ext2 fs(a better one?). I have looked the code in drivers/block/xilinx_sysace/adapter.c. I find it seems only to initialize the CF device without the partitions.
    The other is that where can i get the driver for uart lite(xilinx_uartlite.c).

Thanks

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
