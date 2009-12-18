Return-Path: <wuzhy@cn.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 00C13B6F0C
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2009 15:06:30 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp06.au.ibm.com (8.14.3/8.13.1) with ESMTP id nBI46KlY010484
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2009 15:06:20 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nBI42UxX1585220
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2009 15:02:30 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nBI46TFf016442
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2009 15:06:29 +1100
Subject: Kernel panic - not syncing: Attempted to kill init! Rebooting in 180
	seconds..
To: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
Message-ID: <OF837C89D6.7009CDAB-ON48257690.0015C2D3-48257690.0016DA0C@cn.ibm.com>
From: Zhi Yong Wu <wuzhy@cn.ibm.com>
Date: Fri, 18 Dec 2009 12:05:46 +0800
MIME-Version: 1.0
Content-type: multipart/alternative;
	Boundary="0__=C7BBFC03DF8644438f9e8a93df938690918cC7BBFC03DF864443"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0__=C7BBFC03DF8644438f9e8a93df938690918cC7BBFC03DF864443
Content-type: text/plain; charset=US-ASCII


HI,

linux-2.6.32 is compiled on a p6 machine with RH5.4 OS and KVM option is
enable.

When rebooting this machine, a crash takes place such as:

Loading ramdisk...
ramdisk loaded at 01700000, size: 2700 Kbytes
OF stdout device is: /vdevice/vty@30000000
Preparing to boot Linux version 2.6.32 (root@p6ml4n07.clusters.com) (gcc
version 4.1.2 20080704 (Red Hat 4.1.2-46)) #1 SMP Fri Dec 18 06:53:27 EST
2009
Calling ibm,client-architecture-support.../
Elapsed time since release of system processors: 1212 mins 30 secs

Config file read, 1024 bytes

Welcome
Welcome to yaboot version 1.3.13 (Red Hat 1.3.13-8.el5)
Enter "help" to get some basic usage information
boot: linux-32
Please wait, loading kernel...
   Elf64 kernel loaded...
Loading ramdisk...
ramdisk loaded at 01700000, size: 2700 Kbytes
OF stdout device is: /vdevice/vty@30000000
Preparing to boot Linux version 2.6.32 (root@p6ml4n07.clusters.com) (gcc
version 4.1.2 20080704 (Red Hat 4.1.2-46)) #1 SMP Fri Dec 18 06:53:27 EST
2009
Calling ibm,client-architecture-support... done
command line: ro console=hvc0 rhgb quiet root=LABEL=/
memory layout at init:
  memory_limit : 0000000000000000 (16 MB aligned)
  alloc_bottom : 00000000019b0000
  alloc_top    : 0000000008000000
  alloc_top_hi : 0000000008000000
  rmo_top      : 0000000008000000
  ram_top      : 0000000008000000
instantiating rtas at 0x0000000006e10000... done
boot cpu hw idx 0000000000000000
copying OF device tree...
Building dt strings...
Building dt structure...
Device tree strings 0x0000000001bc0000 -> 0x0000000001bc15bb
Device tree struct  0x0000000001bd0000 -> 0x0000000001bf0000
Calling quiesce...
returning from prom_init
Red Hat nash version 5.1.19.6 starting
ibmvscsi 30000002: fast_fail not supported in server
sd 0:0:1:0: [sda] Assuming drive cache: write through
sd 0:0:1:0: [sda] Assuming drive cache: write through
sd 0:0:1:0: [sda] Assuming drive cache: write through
insmod: error inserting '/lib/dm-region-hash.ko': -1 File exists
mount: could not find filesystem '/dev/root'
setuproot: moving /dev failed: No such file or directory
setuproot: error mounting /proc: No such file or directory
setuproot: error mounting /sys: No such file or directory
switchroot: mount failed: No such file or directory
Kernel panic - not syncing: Attempted to kill init!
Rebooting in 180 seconds..[disconnect]

Can anyone give me a warm hand?


Cheers,

Zhiyong Wu
--0__=C7BBFC03DF8644438f9e8a93df938690918cC7BBFC03DF864443
Content-type: text/html; charset=US-ASCII
Content-Disposition: inline

<html><body>
<p>HI, <br>
<br>
linux-2.6.32 is compiled on a p6 machine with RH5.4 OS and KVM option is enable.<br>
<br>
When rebooting this machine, a crash takes place such as:<br>
<br>
Loading ramdisk...<br>
ramdisk loaded at 01700000, size: 2700 Kbytes<br>
OF stdout device is: /vdevice/vty@30000000<br>
Preparing to boot Linux version 2.6.32 (root@p6ml4n07.clusters.com) (gcc version 4.1.2 20080704 (Red Hat 4.1.2-46)) #1 SMP Fri Dec 18 06:53:27 EST 2009<br>
Calling ibm,client-architecture-support.../<br>
Elapsed time since release of system processors: 1212 mins 30 secs<br>
<br>
Config file read, 1024 bytes<br>
<br>
Welcome<br>
Welcome to yaboot version 1.3.13 (Red Hat 1.3.13-8.el5)<br>
Enter &quot;help&quot; to get some basic usage information<br>
boot: linux-32 <br>
Please wait, loading kernel...<br>
   Elf64 kernel loaded...<br>
Loading ramdisk...<br>
ramdisk loaded at 01700000, size: 2700 Kbytes<br>
OF stdout device is: /vdevice/vty@30000000<br>
Preparing to boot Linux version 2.6.32 (root@p6ml4n07.clusters.com) (gcc version 4.1.2 20080704 (Red Hat 4.1.2-46)) #1 SMP Fri Dec 18 06:53:27 EST 2009<br>
Calling ibm,client-architecture-support... done<br>
command line: ro console=hvc0 rhgb quiet root=LABEL=/ <br>
memory layout at init:<br>
  memory_limit : 0000000000000000 (16 MB aligned)<br>
  alloc_bottom : 00000000019b0000<br>
  alloc_top    : 0000000008000000<br>
  alloc_top_hi : 0000000008000000<br>
  rmo_top      : 0000000008000000<br>
  ram_top      : 0000000008000000<br>
instantiating rtas at 0x0000000006e10000... done<br>
boot cpu hw idx 0000000000000000<br>
copying OF device tree...<br>
Building dt strings...<br>
Building dt structure...<br>
Device tree strings 0x0000000001bc0000 -&gt; 0x0000000001bc15bb<br>
Device tree struct  0x0000000001bd0000 -&gt; 0x0000000001bf0000<br>
Calling quiesce...<br>
returning from prom_init<br>
Red Hat nash version 5.1.19.6 starting<br>
ibmvscsi 30000002: fast_fail not supported in server<br>
sd 0:0:1:0: [sda] Assuming drive cache: write through<br>
sd 0:0:1:0: [sda] Assuming drive cache: write through<br>
sd 0:0:1:0: [sda] Assuming drive cache: write through<br>
insmod: error inserting '/lib/dm-region-hash.ko': -1 File exists<br>
mount: could not find filesystem '/dev/root'<br>
setuproot: moving /dev failed: No such file or directory<br>
setuproot: error mounting /proc: No such file or directory<br>
setuproot: error mounting /sys: No such file or directory<br>
switchroot: mount failed: No such file or directory<br>
Kernel panic - not syncing: Attempted to kill init!<br>
Rebooting in 180 seconds..[disconnect]<br>
<br>
Can anyone give me a warm hand?<br>
<br>
<br>
Cheers,<br>
<br>
Zhiyong Wu<br>
</body></html>
--0__=C7BBFC03DF8644438f9e8a93df938690918cC7BBFC03DF864443--
