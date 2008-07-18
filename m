Return-Path: <mahendravarman15@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.188])
	by ozlabs.org (Postfix) with ESMTP id 40EA2DE43A
	for <linuxppc-embedded@ozlabs.org.>;
	Sat, 19 Jul 2008 00:00:15 +1000 (EST)
Received: by nf-out-0910.google.com with SMTP id b2so117398nfb.43
	for <linuxppc-embedded@ozlabs.org.>;
	Fri, 18 Jul 2008 07:00:13 -0700 (PDT)
Message-ID: <4ac2955e0807180700u6184562duc128049245e37fdc@mail.gmail.com>
Date: Fri, 18 Jul 2008 19:30:13 +0530
From: "mahendra varman" <mahendravarman15@gmail.com>
To: linuxppc-embedded@ozlabs.org.
Subject: No filesystem could mount root
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_40079_27218329.1216389613521"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_40079_27218329.1216389613521
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi all

We are porting linux 2.6.24 on a board with powerpc processor and with AMD
79C972 ethernet chip

Thru ramdisk I can able to boot the board and i can do the ifconfig eth0
up..

When I try to boot the board with nfs iam getting the following

NET: Registered protocol family 1
NET: Registered protocol family 17
RPC: Registered udp transport module.
RPC: Registered tcp transport module
List of all partitions:
No filesystem could mount root, tried:  ext3 ext2 msdos ntfs
Kernel panic - not syncing: VFS: Unable to mount root fs on
unknown-block(1,0)
Rebooting in 180 seconds..

1. In the kernel the nfs related configs are enabled properly
2. The nfs server and file system is proper( I have mounted and checked the
nfs server & file system thru another working setup)
3. The ethernet driver  pcnet32.c  under drivers/net  is okkk it seems becaz
it is working when i boot the board thru ramdisk

Please shed me some light where to look and what may be the reason iam
getting the above error when i boot thru NFS

Thanks in advance

------=_Part_40079_27218329.1216389613521
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div dir="ltr">Hi all<br><br>We are porting linux 2.6.24 on a board with powerpc processor and with AMD 79C972 ethernet chip<br><br>Thru ramdisk I can able to boot the board and i can do the ifconfig eth0 up..<br><br>When I try to boot the board with nfs iam getting the following <br>
<br><font size="1">NET: Registered protocol family 1<br>NET: Registered protocol family 17<br>RPC: Registered udp transport module.<br>RPC: Registered tcp transport module</font><br>List of all partitions:<br>No filesystem could mount root, tried:&nbsp; ext3 ext2 msdos ntfs<br>
Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(1,0)<br>Rebooting in 180 seconds..<br><br>1. In the kernel the nfs related configs are enabled properly<br>2. The nfs server and file system is proper( I have mounted and checked the nfs server &amp; file system thru another working setup)<br>
3. The ethernet driver&nbsp; pcnet32.c&nbsp; under drivers/net&nbsp; is okkk it seems becaz it is working when i boot the board thru ramdisk<br><br>Please shed me some light where to look and what may be the reason iam getting the above error when i boot thru NFS<br>
<br>Thanks in advance<br></div>

------=_Part_40079_27218329.1216389613521--
