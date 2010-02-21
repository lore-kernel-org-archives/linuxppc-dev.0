Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Sachin Sant <sachinp@in.ibm.com>
Subject: Re: [-next Feb 18] PowerPC boot failure (Unknowd ADD relocation :26)
In-reply-to: <4B7E118C.7060208@in.ibm.com>
References: <4B7E118C.7060208@in.ibm.com>
Date: Mon, 22 Feb 2010 07:35:39 +1100
Message-ID: <505.1266784539@neuling.org>
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>, linux-next@vger.kernel.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



In message <4B7E118C.7060208@in.ibm.com> you wrote:
> This is a multi-part message in MIME format.
> --------------020408070005080107030800
> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
> Content-Transfer-Encoding: 7bit
> 
> Yesterday's next failed to boot on various powerpc boxes
> with following error :
> 
> NET: Registered protocol family 15
> registered taskstats version 1
> Freeing unused kernel memory: 640k freed
> doing fast boot
> scsi_mod: Unknown ADD relocation: 26
> WARNING: Error inserting scsi_mod (/lib/modules/2.6.33-rc8-autotest-next-2010
0218/kernel/drivers/scsi/scsi_mod.ko): Invalid module format
> scsi_tgt: Unknown symbol scsi_release_buffers
> scsi_tgt: Unknown symbol scsi_host_put
> scsi_tgt: Unknown symbol __scsi_put_command
> scsi_tgt: Unknown symbol scsi_host_lookup
> scsi_tgt: Unknown symbol __scsi_get_command
> scsi_tgt: Unknown symbol scsi_init_io
> scsi_tgt: Unknown symbol __scsi_alloc_queue
> 
> and many more such modules related errors.
> I have attached the boot log here.

Can you attached the .config as well for this??

Mikey

> 
> Next Feb 17th was OK. Haven't yet tried the git bisect.
> Will try that out today.
> 
> Thanks
> -Sachin
> 
> 
> -- 
> 
> ---------------------------------
> Sachin Sant
> IBM Linux Technology Center
> India Systems and Technology Labs
> Bangalore, India
> ---------------------------------
> 
> 
> --------------020408070005080107030800
> Content-Type: text/plain;
>  name="boot-log"
> Content-Transfer-Encoding: 7bit
> Content-Disposition: inline;
>  filename="boot-log"
> 
> Using 00825420 bytes for initrd buffer
> Please wait, loading kernel...
> Allocated 00f00000 bytes for kernel @ 00d00000
>    Elf64 kernel loaded...
> Loading ramdisk...
> ramdisk loaded 00825420 @ 034d0000
> OF stdout device is: /vdevice/vty@30000000
> Preparing to boot Linux version 2.6.33-rc8-autotest-next-20100218 (root@llm62
) (gcc version 4.3.2 [gcc-4_3-branch revision 141291] (SUSE Linux) ) #1 SMP Thu
 Feb 18 17:49:40 IST 2010
