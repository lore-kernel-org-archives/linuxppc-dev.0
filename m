Return-Path: <glenn@aoi-industries.com>
Received: from aoi-industries.com (mail.aoi-industries.com [216.204.214.42])
	by ozlabs.org (Postfix) with ESMTP id 8531A2BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Oct 2004 07:44:04 +1000 (EST)
From: Glenn Burkhardt <glenn@aoi-industries.com>
To: medp@primagraphics.com
Date: Fri, 22 Oct 2004 17:20:25 -0400
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200410221720.25053.glenn@aoi-industries.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: gdb on a 440GP ELDK
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> I can't seem to use breakpoints in gdb (application debugging in 
> userland not kernel debugging).

This won't be any consolation, but it works for me with my hardware and 
configuration.  I'm using ELDK 3, with NFS root, on a P501 board from General 
Micro.  My software revs are:

[root@tweety root]# cat /proc/version
Linux version 2.4.23-pre9 (root@tweety) (gcc version 3.2.2 20030217 (Yellow 
Dog Linux 3.0 3.2.2-2a_2)) #79 Mon Oct 18 14:32:24 EDT 2004

gcc version 3.2.2 20030217 (Yellow Dog Linux 3.0 3.2.2-2a_2)
GNU gdb Yellow Dog Linux (5.2.1-4b_3)

root@tweety root]# cat /proc/cpuinfo
processor       : 0
cpu             : 440GP Rev. C
revision        : 4.129 (pvr 4012 0481)
bogomips        : 599.65
vendor          : GMS
machine         : P501

The software, except for the kernel I'm running, came off the iso image 
available on the Denx site.

Good luck!
