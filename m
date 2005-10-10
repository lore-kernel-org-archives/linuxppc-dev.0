Return-Path: <dmytro.bablinyuk@rftechnology.com.au>
Received: from mfep1.connect.com.au (fep1.mfe.bur.connect.com.au [203.63.86.1])
	by ozlabs.org (Postfix) with ESMTP id 5D2F068457
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Oct 2005 09:04:55 +1000 (EST)
Received: from [192.168.1.100] (cor12-ppp681.hay.dsl.connect.net.au
	[61.68.71.173])
	by mfep1.connect.com.au (Postfix) with ESMTP id 41336B172
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Oct 2005 09:04:53 +1000 (EST)
Message-ID: <434AF39D.8050709@rftechnology.com.au>
Date: Tue, 11 Oct 2005 09:05:01 +1000
From: Dmytro Bablinyuk <dmytro.bablinyuk@rftechnology.com.au>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: boot-time partitions and bootargs for 2.6.14
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have 2.6.14 kernel and the following partitions (defined in U-Boot 1.1.4)
mtdparts=0:1024k(Linux),4096k(root),2048k(Unused),512k(U-Boot),512()

And I tried different bootargs
bootargs=console=ttyCPM0,115200 root=/dev/mtdblock1 rw rootfstype=jffs2

And I tried
bootargs console=ttyCPM0,115200 root=31:01 rw rootfstype=jffs2

I still have
Kernel panic - not syncing: VFS: Unable to mount root fs on 
unknown-block(31,1)

I tried different minor numbers but result the same. Does anybody know 
what type of root param I should use for 2.6.14 - mtdblock1 or 31:01?
Can anybody suggest me what I missed? One of the reasons I see that I 
may have a corrupted root.

Thank you

Dimitry
