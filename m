Message-ID: <007301c11401$0cc53c60$1701a8c0@paulplanet>
From: "Paul Chu (Accusys)" <paulchu@accusys.com.tw>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: kernel 2.4.6 fail to mount 2.2.x root fs
Date: Tue, 24 Jul 2001 13:25:25 +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

    I'm porting official linux kernel 2.4.6 to our MPC8240 borad.
The kernel boot up, detect SCSI disks, and mount root filesystem
on the disk without any error messages. But after opening cosole
(COM1) and executing "/sbin/init", kernel hangs without any
messages. However, the console will echo any keys I press on my
virtual terminal. My root filesystem on the disk is installed from
LinuxPPC 2000 and can be used well when I use my previous port
kernel 2.2.17. Do I need to recompile the init programs for 2.4.x ?
Or where can I get a root filesystem image for 2.4.x ?
    Thank you !!

Best Regards,
Paul Chu
Email: paulchu@accusys.com.tw


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
