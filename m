Return-Path: <zwu.kernel@gmail.com>
Received: from mail-pw0-f50.google.com (mail-pw0-f50.google.com
	[209.85.160.50]) by ozlabs.org (Postfix) with ESMTP id CB8E7B6F08
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2009 18:38:38 +1100 (EST)
Received: by pwi20 with SMTP id 20so1861717pwi.9
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Dec 2009 23:38:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <2375c9f90912172312x7d324979r10da5ecd7edc61d3@mail.gmail.com>
References: <b1e768440912172008g605bade0ledc77f91eeaa9d36@mail.gmail.com>
	<2375c9f90912172312x7d324979r10da5ecd7edc61d3@mail.gmail.com>
Date: Fri, 18 Dec 2009 15:38:37 +0800
Message-ID: <b1e768440912172338k8849393ye23f5e277f554caf@mail.gmail.com>
Subject: Re: 2.6.32 Kernel panic - not syncing: Attempted to kill init!
	Rebooting in 180 seconds..
From: Zhiyong Wu <zwu.kernel@gmail.com>
To: =?ISO-8859-1?Q?Am=E9rico_Wang?= <xiyou.wangcong@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
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

It does'nt still work based on your method.


Cheers,

Zhiyong Wu

On Fri, Dec 18, 2009 at 3:12 PM, Am=E9rico Wang <xiyou.wangcong@gmail.com> =
wrote:
> On Fri, Dec 18, 2009 at 12:08 PM, Zhiyong Wu <zwu.kernel@gmail.com> wrote=
:
>> HI,
>>
>> linux-2.6.32 is compiled on a p6 machine with RH5.4 OS and KVM option is=
 enable.
>>
>> When rebooting this machine, a crash takes place such as:
>>
>> Loading ramdisk...
>> ramdisk loaded at 01700000, size: 2700 Kbytes
>> OF stdout device is: /vdevice/vty@30000000
>> Preparing to boot Linux version 2.6.32 (root@p6ml4n07.clusters.com)
>> (gcc version 4.1.2 20080704 (Red Hat 4.1.2-46)) #1 SMP Fri Dec 18
>> 06:53:27 EST 2009
>> Calling ibm,client-architecture-support.../
>> Elapsed time since release of system processors: 1212 mins 30 secs
>>
>> Config file read, 1024 bytes
>>
>> Welcome
>> Welcome to yaboot version 1.3.13 (Red Hat 1.3.13-8.el5)
>> Enter "help" to get some basic usage information
>> boot: linux-32
>> Please wait, loading kernel...
>> =A0 Elf64 kernel loaded...
>> Loading ramdisk...
>> ramdisk loaded at 01700000, size: 2700 Kbytes
>> OF stdout device is: /vdevice/vty@30000000
>> Preparing to boot Linux version 2.6.32 (root@p6ml4n07.clusters.com)
>> (gcc version 4.1.2 20080704 (Red Hat 4.1.2-46)) #1 SMP Fri Dec 18
>> 06:53:27 EST 2009
>> Calling ibm,client-architecture-support... done
>> command line: ro console=3Dhvc0 rhgb quiet root=3DLABEL=3D/
>> memory layout at init:
>> =A0memory_limit : 0000000000000000 (16 MB aligned)
>> =A0alloc_bottom : 00000000019b0000
>> =A0alloc_top =A0 =A0: 0000000008000000
>> =A0alloc_top_hi : 0000000008000000
>> =A0rmo_top =A0 =A0 =A0: 0000000008000000
>> =A0ram_top =A0 =A0 =A0: 0000000008000000
>> instantiating rtas at 0x0000000006e10000... done
>> boot cpu hw idx 0000000000000000
>> copying OF device tree...
>> Building dt strings...
>> Building dt structure...
>> Device tree strings 0x0000000001bc0000 -> 0x0000000001bc15bb
>> Device tree struct =A00x0000000001bd0000 -> 0x0000000001bf0000
>> Calling quiesce...
>> returning from prom_init
>> Red Hat nash version 5.1.19.6 starting
>> ibmvscsi 30000002: fast_fail not supported in server
>> sd 0:0:1:0: [sda] Assuming drive cache: write through
>> sd 0:0:1:0: [sda] Assuming drive cache: write through
>> sd 0:0:1:0: [sda] Assuming drive cache: write through
>> insmod: error inserting '/lib/dm-region-hash.ko': -1 File exists
>> mount: could not find filesystem '/dev/root'
>> setuproot: moving /dev failed: No such file or directory
>> setuproot: error mounting /proc: No such file or directory
>> setuproot: error mounting /sys: No such file or directory
>> switchroot: mount failed: No such file or directory
>> Kernel panic - not syncing: Attempted to kill init!
>> Rebooting in 180 seconds..[disconnect]
>>
>> Can anyone give me a warm hand?
>
> Probably this is not a problem of kernel, maybe it's
> a problem of your initial ramdisk, or something wrong with
> your root filesystem.
>
> Does changing "root=3DLABEL=3D/" to "root=3D/dev/XXX" help?
> Where "/dev/XXX" is your root filesystem.
>
