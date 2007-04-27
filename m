Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 30B06DDF41
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Apr 2007 09:42:26 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: patches for 2.6.22
Date: Sat, 28 Apr 2007 01:42:07 +0200
References: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
In-Reply-To: <17969.56735.644629.328360@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200704280142.08249.arnd@arndb.de>
Cc: Paul Mackerras <paulus@samba.org>, jeremy@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 27 April 2007, Paul Mackerras wrote:
> If anyone has patches that I haven't picked up yet which they think
> should go into 2.6.22, please send me either a pointer to the
> patches if previously posted to linuxppc-dev, or post them to
> linuxppc-dev. 

I still have around 20 patches pending. Most of them are for spufs,
and I'm waiting to get feedback about them from Jeremy.

http://kernel.org/pub/linux/kernel/people/arnd/patches/2.6.21-rc7-arnd2/2.6.21-rc7-arnd2.log
has a description of what is still pending, the patches in detail are:

#### SPE affinity
cell-be_info-2.diff
cell-spu_indexing-2.diff
cell-spu_indexing_QS20-2.diff
spufs-affinity_create-4.diff
spufs-affinity_placement-4.diff
spufs-affinity_schedulling-2.diff
cell-spu_indexing_FW_vicinity-1.diff

-> waiting for an ack

spu_base-locking-cleanup.diff

-> ok with me, but depends on above

#### SPE oprofile support
re-cell-oprofile-spu-profiling-updated-patch-4.diff
re-add-support-to-oprofile-for-profiling-cell-be-spus-update-2.diff

-> want to do a final review myself

#### spu scheduler updates
spusched-remove-wakeup-races.diff
spusched-kthread.diff
spusched-dynamic-timeslicing.diff
spusched-update-policy.diff
spusched-fix-cpubind.diff
spu-loadavg.diff

-> looks ok to me, but depends on the above

#### under discussion
axon-ram-3.diff

-> This version hasn't been reviewed yet, the author hasn't signed off.

64k-support-for-kexec.diff

-> discussion ongoing, will hopefully come to a conclusion soon

powerpc-uninline-of_iomap.diff
cell-cbe_cpufreq-cleanup-and-crash-fix.diff

-> have been submitted after the previous merge with you, should go in.

	Arnd <><
