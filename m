Return-Path: <hangtoo@163.com>
Received: from m5-86.163.com (m5-86.163.com [202.108.5.86])
	by ozlabs.org (Postfix) with SMTP id 3D35C679E9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 May 2006 20:00:38 +1000 (EST)
Date: Fri, 12 May 2006 17:43:59 +0800
From: "tony" <hangtoo@163.com>
To: "linuxppc-embedded@ozlabs.org" <linuxppc-embedded@ozlabs.org>
Subject: how to mount /dev/ram0 to / 
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Message-Id: <44645CBD.00AAC3.19405>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


I made a new uRamdisk for the mini bubinga board,
change uboot's bootargs like this
bootargs root=/dev/ram rw console=ttyS0,115200 ip=192.168.0.200:192.168.0.19:::bubinga:eth0:off panic=1
==>
bootargs root=/dev/ram0 rw console=ttyS0,115200 ip=192.168.0.200:192.168.0.19:::bubinga:eth0:off panic=1

after boot up,excute df to see the mount point:
~ # df
Filesystem           1k-blocks      Used Available Use% Mounted on
~ # 
nothing was mounted.
the fatab in /etc is like this:
/dev/ram0               /               ext2    defaults        1 1
none                    /proc           proc    defaults        0 0

anything wrong?
thank you.

tony
