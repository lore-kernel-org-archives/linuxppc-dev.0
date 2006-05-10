Return-Path: <roto@gmx.net>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 9DB41679EF
	for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2006 23:49:27 +1000 (EST)
Received: from localhost.localdomain (shorty@debby1-6 [127.0.0.1])
	by ; ; connection timed out;
	no servers could be reached (8.13.6/8.13.6/Debian-1) with ESMTP id
	k4ADpeNl004048
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2006 15:51:40 +0200
Received: (from shorty@localhost)
	by localhost.localdomain (8.13.6/8.13.6/Submit) id k4ADpd23004047
	for linuxppc-dev@ozlabs.org; Wed, 10 May 2006 15:51:39 +0200
Date: Wed, 10 May 2006 15:51:39 +0200
From: Wolfgang Pfeiffer <roto@gmx.net>
To: linuxppc-dev@ozlabs.org
Subject: Kernel bug reports welcome here?
Message-ID: <20060510135139.GB3878@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi All

I'm running a git kernel with sources from about last Sunday, on a
alubook5.8, and I would like to know whether bug reports, if things
don't work with this kernel (there are a few ... :), will be welcome
here.

If not: Where's the better place for reports like that: Linux kernel
mailing list?

Just in case if this might help:

$ cat /proc/cpuinfo 
processor       : 0
cpu             : 7447A, altivec supported
clock           : 833.333000MHz
revision        : 0.5 (pvr 8003 0105)
bogomips        : 16.57
timebase        : 8320000
platform        : PowerMac
machine         : PowerBook5,8
motherboard     : PowerBook5,8 MacRISC3 Power Macintosh 
detected as     : 287 (PowerBook G4 15")
pmac flags      : 00000019
L2 cache        : 512K unified
pmac-generation : NewWorld 

$ cat /proc/version 
Linux version 2.6.17-rc3-g5528e568-dirty (root@debby1-6) (gcc version
4.1.1 20060428 (prerelease) (Debian 4.1.0-2)) #1 Sun May 7 23:51:15
CEST 2006

Best Regards
Wolfgang

-- 
Wolfgang Pfeiffer: /ICQ: 286585973/ + + +  /AIM: crashinglinux/
http://profiles.yahoo.com/wolfgangpfeiffer

Key ID: E3037113
http://keyserver.mine.nu/pks/lookup?search=0xE3037113&fingerprint=on
