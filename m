Return-Path: <prashant.alange@gmail.com>
Message-ID: <6d145b42050809172365209b9e@mail.gmail.com>
Date: Tue, 9 Aug 2005 17:23:24 -0700
From: Prashant Alange <prashant.alange@gmail.com>
To: Linuxppc-embedded@ozlabs.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: passing ram= argument to kernel
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,
I am trying to pass ram=3D argument to kernel and my bootcmd is as shown be=
low

tftpboot 03000000 prashant/root.img; tftpboot 00100000 prashant/uImage; set=
env b
ootargs root=3D/dev/ram ram=3D60M
ip=3D10.67.65.68:10.67.65.39:255.255.255.0:MPC8270:eth1:off; bootm
00100000 03000000

I have 64 MB RAM on my system. With above command if I boot the board and s=
ee
cat /proc/meminfo I still see 64MB RAM.
Can anyone tell me, how to pass ram argument.=20

Thanks,
Prashant