> Max number of cores passed to firmware: 0x0000000000000200
> Calling ibm,client-architecture-support... done
> command line: root=/dev/sda5 IDENT=1266496633 
> memory layout at init:
>   memory_limit : 0000000000000000 (16 MB aligned)
>   alloc_bottom : 0000000003d00000
>   alloc_top    : 0000000008000000
>   alloc_top_hi : 0000000008000000
>   rmo_top      : 0000000008000000
>   ram_top      : 0000000008000000
> instantiating rtas at 0x00000000074e0000... done
> boot cpu hw idx 0000000000000000
> starting cpu hw idx 0000000000000002... done
> copying OF device tree...
> Building dt strings...
> Building dt structure...
> Device tree strings 0x0000000003d10000 -> 0x0000000003d115fa
> Device tree struct  0x0000000003d20000 -> 0x0000000003d40000
> Calling quiesce...
> returning from prom_init
> Using pSeries machine description
> Using 1TB segments
> Found initrd at 0xc0000000034d0000:0xc000000003cf5420
> bootconsole [udbg0] enabled
> Partition configured for 4 cpus.
> CPU maps initialized for 2 threads per core
> Starting Linux PPC64 #1 SMP Thu Feb 18 17:49:40 IST 2010
> -----------------------------------------------------
> ppc64_pft_size                = 0x1a
> physicalMemorySize            = 0x100000000
> htab_hash_mask                = 0x7ffff
> -----------------------------------------------------
> Initializing cgroup subsys cpuset
> Initializing cgroup subsys cpu
> Linux version 2.6.33-rc8-autotest-next-20100218 (root@llm62) (gcc version 4.3
.2 [gcc-4_3-branch revision 141291] (SUSE Linux) ) #1 SMP Thu Feb 18 17:49:40 I
ST 2010
> [boot]0012 Setup Arch
> EEH: No capable adapters found
> PPC64 nvram contains 15360 bytes
> Zone PFN ranges:
>   DMA      0x00000000 -> 0x00010000
>   Normal   0x00010000 -> 0x00010000
> Movable zone start PFN for each node
> early_node_map[1] active PFN ranges
>     1: 0x00000000 -> 0x00010000
> Could not find start_pfn for node 0
> [boot]0015 Setup Done
> PERCPU: Embedded 2 pages/cpu @c000000000f00000 s89768 r0 d41304 u262144
> pcpu-alloc: s89768 r0 d41304 u262144 alloc=1*1048576
> pcpu-alloc: [0] 0 1 2 3 
> Built 2 zonelists in Node order, mobility grouping on.  Total pages: 65480
> Policy zone: DMA
> Kernel command line: root=/dev/sda5 IDENT=1266496633 
> PID hash table entries: 4096 (order: -1, 32768 bytes)
> freeing bootmem node 1
> Memory: 4142272k/4194304k available (9280k kernel code, 52032k reserved, 2624
k data, 2287k bss, 640k init)
> Hierarchical RCU implementation.
> RCU-based detection of stalled CPUs is enabled.
> NR_IRQS:512 nr_irqs:512
> [boot]0020 XICS Init
> [boot]0021 XICS Done
> clocksource: timebase mult[7d0000] shift[22] registered
> Console: colour dummy device 80x25
> console [hvc0] enabled, bootconsole disabled
> console [hvc0] enabled, bootconsole disabled
> allocated 2621440 bytes of page_cgroup
> please try 'cgroup_disable=memory' option if you don't want memory cgroups
> Security Framework initialized
> SELinux:  Disabled at boot.
> Dentry cache hash table entries: 524288 (order: 6, 4194304 bytes)
> Inode-cache hash table entries: 262144 (order: 5, 2097152 bytes)
> Mount-cache hash table entries: 4096
> Initializing cgroup subsys ns
> Initializing cgroup subsys cpuacct
> Initializing cgroup subsys memory
> Initializing cgroup subsys devices
> Initializing cgroup subsys freezer
> Initializing cgroup subsys blkio
> Processor 1 found.
> Processor 2 found.
> Processor 3 found.
> Brought up 4 CPUs
> devtmpfs: initialized
> NET: Registered protocol family 16
> IBM eBus Device Driver
> POWER6 performance monitor hardware support registered
> PCI: Probing PCI hardware
> bio: create slab <bio-0> at 0
> vgaarb: loaded
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> Switching to clocksource timebase
> NET: Registered protocol family 2
> IP route cache hash table entries: 32768 (order: 2, 262144 bytes)
> TCP established hash table entries: 131072 (order: 5, 2097152 bytes)
> TCP bind hash table entries: 65536 (order: 4, 1048576 bytes)
> TCP: Hash tables configured (established 131072 bind 65536)
> TCP reno registered
> UDP hash table entries: 2048 (order: 0, 65536 bytes)
> UDP-Lite hash table entries: 2048 (order: 0, 65536 bytes)
> NET: Registered protocol family 1
> Unpacking initramfs...
> Freeing initrd memory: 8341k freed
> IOMMU table initialized, virtual merging enabled
> audit: initializing netlink socket (disabled)
> type=2000 audit(1266496684.180:1): initialized
> rcu-torture:--- Start of test: nreaders=8 nfakewriters=4 stat_interval=0 verb
ose=0 test_no_idle_hz=0 shuffle_interval=3 stutter=5 irqreader=1 fqs_duration=0
 fqs_holdoff=0 fqs_stutter=3
