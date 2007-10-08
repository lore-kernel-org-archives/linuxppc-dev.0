Return-Path: <powerpc@muellers.ms>
Date: Mon, 8 Oct 2007 09:08:12 +0200
From: Lixus Zoran <powerpc@muellers.ms>
To: Linuxppc-dev@ozlabs.org
Subject: howto hibernate (suspend-to-disk) G4 PowerBook Titanium IV
Message-ID: <20071008090812.5ee2df87@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

I own a Titanium PowerBook with a G4 processor.
It runs Ubuntu dapper 6.06 LTS.
Suspend to RAM works fine with pbbuttonsd.

But I would like to have hibernate (suspend-to-disk) working.
But if I replace "suspend-to-ram" by "suspend-to-disk" in 
/etc/pbbuttonsd.conf and close the lid then it just blanks the screen,
even if X is not running.

I found a lot of approaches howto possible hibernate,

a) swsuspend http://suspend.sf.net 
b) Suspend2  (this only works on i368 ?)
c) pbbuttonsd ?
d) uswsusp 
e) pmdisk

but where should I put my effords in ?


TIA, Lixus


# cat /proc/cpuinfo 
processor       : 0
cpu             : 7455, altivec supported
clock           : 667.000000MHz
revision        : 0.2 (pvr 8001 0302)
bogomips        : 66.56
timebase        : 33331380
machine         : PowerBook3,5
motherboard     : PowerBook3,5 MacRISC2 MacRISC Power Macintosh
detected as     : 80 (PowerBook Titanium IV)
pmac flags      : 0000001b
L2 cache        : 256K unified
pmac-generation : NewWorld
