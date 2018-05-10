Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40hZlb0FWgzF2CH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2018 00:06:35 +1000 (AEST)
In-Reply-To: <20180430103150.21757-1-npiggin@gmail.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [v3] powerpc/config: powernv_defconfig updates
Message-Id: <40hZlZ2zhWz9s0W@ozlabs.org>
Date: Fri, 11 May 2018 00:06:33 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2018-04-30 at 10:31:50 UTC, Nicholas Piggin wrote:
> For consideration:
> 
> * Add NVDIMM support - Enables greater testing, mambo device.
> * Add IPv6 support built in + additional modules - Because it's 2018 maan.
> * Add DEFERRED_STRUCT_PAGE_INIT - Let's see what breaks.
> * Add PPC_MEMTRACE - Small powernv debugfs driver for getting hardware traces.
> * Add MEMORY_FAILURE - Machine check exceptions can now drive memory failure.
> * Turn on FANOTIFY - This is the current filesystem notification feature.
> * Turn on SCOM_DEBUGFS - Handy for hardware/firmware debugging, security risk?
> * Turn on async SCSI scanning - Let's see what breaks.
> * Add MLX5 driver as a module - Popular demand.
> * Add CRYPTO_CRCT10DIF_VPMSUM - POWER8 T10DIF acceleration.
> 
> * Make a bunch of USB hid drivers modules.
> * Make SCSI SG, SR, and FC modules - FC is huge.
> * Make video drivers except AST GPU modules - Also huge.
> * Make PCI serial driver a module - Uncommon.
> * Make more things modules, NFS FS, RAM disk, netconsole, MS-DOS fs.
> 
> * Get rid of /dev/port - Not used.
> * Remove PPS and PTP subsystms - Unusual.
> * Remove legacy BSD ttys - Long dead.
> * Remove IDE - Deprecated and replaced with ATA.
> * Remove WIRELESS - Until we get POWER9 laptops.
> * Remove RAW - Long deprecated in favour of direct IO.
> * Remove floppy, parport, and PS2 input devices - not supported.
> * Remove virtio drivers, ballooning - We're host only.
> * Remove PPP - Sorry Paulus.
> 
> This results in a significantly smaller vmlinux:
> 
>     text      data       bss        dec   filename
> 13143383   5277944   1317856   19739183   vanilla
> 12263281   4852074   1341720   18457075   patched
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/9a018fb1e14704fef39db05730599f

cheers
