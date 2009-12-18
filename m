Return-Path: <21cnbao@gmail.com>
Received: from mail-yx0-f178.google.com (mail-yx0-f178.google.com
	[209.85.210.178]) by ozlabs.org (Postfix) with ESMTP id 7E287B6F07
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2009 17:51:04 +1100 (EST)
Received: by yxe8 with SMTP id 8so2964886yxe.17
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2009 22:51:02 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <b1e768440912172008g605bade0ledc77f91eeaa9d36@mail.gmail.com>
References: <b1e768440912172008g605bade0ledc77f91eeaa9d36@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 18 Dec 2009 14:50:42 +0800
Message-ID: <3c17e3570912172250l3515de1dub187da76302a1e50@mail.gmail.com>
Subject: Re: 2.6.32 Kernel panic - not syncing: Attempted to kill init!
	Rebooting in 180 seconds..
To: Zhiyong Wu <zwu.kernel@gmail.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, agraf@suse.de, llim@redhat.com,
	linux-kernel@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Dec 18, 2009 at 12:08 PM, Zhiyong Wu <zwu.kernel@gmail.com> wrote:
> HI,
>
> linux-2.6.32 is compiled on a p6 machine with RH5.4 OS and KVM option is =
enable.
>
> When rebooting this machine, a crash takes place such as:
>
> Loading ramdisk...
> ramdisk loaded at 01700000, size: 2700 Kbytes
> OF stdout device is: /vdevice/vty@30000000
> Preparing to boot Linux version 2.6.32 (root@p6ml4n07.clusters.com)
> (gcc version 4.1.2 20080704 (Red Hat 4.1.2-46)) #1 SMP Fri Dec 18
> 06:53:27 EST 2009
> Calling ibm,client-architecture-support.../
> Elapsed time since release of system processors: 1212 mins 30 secs
>
> Config file read, 1024 bytes
>
> Welcome
> Welcome to yaboot version 1.3.13 (Red Hat 1.3.13-8.el5)
> Enter "help" to get some basic usage information
> boot: linux-32
> Please wait, loading kernel...
> =C2=A0 Elf64 kernel loaded...
> Loading ramdisk...
> ramdisk loaded at 01700000, size: 2700 Kbytes
> OF stdout device is: /vdevice/vty@30000000
> Preparing to boot Linux version 2.6.32 (root@p6ml4n07.clusters.com)
> (gcc version 4.1.2 20080704 (Red Hat 4.1.2-46)) #1 SMP Fri Dec 18
> 06:53:27 EST 2009
> Calling ibm,client-architecture-support... done
> command line: ro console=3Dhvc0 rhgb quiet root=3DLABEL=3D/
> memory layout at init:
> =C2=A0memory_limit : 0000000000000000 (16 MB aligned)
> =C2=A0alloc_bottom : 00000000019b0000
> =C2=A0alloc_top =C2=A0 =C2=A0: 0000000008000000
> =C2=A0alloc_top_hi : 0000000008000000
> =C2=A0rmo_top =C2=A0 =C2=A0 =C2=A0: 0000000008000000
> =C2=A0ram_top =C2=A0 =C2=A0 =C2=A0: 0000000008000000
> instantiating rtas at 0x0000000006e10000... done
> boot cpu hw idx 0000000000000000
> copying OF device tree...
> Building dt strings...
> Building dt structure...
> Device tree strings 0x0000000001bc0000 -> 0x0000000001bc15bb
> Device tree struct =C2=A00x0000000001bd0000 -> 0x0000000001bf0000
> Calling quiesce...
> returning from prom_init
> Red Hat nash version 5.1.19.6 starting
> ibmvscsi 30000002: fast_fail not supported in server
> sd 0:0:1:0: [sda] Assuming drive cache: write through
> sd 0:0:1:0: [sda] Assuming drive cache: write through
> sd 0:0:1:0: [sda] Assuming drive cache: write through
> insmod: error inserting '/lib/dm-region-hash.ko': -1 File exists
> mount: could not find filesystem '/dev/root'
> setuproot: moving /dev failed: No such file or directory
> setuproot: error mounting /proc: No such file or directory
> setuproot: error mounting /sys: No such file or directory
> switchroot: mount failed: No such file or directory
> Kernel panic - not syncing: Attempted to kill init!
> Rebooting in 180 seconds..[disconnect]

Your rootfs is not ready. No console, no /dev, then init process can't star=
t-up.

>
> Can anyone give me a warm hand?
>
>
> Cheers,
>
> Zhiyong Wu
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =C2=A0http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at =C2=A0http://www.tux.org/lkml/
>