> HugeTLB registered 16 MB page size, pre-allocated 0 pages
> HugeTLB registered 16 GB page size, pre-allocated 0 pages
> VFS: Disk quotas dquot_6.5.2
> Dquot-cache hash table entries: 8192 (order 0, 65536 bytes)
> msgmni has been set to 8104
> alg: No test for stdrng (krng)
> Block layer SCSI generic (bsg) driver version 0.4 loaded (major 254)
> io scheduler noop registered
> io scheduler deadline registered
> io scheduler cfq registered (default)
> pci_hotplug: PCI Hot Plug PCI Core version: 0.5
> pciehp: PCI Express Hot Plug Controller Driver version: 0.4
> rpaphp: RPA HOT Plug PCI Controller Driver version: 0.1
> Generic RTC Driver v1.07
> Serial: 8250/16550 driver, 4 ports, IRQ sharing disabled
> pmac_zilog: 0.6 (Benjamin Herrenschmidt <benh@kernel.crashing.org>)
> Uniform Multi-Platform E-IDE driver
> ide-gd driver 1.18
> ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> mice: PS/2 mouse device common for all mice
> EDAC MC: Ver: 2.1.0 Feb 18 2010
> usbcore: registered new interface driver hiddev
> usbcore: registered new interface driver usbhid
> usbhid: USB HID core driver
> TCP cubic registered
> NET: Registered protocol family 15
> registered taskstats version 1
> Freeing unused kernel memory: 640k freed
> doing fast boot
> scsi_mod: Unknown ADD relocation: 26
> WARNING: Error inserting scsi_mod (/lib/modules/2.6.33-rc8-autotest-next-2010
0218/kernel/drivers/scsi/scsi_mod.ko): Invalid module format
> scsi_tgt: Unknown symbol scsi_release_buffers
> scsi_tgt: Unknown symbol scsi_host_put
> scsi_tgt: Unknown symbol __scsi_put_command
> scsi_tgt: Unknown symbol scsi_host_lookup
> scsi_tgt: Unknown symbol __scsi_get_command
> scsi_tgt: Unknown symbol scsi_init_io
> scsi_tgt: Unknown symbol __scsi_alloc_queue
> WARNING: Error inserting scsi_tgt (/lib/modules/2.6.33-rc8-autotest-next-2010
0218/kernel/drivers/scsi/scsi_tgt.ko): Unknown symbol in module, or unknown par
ameter (see dmesg)
> scsi_transport_srp: Unknown symbol scsi_tgt_it_nexus_destroy
> scsi_transport_srp: Unknown symbol scsi_tgt_it_nexus_create
> scsi_transport_srp: Unknown symbol scsi_is_host_device
> WARNING: Error inserting scsi_transport_srp (/lib/modules/2.6.33-rc8-autotest
-next-20100218/kernel/drivers/scsi/scsi_transport_srp.ko): Unknown symbol in mo
dule, or unknown parameter (see dmesg)
> ibmvscsic: Unknown symbol scsi_block_requests
> ibmvscsic: Unknown symbol scsi_scan_host
> ibmvscsic: Unknown symbol scsi_dma_unmap
> ibmvscsic: Unknown symbol scsi_add_host_with_dma
> ibmvscsic: Unknown symbol scsi_host_put
> ibmvscsic: Unknown symbol srp_release_transport
> ibmvscsic: Unknown symbol scsi_dma_map
> ibmvscsic: Unknown symbol srp_remove_host
> ibmvscsic: Unknown symbol srp_attach_transport
> ibmvscsic: Unknown symbol scsi_unblock_requests
> ibmvscsic: Unknown symbol scsi_remove_host
> ibmvscsic: Unknown symbol srp_rport_add
> ibmvscsic: Unknown symbol scsi_adjust_queue_depth
> ibmvscsic: Unknown symbol scsi_host_alloc
> FATAL: Error inserting ibmvscsic (/lib/modules/2.6.33-rc8-autotest-next-20100
218/kernel/drivers/scsi/ibmvscsi/ibmvscsic.ko): Unknown symbol in module, or un
known parameter (see dmesg)
> Creating device nodes with udev
> udevd version 128 started
> scsi_mod: Unknown ADD relocation: 26
> scsi_tgt: Unknown symbol scsi_release_buffers
> scsi_tgt: Unknown symbol scsi_host_put
> scsi_tgt: Unknown symbol __scsi_put_command
> scsi_tgt: Unknown symbol scsi_host_lookup
> scsi_tgt: Unknown symbol __scsi_get_command
> scsi_tgt: Unknown symbol scsi_init_io
> scsi_tgt: Unknown symbol __scsi_alloc_queue
> scsi_transport_srp: Unknown symbol scsi_tgt_it_nexus_destroy
> scsi_transport_srp: Unknown symbol scsi_tgt_it_nexus_create
> scsi_transport_srp: Unknown symbol scsi_is_host_device
> ibmvscsic: Unknown symbol scsi_block_requests
> ibmvscsic: Unknown symbol scsi_scan_host
> ibmvscsic: Unknown symbol scsi_dma_unmap
> ibmvscsic: Unknown symbol scsi_add_host_with_dma
> ibmvscsic: Unknown symbol scsi_host_put
> ibmvscsic: Unknown symbol srp_release_transport
> ibmvscsic: Unknown symbol scsi_dma_map
> ibmvscsic: Unknown symbol srp_remove_host
> ibmvscsic: Unknown symbol srp_attach_transport
> ibmvscsic: Unknown symbol scsi_unblock_requests
> ibmvscsic: Unknown symbol scsi_remove_host
> ibmvscsic: Unknown symbol srp_rport_add
> ibmvscsic: Unknown symbol scsi_adjust_queue_depth
> ibmvscsic: Unknown symbol scsi_host_alloc
> Boot logging started on /dev/hvc0(/dev/console) at Thu Feb 18 12:38:04 2010
> resume device  not found (ignoring)
> Waiting for device /dev/sda5 to appear: ..............................Could n
ot find /dev/sda5.
> Want me to fall back to /dev/sda5? (Y/n) 
> -- 0:conmux-control -- time-stamp -- Feb/18/10  4:41:54 --
> -- 0:conmux-control -- time-stamp -- Feb/18/10  6:00:16 --
> (user:ssant@in.ibm.com) connected
> 
> Waiting for device /dev/sda5 to appear: ..............................not fou
nd -- exiting to /bin/sh
> 
> 
> --------------020408070005080107030800
> Content-Type: text/plain; charset="us-ascii"
> MIME-Version: 1.0
> Content-Transfer-Encoding: 7bit
> Content-Disposition: inline
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> --------------020408070005080107030800--
> 
