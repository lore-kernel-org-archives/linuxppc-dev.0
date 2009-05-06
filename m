Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.30])
	by ozlabs.org (Postfix) with ESMTP id 396EEDE68D
	for <linuxppc-dev@ozlabs.org>; Thu,  7 May 2009 06:30:20 +1000 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so176390yxb.39
	for <linuxppc-dev@ozlabs.org>; Wed, 06 May 2009 13:30:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1241641262-5202-2-git-send-email-wd@denx.de>
References: <1241641262-5202-1-git-send-email-wd@denx.de>
	<1241641262-5202-2-git-send-email-wd@denx.de>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 6 May 2009 14:29:59 -0600
Message-ID: <fa686aa40905061329m352cfbah1afa2d07fe5930c7@mail.gmail.com>
Subject: Re: [PATCH 01/04] mpc5121: prepare support for additional boards
To: Wolfgang Denk <wd@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, May 6, 2009 at 2:20 PM, Wolfgang Denk <wd@denx.de> wrote:
> As more MPC512x based boards will be coming soon, a new directory
> arch/powerpc/configs/512x/ for board specific config files is created,
> following the example of other processor families.
>
> In a first step, we just copy (and update) the existing defconfig
> file for the mpc5121ads board. When new boards get added, the old
> arch/powerpc/configs/mpc5121_defconfig file will get adjusted to
> allow for a generic kernel image for MPC512x based boards.
>
> Signed-off-by: Wolfgang Denk <wd@denx.de>
> Cc: Grant Likely <grant.likely@secretlab.ca>
> Cc: John Rigby <jcrigby@gmail.com>

I'll ignore this one for the time being.  After stuff is actually
merged and at about -rc2 time is the time to muck around with
defconfigs.

g.

> ---
> =A0arch/powerpc/configs/512x/mpc5121ads_defconfig | 1190 ++++++++++++++++=
++++++++
> =A01 files changed, 1190 insertions(+), 0 deletions(-)
> =A0create mode 100644 arch/powerpc/configs/512x/mpc5121ads_defconfig
>
> diff --git a/arch/powerpc/configs/512x/mpc5121ads_defconfig b/arch/powerp=
c/configs/512x/mpc5121ads_defconfig
> new file mode 100644
> index 0000000..ac6c18f
> --- /dev/null
> +++ b/arch/powerpc/configs/512x/mpc5121ads_defconfig
> @@ -0,0 +1,1190 @@
> +#
> +# Automatically generated make config: don't edit
> +# Linux kernel version: 2.6.30-rc4
> +# Wed May =A06 20:48:17 2009
> +#
> +# CONFIG_PPC64 is not set
> +
> +#
> +# Processor support
> +#
> +CONFIG_6xx=3Dy
> +# CONFIG_PPC_85xx is not set
> +# CONFIG_PPC_8xx is not set
> +# CONFIG_40x is not set
> +# CONFIG_44x is not set
> +# CONFIG_E200 is not set
> +CONFIG_PPC_BOOK3S=3Dy
> +CONFIG_PPC_FPU=3Dy
> +# CONFIG_ALTIVEC is not set
> +CONFIG_PPC_STD_MMU=3Dy
> +CONFIG_PPC_STD_MMU_32=3Dy
> +# CONFIG_PPC_MM_SLICES is not set
> +# CONFIG_SMP is not set
> +CONFIG_NOT_COHERENT_CACHE=3Dy
> +CONFIG_PPC32=3Dy
> +CONFIG_WORD_SIZE=3D32
> +# CONFIG_ARCH_PHYS_ADDR_T_64BIT is not set
> +CONFIG_MMU=3Dy
> +CONFIG_GENERIC_CMOS_UPDATE=3Dy
> +CONFIG_GENERIC_TIME=3Dy
> +CONFIG_GENERIC_TIME_VSYSCALL=3Dy
> +CONFIG_GENERIC_CLOCKEVENTS=3Dy
> +CONFIG_GENERIC_HARDIRQS=3Dy
> +# CONFIG_HAVE_SETUP_PER_CPU_AREA is not set
> +CONFIG_IRQ_PER_CPU=3Dy
> +CONFIG_STACKTRACE_SUPPORT=3Dy
> +CONFIG_HAVE_LATENCYTOP_SUPPORT=3Dy
> +CONFIG_LOCKDEP_SUPPORT=3Dy
> +CONFIG_RWSEM_XCHGADD_ALGORITHM=3Dy
> +CONFIG_ARCH_HAS_ILOG2_U32=3Dy
> +CONFIG_GENERIC_HWEIGHT=3Dy
> +CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
> +CONFIG_GENERIC_FIND_NEXT_BIT=3Dy
> +# CONFIG_ARCH_NO_VIRT_TO_BUS is not set
> +CONFIG_PPC=3Dy
> +CONFIG_EARLY_PRINTK=3Dy
> +CONFIG_GENERIC_NVRAM=3Dy
> +CONFIG_SCHED_OMIT_FRAME_POINTER=3Dy
> +CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
> +CONFIG_PPC_OF=3Dy
> +CONFIG_OF=3Dy
> +# CONFIG_PPC_UDBG_16550 is not set
> +# CONFIG_GENERIC_TBSYNC is not set
> +CONFIG_AUDIT_ARCH=3Dy
> +CONFIG_GENERIC_BUG=3Dy
> +CONFIG_DEFAULT_UIMAGE=3Dy
> +# CONFIG_PPC_DCR_NATIVE is not set
> +# CONFIG_PPC_DCR_MMIO is not set
> +CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=3Dy
> +CONFIG_DEFCONFIG_LIST=3D"/lib/modules/$UNAME_RELEASE/.config"
> +
> +#
> +# General setup
> +#
> +CONFIG_EXPERIMENTAL=3Dy
> +CONFIG_BROKEN_ON_SMP=3Dy
> +CONFIG_INIT_ENV_ARG_LIMIT=3D32
> +CONFIG_LOCALVERSION=3D""
> +CONFIG_LOCALVERSION_AUTO=3Dy
> +# CONFIG_SWAP is not set
> +CONFIG_SYSVIPC=3Dy
> +CONFIG_SYSVIPC_SYSCTL=3Dy
> +# CONFIG_POSIX_MQUEUE is not set
> +# CONFIG_BSD_PROCESS_ACCT is not set
> +# CONFIG_TASKSTATS is not set
> +# CONFIG_AUDIT is not set
> +
> +#
> +# RCU Subsystem
> +#
> +CONFIG_CLASSIC_RCU=3Dy
> +# CONFIG_TREE_RCU is not set
> +# CONFIG_PREEMPT_RCU is not set
> +# CONFIG_TREE_RCU_TRACE is not set
> +# CONFIG_PREEMPT_RCU_TRACE is not set
> +# CONFIG_IKCONFIG is not set
> +CONFIG_LOG_BUF_SHIFT=3D16
> +# CONFIG_GROUP_SCHED is not set
> +# CONFIG_CGROUPS is not set
> +CONFIG_SYSFS_DEPRECATED=3Dy
> +CONFIG_SYSFS_DEPRECATED_V2=3Dy
> +# CONFIG_RELAY is not set
> +CONFIG_NAMESPACES=3Dy
> +# CONFIG_UTS_NS is not set
> +# CONFIG_IPC_NS is not set
> +# CONFIG_USER_NS is not set
> +# CONFIG_PID_NS is not set
> +# CONFIG_NET_NS is not set
> +CONFIG_BLK_DEV_INITRD=3Dy
> +CONFIG_INITRAMFS_SOURCE=3D""
> +CONFIG_RD_GZIP=3Dy
> +CONFIG_RD_BZIP2=3Dy
> +CONFIG_RD_LZMA=3Dy
> +# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> +CONFIG_SYSCTL=3Dy
> +CONFIG_ANON_INODES=3Dy
> +# CONFIG_EMBEDDED is not set
> +CONFIG_SYSCTL_SYSCALL=3Dy
> +CONFIG_KALLSYMS=3Dy
> +# CONFIG_KALLSYMS_EXTRA_PASS is not set
> +# CONFIG_STRIP_ASM_SYMS is not set
> +CONFIG_HOTPLUG=3Dy
> +CONFIG_PRINTK=3Dy
> +CONFIG_BUG=3Dy
> +CONFIG_ELF_CORE=3Dy
> +CONFIG_BASE_FULL=3Dy
> +CONFIG_FUTEX=3Dy
> +CONFIG_EPOLL=3Dy
> +CONFIG_SIGNALFD=3Dy
> +CONFIG_TIMERFD=3Dy
> +CONFIG_EVENTFD=3Dy
> +CONFIG_SHMEM=3Dy
> +CONFIG_AIO=3Dy
> +CONFIG_VM_EVENT_COUNTERS=3Dy
> +CONFIG_PCI_QUIRKS=3Dy
> +# CONFIG_COMPAT_BRK is not set
> +CONFIG_SLAB=3Dy
> +# CONFIG_SLUB is not set
> +# CONFIG_SLOB is not set
> +# CONFIG_PROFILING is not set
> +# CONFIG_MARKERS is not set
> +CONFIG_HAVE_OPROFILE=3Dy
> +# CONFIG_KPROBES is not set
> +CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=3Dy
> +CONFIG_HAVE_IOREMAP_PROT=3Dy
> +CONFIG_HAVE_KPROBES=3Dy
> +CONFIG_HAVE_KRETPROBES=3Dy
> +CONFIG_HAVE_ARCH_TRACEHOOK=3Dy
> +CONFIG_HAVE_CLK=3Dy
> +# CONFIG_SLOW_WORK is not set
> +# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
> +CONFIG_SLABINFO=3Dy
> +CONFIG_RT_MUTEXES=3Dy
> +CONFIG_BASE_SMALL=3D0
> +CONFIG_MODULES=3Dy
> +# CONFIG_MODULE_FORCE_LOAD is not set
> +CONFIG_MODULE_UNLOAD=3Dy
> +# CONFIG_MODULE_FORCE_UNLOAD is not set
> +# CONFIG_MODVERSIONS is not set
> +# CONFIG_MODULE_SRCVERSION_ALL is not set
> +CONFIG_BLOCK=3Dy
> +# CONFIG_LBD is not set
> +# CONFIG_BLK_DEV_BSG is not set
> +# CONFIG_BLK_DEV_INTEGRITY is not set
> +
> +#
> +# IO Schedulers
> +#
> +CONFIG_IOSCHED_NOOP=3Dy
> +# CONFIG_IOSCHED_AS is not set
> +CONFIG_IOSCHED_DEADLINE=3Dy
> +# CONFIG_IOSCHED_CFQ is not set
> +# CONFIG_DEFAULT_AS is not set
> +CONFIG_DEFAULT_DEADLINE=3Dy
> +# CONFIG_DEFAULT_CFQ is not set
> +# CONFIG_DEFAULT_NOOP is not set
> +CONFIG_DEFAULT_IOSCHED=3D"deadline"
> +# CONFIG_FREEZER is not set
> +CONFIG_PPC_MSI_BITMAP=3Dy
> +
> +#
> +# Platform support
> +#
> +# CONFIG_PPC_CHRP is not set
> +CONFIG_PPC_MPC512x=3Dy
> +CONFIG_PPC_MPC5121=3Dy
> +# CONFIG_ARIA is not set
> +CONFIG_MPC5121_ADS=3Dy
> +# CONFIG_MPC5121_GENERIC is not set
> +# CONFIG_PPC_MPC52xx is not set
> +# CONFIG_PPC_PMAC is not set
> +# CONFIG_PPC_CELL is not set
> +# CONFIG_PPC_CELL_NATIVE is not set
> +# CONFIG_PPC_82xx is not set
> +# CONFIG_PQ2ADS is not set
> +# CONFIG_PPC_83xx is not set
> +# CONFIG_PPC_86xx is not set
> +# CONFIG_EMBEDDED6xx is not set
> +# CONFIG_AMIGAONE is not set
> +CONFIG_PPC_OF_BOOT_TRAMPOLINE=3Dy
> +CONFIG_IPIC=3Dy
> +# CONFIG_MPIC is not set
> +# CONFIG_MPIC_WEIRD is not set
> +# CONFIG_PPC_I8259 is not set
> +# CONFIG_PPC_RTAS is not set
> +# CONFIG_MMIO_NVRAM is not set
> +# CONFIG_PPC_MPC106 is not set
> +# CONFIG_PPC_970_NAP is not set
> +# CONFIG_PPC_INDIRECT_IO is not set
> +# CONFIG_GENERIC_IOMAP is not set
> +# CONFIG_CPU_FREQ is not set
> +# CONFIG_TAU is not set
> +# CONFIG_QUICC_ENGINE is not set
> +# CONFIG_FSL_ULI1575 is not set
> +# CONFIG_SIMPLE_GPIO is not set
> +
> +#
> +# Kernel options
> +#
> +# CONFIG_HIGHMEM is not set
> +CONFIG_TICK_ONESHOT=3Dy
> +CONFIG_NO_HZ=3Dy
> +# CONFIG_HIGH_RES_TIMERS is not set
> +CONFIG_GENERIC_CLOCKEVENTS_BUILD=3Dy
> +# CONFIG_HZ_100 is not set
> +# CONFIG_HZ_250 is not set
> +# CONFIG_HZ_300 is not set
> +CONFIG_HZ_1000=3Dy
> +CONFIG_HZ=3D1000
> +# CONFIG_SCHED_HRTICK is not set
> +CONFIG_PREEMPT_NONE=3Dy
> +# CONFIG_PREEMPT_VOLUNTARY is not set
> +# CONFIG_PREEMPT is not set
> +CONFIG_BINFMT_ELF=3Dy
> +# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
> +# CONFIG_HAVE_AOUT is not set
> +# CONFIG_BINFMT_MISC is not set
> +# CONFIG_IOMMU_HELPER is not set
> +CONFIG_PPC_NEED_DMA_SYNC_OPS=3Dy
> +CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=3Dy
> +CONFIG_ARCH_HAS_WALK_MEMORY=3Dy
> +CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=3Dy
> +# CONFIG_KEXEC is not set
> +# CONFIG_CRASH_DUMP is not set
> +CONFIG_ARCH_FLATMEM_ENABLE=3Dy
> +CONFIG_ARCH_POPULATES_NODE_MAP=3Dy
> +CONFIG_SELECT_MEMORY_MODEL=3Dy
> +CONFIG_FLATMEM_MANUAL=3Dy
> +# CONFIG_DISCONTIGMEM_MANUAL is not set
> +# CONFIG_SPARSEMEM_MANUAL is not set
> +CONFIG_FLATMEM=3Dy
> +CONFIG_FLAT_NODE_MEM_MAP=3Dy
> +CONFIG_PAGEFLAGS_EXTENDED=3Dy
> +CONFIG_SPLIT_PTLOCK_CPUS=3D4
> +# CONFIG_MIGRATION is not set
> +# CONFIG_PHYS_ADDR_T_64BIT is not set
> +CONFIG_ZONE_DMA_FLAG=3D1
> +CONFIG_BOUNCE=3Dy
> +CONFIG_VIRT_TO_BUS=3Dy
> +# CONFIG_UNEVICTABLE_LRU is not set
> +CONFIG_HAVE_MLOCK=3Dy
> +CONFIG_PPC_4K_PAGES=3Dy
> +# CONFIG_PPC_16K_PAGES is not set
> +# CONFIG_PPC_64K_PAGES is not set
> +# CONFIG_PPC_256K_PAGES is not set
> +CONFIG_FORCE_MAX_ZONEORDER=3D11
> +CONFIG_PROC_DEVICETREE=3Dy
> +# CONFIG_CMDLINE_BOOL is not set
> +CONFIG_EXTRA_TARGETS=3D""
> +# CONFIG_PM is not set
> +# CONFIG_SECCOMP is not set
> +CONFIG_ISA_DMA_API=3Dy
> +
> +#
> +# Bus options
> +#
> +CONFIG_ZONE_DMA=3Dy
> +CONFIG_GENERIC_ISA_DMA=3Dy
> +CONFIG_PPC_INDIRECT_PCI=3Dy
> +CONFIG_FSL_SOC=3Dy
> +CONFIG_FSL_PCI=3Dy
> +CONFIG_PPC_PCI_CHOICE=3Dy
> +CONFIG_PCI=3Dy
> +CONFIG_PCI_DOMAINS=3Dy
> +CONFIG_PCI_SYSCALL=3Dy
> +CONFIG_PCIEPORTBUS=3Dy
> +CONFIG_PCIEAER=3Dy
> +# CONFIG_PCIEASPM is not set
> +CONFIG_ARCH_SUPPORTS_MSI=3Dy
> +CONFIG_PCI_MSI=3Dy
> +# CONFIG_PCI_LEGACY is not set
> +# CONFIG_PCI_STUB is not set
> +# CONFIG_PCI_IOV is not set
> +# CONFIG_PCCARD is not set
> +# CONFIG_HOTPLUG_PCI is not set
> +# CONFIG_HAS_RAPIDIO is not set
> +
> +#
> +# Advanced setup
> +#
> +# CONFIG_ADVANCED_OPTIONS is not set
> +
> +#
> +# Default settings for advanced configuration options are used
> +#
> +CONFIG_LOWMEM_SIZE=3D0x30000000
> +CONFIG_PAGE_OFFSET=3D0xc0000000
> +CONFIG_KERNEL_START=3D0xc0000000
> +CONFIG_PHYSICAL_START=3D0x00000000
> +CONFIG_TASK_SIZE=3D0xc0000000
> +CONFIG_NET=3Dy
> +
> +#
> +# Networking options
> +#
> +CONFIG_PACKET=3Dy
> +# CONFIG_PACKET_MMAP is not set
> +CONFIG_UNIX=3Dy
> +# CONFIG_NET_KEY is not set
> +CONFIG_INET=3Dy
> +# CONFIG_IP_MULTICAST is not set
> +# CONFIG_IP_ADVANCED_ROUTER is not set
> +CONFIG_IP_FIB_HASH=3Dy
> +CONFIG_IP_PNP=3Dy
> +# CONFIG_IP_PNP_DHCP is not set
> +# CONFIG_IP_PNP_BOOTP is not set
> +# CONFIG_IP_PNP_RARP is not set
> +# CONFIG_NET_IPIP is not set
> +# CONFIG_NET_IPGRE is not set
> +# CONFIG_ARPD is not set
> +# CONFIG_SYN_COOKIES is not set
> +# CONFIG_INET_AH is not set
> +# CONFIG_INET_ESP is not set
> +# CONFIG_INET_IPCOMP is not set
> +# CONFIG_INET_XFRM_TUNNEL is not set
> +# CONFIG_INET_TUNNEL is not set
> +# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
> +# CONFIG_INET_XFRM_MODE_TUNNEL is not set
> +# CONFIG_INET_XFRM_MODE_BEET is not set
> +# CONFIG_INET_LRO is not set
> +# CONFIG_INET_DIAG is not set
> +# CONFIG_TCP_CONG_ADVANCED is not set
> +CONFIG_TCP_CONG_CUBIC=3Dy
> +CONFIG_DEFAULT_TCP_CONG=3D"cubic"
> +# CONFIG_TCP_MD5SIG is not set
> +# CONFIG_IPV6 is not set
> +# CONFIG_NETWORK_SECMARK is not set
> +# CONFIG_NETFILTER is not set
> +# CONFIG_IP_DCCP is not set
> +# CONFIG_IP_SCTP is not set
> +# CONFIG_TIPC is not set
> +# CONFIG_ATM is not set
> +# CONFIG_BRIDGE is not set
> +# CONFIG_NET_DSA is not set
> +# CONFIG_VLAN_8021Q is not set
> +# CONFIG_DECNET is not set
> +# CONFIG_LLC2 is not set
> +# CONFIG_IPX is not set
> +# CONFIG_ATALK is not set
> +# CONFIG_X25 is not set
> +# CONFIG_LAPB is not set
> +# CONFIG_ECONET is not set
> +# CONFIG_WAN_ROUTER is not set
> +# CONFIG_PHONET is not set
> +# CONFIG_NET_SCHED is not set
> +# CONFIG_DCB is not set
> +
> +#
> +# Network testing
> +#
> +# CONFIG_NET_PKTGEN is not set
> +# CONFIG_HAMRADIO is not set
> +# CONFIG_CAN is not set
> +# CONFIG_IRDA is not set
> +# CONFIG_BT is not set
> +# CONFIG_AF_RXRPC is not set
> +# CONFIG_WIRELESS is not set
> +# CONFIG_WIMAX is not set
> +# CONFIG_RFKILL is not set
> +# CONFIG_NET_9P is not set
> +
> +#
> +# Device Drivers
> +#
> +
> +#
> +# Generic Driver Options
> +#
> +CONFIG_UEVENT_HELPER_PATH=3D"/sbin/hotplug"
> +CONFIG_STANDALONE=3Dy
> +# CONFIG_PREVENT_FIRMWARE_BUILD is not set
> +CONFIG_FW_LOADER=3Dy
> +# CONFIG_FIRMWARE_IN_KERNEL is not set
> +CONFIG_EXTRA_FIRMWARE=3D""
> +# CONFIG_SYS_HYPERVISOR is not set
> +# CONFIG_CONNECTOR is not set
> +CONFIG_MTD=3Dy
> +# CONFIG_MTD_DEBUG is not set
> +# CONFIG_MTD_CONCAT is not set
> +CONFIG_MTD_PARTITIONS=3Dy
> +# CONFIG_MTD_TESTS is not set
> +# CONFIG_MTD_REDBOOT_PARTS is not set
> +# CONFIG_MTD_CMDLINE_PARTS is not set
> +# CONFIG_MTD_OF_PARTS is not set
> +# CONFIG_MTD_AR7_PARTS is not set
> +
> +#
> +# User Modules And Translation Layers
> +#
> +CONFIG_MTD_CHAR=3Dy
> +CONFIG_MTD_BLKDEVS=3Dy
> +CONFIG_MTD_BLOCK=3Dy
> +# CONFIG_FTL is not set
> +# CONFIG_NFTL is not set
> +# CONFIG_INFTL is not set
> +# CONFIG_RFD_FTL is not set
> +# CONFIG_SSFDC is not set
> +# CONFIG_MTD_OOPS is not set
> +
> +#
> +# RAM/ROM/Flash chip drivers
> +#
> +# CONFIG_MTD_CFI is not set
> +# CONFIG_MTD_JEDECPROBE is not set
> +CONFIG_MTD_MAP_BANK_WIDTH_1=3Dy
> +CONFIG_MTD_MAP_BANK_WIDTH_2=3Dy
> +CONFIG_MTD_MAP_BANK_WIDTH_4=3Dy
> +# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
> +# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
> +# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
> +CONFIG_MTD_CFI_I1=3Dy
> +CONFIG_MTD_CFI_I2=3Dy
> +# CONFIG_MTD_CFI_I4 is not set
> +# CONFIG_MTD_CFI_I8 is not set
> +# CONFIG_MTD_RAM is not set
> +# CONFIG_MTD_ROM is not set
> +# CONFIG_MTD_ABSENT is not set
> +
> +#
> +# Mapping drivers for chip access
> +#
> +# CONFIG_MTD_COMPLEX_MAPPINGS is not set
> +# CONFIG_MTD_INTEL_VR_NOR is not set
> +# CONFIG_MTD_PLATRAM is not set
> +
> +#
> +# Self-contained MTD device drivers
> +#
> +# CONFIG_MTD_PMC551 is not set
> +# CONFIG_MTD_SLRAM is not set
> +# CONFIG_MTD_PHRAM is not set
> +# CONFIG_MTD_MTDRAM is not set
> +# CONFIG_MTD_BLOCK2MTD is not set
> +
> +#
> +# Disk-On-Chip Device Drivers
> +#
> +# CONFIG_MTD_DOC2000 is not set
> +# CONFIG_MTD_DOC2001 is not set
> +# CONFIG_MTD_DOC2001PLUS is not set
> +CONFIG_MTD_NAND=3Dy
> +# CONFIG_MTD_NAND_VERIFY_WRITE is not set
> +# CONFIG_MTD_NAND_ECC_SMC is not set
> +# CONFIG_MTD_NAND_MUSEUM_IDS is not set
> +CONFIG_MTD_NAND_IDS=3Dy
> +# CONFIG_MTD_NAND_DISKONCHIP is not set
> +# CONFIG_MTD_NAND_CAFE is not set
> +# CONFIG_MTD_NAND_NANDSIM is not set
> +# CONFIG_MTD_NAND_PLATFORM is not set
> +# CONFIG_MTD_NAND_FSL_ELBC is not set
> +CONFIG_MTD_NAND_MPC5121_NFC=3Dy
> +# CONFIG_MTD_ONENAND is not set
> +
> +#
> +# LPDDR flash memory drivers
> +#
> +# CONFIG_MTD_LPDDR is not set
> +
> +#
> +# UBI - Unsorted block images
> +#
> +CONFIG_MTD_UBI=3Dy
> +CONFIG_MTD_UBI_WL_THRESHOLD=3D4096
> +CONFIG_MTD_UBI_BEB_RESERVE=3D1
> +# CONFIG_MTD_UBI_GLUEBI is not set
> +
> +#
> +# UBI debugging options
> +#
> +# CONFIG_MTD_UBI_DEBUG is not set
> +CONFIG_OF_DEVICE=3Dy
> +CONFIG_OF_I2C=3Dy
> +# CONFIG_PARPORT is not set
> +CONFIG_BLK_DEV=3Dy
> +# CONFIG_BLK_DEV_FD is not set
> +# CONFIG_BLK_CPQ_DA is not set
> +# CONFIG_BLK_CPQ_CISS_DA is not set
> +# CONFIG_BLK_DEV_DAC960 is not set
> +# CONFIG_BLK_DEV_UMEM is not set
> +# CONFIG_BLK_DEV_COW_COMMON is not set
> +# CONFIG_BLK_DEV_LOOP is not set
> +# CONFIG_BLK_DEV_NBD is not set
> +# CONFIG_BLK_DEV_SX8 is not set
> +CONFIG_BLK_DEV_RAM=3Dy
> +CONFIG_BLK_DEV_RAM_COUNT=3D1
> +CONFIG_BLK_DEV_RAM_SIZE=3D8192
> +CONFIG_BLK_DEV_XIP=3Dy
> +# CONFIG_CDROM_PKTCDVD is not set
> +# CONFIG_ATA_OVER_ETH is not set
> +# CONFIG_BLK_DEV_HD is not set
> +CONFIG_MISC_DEVICES=3Dy
> +# CONFIG_PHANTOM is not set
> +# CONFIG_SGI_IOC4 is not set
> +# CONFIG_TIFM_CORE is not set
> +# CONFIG_ICS932S401 is not set
> +# CONFIG_ENCLOSURE_SERVICES is not set
> +# CONFIG_HP_ILO is not set
> +# CONFIG_ISL29003 is not set
> +# CONFIG_C2PORT is not set
> +
> +#
> +# EEPROM support
> +#
> +CONFIG_EEPROM_AT24=3Dy
> +# CONFIG_EEPROM_LEGACY is not set
> +# CONFIG_EEPROM_93CX6 is not set
> +CONFIG_HAVE_IDE=3Dy
> +# CONFIG_IDE is not set
> +
> +#
> +# SCSI device support
> +#
> +# CONFIG_RAID_ATTRS is not set
> +# CONFIG_SCSI is not set
> +# CONFIG_SCSI_DMA is not set
> +# CONFIG_SCSI_NETLINK is not set
> +# CONFIG_ATA is not set
> +# CONFIG_MD is not set
> +# CONFIG_FUSION is not set
> +
> +#
> +# IEEE 1394 (FireWire) support
> +#
> +
> +#
> +# Enable only one of the two stacks, unless you know what you are doing
> +#
> +# CONFIG_FIREWIRE is not set
> +# CONFIG_IEEE1394 is not set
> +# CONFIG_I2O is not set
> +# CONFIG_MACINTOSH_DRIVERS is not set
> +CONFIG_NETDEVICES=3Dy
> +CONFIG_COMPAT_NET_DEV_OPS=3Dy
> +# CONFIG_DUMMY is not set
> +# CONFIG_BONDING is not set
> +# CONFIG_MACVLAN is not set
> +# CONFIG_EQUALIZER is not set
> +# CONFIG_TUN is not set
> +# CONFIG_VETH is not set
> +# CONFIG_ARCNET is not set
> +CONFIG_PHYLIB=3Dy
> +
> +#
> +# MII PHY device drivers
> +#
> +CONFIG_MARVELL_PHY=3Dy
> +CONFIG_DAVICOM_PHY=3Dy
> +CONFIG_QSEMI_PHY=3Dy
> +CONFIG_LXT_PHY=3Dy
> +CONFIG_CICADA_PHY=3Dy
> +CONFIG_VITESSE_PHY=3Dy
> +CONFIG_SMSC_PHY=3Dy
> +CONFIG_BROADCOM_PHY=3Dy
> +CONFIG_ICPLUS_PHY=3Dy
> +CONFIG_REALTEK_PHY=3Dy
> +CONFIG_NATIONAL_PHY=3Dy
> +CONFIG_STE10XP=3Dy
> +CONFIG_LSI_ET1011C_PHY=3Dy
> +CONFIG_FIXED_PHY=3Dy
> +CONFIG_MDIO_BITBANG=3Dy
> +CONFIG_NET_ETHERNET=3Dy
> +CONFIG_MII=3Dy
> +# CONFIG_HAPPYMEAL is not set
> +# CONFIG_SUNGEM is not set
> +# CONFIG_CASSINI is not set
> +# CONFIG_NET_VENDOR_3COM is not set
> +# CONFIG_ETHOC is not set
> +# CONFIG_DNET is not set
> +# CONFIG_NET_TULIP is not set
> +# CONFIG_HP100 is not set
> +# CONFIG_IBM_NEW_EMAC_ZMII is not set
> +# CONFIG_IBM_NEW_EMAC_RGMII is not set
> +# CONFIG_IBM_NEW_EMAC_TAH is not set
> +# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
> +# CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
> +# CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
> +# CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
> +# CONFIG_NET_PCI is not set
> +# CONFIG_B44 is not set
> +# CONFIG_ATL2 is not set
> +CONFIG_FS_ENET=3Dy
> +CONFIG_FS_ENET_MPC5121_FEC=3Dy
> +CONFIG_FS_ENET_FEC_TX_ALIGN_WORKAROUND=3Dy
> +CONFIG_FS_ENET_HAS_FEC=3Dy
> +CONFIG_FS_ENET_MDIO_FEC=3Dy
> +# CONFIG_NETDEV_1000 is not set
> +# CONFIG_NETDEV_10000 is not set
> +# CONFIG_TR is not set
> +
> +#
> +# Wireless LAN
> +#
> +# CONFIG_WLAN_PRE80211 is not set
> +# CONFIG_WLAN_80211 is not set
> +
> +#
> +# Enable WiMAX (Networking options) to see the WiMAX drivers
> +#
> +# CONFIG_WAN is not set
> +# CONFIG_FDDI is not set
> +# CONFIG_HIPPI is not set
> +# CONFIG_PPP is not set
> +# CONFIG_SLIP is not set
> +# CONFIG_NETCONSOLE is not set
> +# CONFIG_NETPOLL is not set
> +# CONFIG_NET_POLL_CONTROLLER is not set
> +# CONFIG_ISDN is not set
> +# CONFIG_PHONE is not set
> +
> +#
> +# Input device support
> +#
> +CONFIG_INPUT=3Dy
> +# CONFIG_INPUT_FF_MEMLESS is not set
> +# CONFIG_INPUT_POLLDEV is not set
> +
> +#
> +# Userland interfaces
> +#
> +CONFIG_INPUT_MOUSEDEV=3Dy
> +# CONFIG_INPUT_MOUSEDEV_PSAUX is not set
> +CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
> +CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
> +# CONFIG_INPUT_JOYDEV is not set
> +# CONFIG_INPUT_EVDEV is not set
> +# CONFIG_INPUT_EVBUG is not set
> +
> +#
> +# Input Device Drivers
> +#
> +# CONFIG_INPUT_KEYBOARD is not set
> +# CONFIG_INPUT_MOUSE is not set
> +# CONFIG_INPUT_JOYSTICK is not set
> +# CONFIG_INPUT_TABLET is not set
> +# CONFIG_INPUT_TOUCHSCREEN is not set
> +# CONFIG_INPUT_MISC is not set
> +
> +#
> +# Hardware I/O ports
> +#
> +# CONFIG_SERIO is not set
> +# CONFIG_GAMEPORT is not set
> +
> +#
> +# Character devices
> +#
> +CONFIG_VT=3Dy
> +CONFIG_CONSOLE_TRANSLATIONS=3Dy
> +CONFIG_VT_CONSOLE=3Dy
> +CONFIG_HW_CONSOLE=3Dy
> +# CONFIG_VT_HW_CONSOLE_BINDING is not set
> +# CONFIG_DEVKMEM is not set
> +# CONFIG_SERIAL_NONSTANDARD is not set
> +# CONFIG_NOZOMI is not set
> +
> +#
> +# Serial drivers
> +#
> +# CONFIG_SERIAL_8250 is not set
> +
> +#
> +# Non-8250 serial port support
> +#
> +# CONFIG_SERIAL_UARTLITE is not set
> +CONFIG_SERIAL_CORE=3Dy
> +CONFIG_SERIAL_CORE_CONSOLE=3Dy
> +CONFIG_SERIAL_MPC52xx=3Dy
> +CONFIG_SERIAL_MPC52xx_CONSOLE=3Dy
> +CONFIG_SERIAL_MPC52xx_CONSOLE_BAUD=3D115200
> +# CONFIG_SERIAL_JSM is not set
> +CONFIG_UNIX98_PTYS=3Dy
> +# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
> +# CONFIG_LEGACY_PTYS is not set
> +# CONFIG_HVC_UDBG is not set
> +# CONFIG_IPMI_HANDLER is not set
> +# CONFIG_HW_RANDOM is not set
> +# CONFIG_NVRAM is not set
> +# CONFIG_R3964 is not set
> +# CONFIG_APPLICOM is not set
> +# CONFIG_RAW_DRIVER is not set
> +# CONFIG_TCG_TPM is not set
> +CONFIG_DEVPORT=3Dy
> +CONFIG_I2C=3Dy
> +CONFIG_I2C_BOARDINFO=3Dy
> +CONFIG_I2C_CHARDEV=3Dy
> +CONFIG_I2C_HELPER_AUTO=3Dy
> +
> +#
> +# I2C Hardware Bus support
> +#
> +
> +#
> +# PC SMBus host controller drivers
> +#
> +# CONFIG_I2C_ALI1535 is not set
> +# CONFIG_I2C_ALI1563 is not set
> +# CONFIG_I2C_ALI15X3 is not set
> +# CONFIG_I2C_AMD756 is not set
> +# CONFIG_I2C_AMD8111 is not set
> +# CONFIG_I2C_I801 is not set
> +# CONFIG_I2C_ISCH is not set
> +# CONFIG_I2C_PIIX4 is not set
> +# CONFIG_I2C_NFORCE2 is not set
> +# CONFIG_I2C_SIS5595 is not set
> +# CONFIG_I2C_SIS630 is not set
> +# CONFIG_I2C_SIS96X is not set
> +# CONFIG_I2C_VIA is not set
> +# CONFIG_I2C_VIAPRO is not set
> +
> +#
> +# I2C system bus drivers (mostly embedded / system-on-chip)
> +#
> +CONFIG_I2C_MPC=3Dy
> +# CONFIG_I2C_OCORES is not set
> +# CONFIG_I2C_SIMTEC is not set
> +
> +#
> +# External I2C/SMBus adapter drivers
> +#
> +# CONFIG_I2C_PARPORT_LIGHT is not set
> +# CONFIG_I2C_TAOS_EVM is not set
> +
> +#
> +# Graphics adapter I2C/DDC channel drivers
> +#
> +# CONFIG_I2C_VOODOO3 is not set
> +
> +#
> +# Other I2C/SMBus bus drivers
> +#
> +# CONFIG_I2C_PCA_PLATFORM is not set
> +# CONFIG_I2C_STUB is not set
> +
> +#
> +# Miscellaneous I2C Chip support
> +#
> +# CONFIG_DS1682 is not set
> +# CONFIG_SENSORS_PCF8574 is not set
> +# CONFIG_PCF8575 is not set
> +# CONFIG_SENSORS_PCA9539 is not set
> +# CONFIG_SENSORS_MAX6875 is not set
> +# CONFIG_SENSORS_TSL2550 is not set
> +# CONFIG_I2C_DEBUG_CORE is not set
> +# CONFIG_I2C_DEBUG_ALGO is not set
> +# CONFIG_I2C_DEBUG_BUS is not set
> +# CONFIG_I2C_DEBUG_CHIP is not set
> +# CONFIG_SPI is not set
> +CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=3Dy
> +# CONFIG_GPIOLIB is not set
> +# CONFIG_W1 is not set
> +# CONFIG_POWER_SUPPLY is not set
> +# CONFIG_HWMON is not set
> +# CONFIG_THERMAL is not set
> +# CONFIG_THERMAL_HWMON is not set
> +# CONFIG_WATCHDOG is not set
> +CONFIG_SSB_POSSIBLE=3Dy
> +
> +#
> +# Sonics Silicon Backplane
> +#
> +# CONFIG_SSB is not set
> +
> +#
> +# Multifunction device drivers
> +#
> +# CONFIG_MFD_CORE is not set
> +# CONFIG_MFD_SM501 is not set
> +# CONFIG_HTC_PASIC3 is not set
> +# CONFIG_TWL4030_CORE is not set
> +# CONFIG_MFD_TMIO is not set
> +# CONFIG_PMIC_DA903X is not set
> +# CONFIG_MFD_WM8400 is not set
> +# CONFIG_MFD_WM8350_I2C is not set
> +# CONFIG_MFD_PCF50633 is not set
> +# CONFIG_REGULATOR is not set
> +
> +#
> +# Multimedia devices
> +#
> +
> +#
> +# Multimedia core support
> +#
> +# CONFIG_VIDEO_DEV is not set
> +# CONFIG_DVB_CORE is not set
> +# CONFIG_VIDEO_MEDIA is not set
> +
> +#
> +# Multimedia drivers
> +#
> +# CONFIG_DAB is not set
> +
> +#
> +# Graphics support
> +#
> +# CONFIG_AGP is not set
> +# CONFIG_DRM is not set
> +# CONFIG_VGASTATE is not set
> +# CONFIG_VIDEO_OUTPUT_CONTROL is not set
> +# CONFIG_FB is not set
> +# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
> +
> +#
> +# Display device support
> +#
> +# CONFIG_DISPLAY_SUPPORT is not set
> +
> +#
> +# Console display driver support
> +#
> +# CONFIG_VGA_CONSOLE is not set
> +CONFIG_DUMMY_CONSOLE=3Dy
> +# CONFIG_SOUND is not set
> +# CONFIG_HID_SUPPORT is not set
> +# CONFIG_USB_SUPPORT is not set
> +# CONFIG_UWB is not set
> +# CONFIG_MMC is not set
> +# CONFIG_MEMSTICK is not set
> +# CONFIG_NEW_LEDS is not set
> +# CONFIG_ACCESSIBILITY is not set
> +# CONFIG_INFINIBAND is not set
> +# CONFIG_EDAC is not set
> +CONFIG_RTC_LIB=3Dy
> +CONFIG_RTC_CLASS=3Dy
> +CONFIG_RTC_HCTOSYS=3Dy
> +CONFIG_RTC_HCTOSYS_DEVICE=3D"rtc1"
> +# CONFIG_RTC_DEBUG is not set
> +
> +#
> +# RTC interfaces
> +#
> +CONFIG_RTC_INTF_SYSFS=3Dy
> +CONFIG_RTC_INTF_PROC=3Dy
> +CONFIG_RTC_INTF_DEV=3Dy
> +# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
> +# CONFIG_RTC_DRV_TEST is not set
> +
> +#
> +# I2C RTC drivers
> +#
> +# CONFIG_RTC_DRV_DS1307 is not set
> +# CONFIG_RTC_DRV_DS1374 is not set
> +# CONFIG_RTC_DRV_DS1672 is not set
> +# CONFIG_RTC_DRV_MAX6900 is not set
> +# CONFIG_RTC_DRV_RS5C372 is not set
> +# CONFIG_RTC_DRV_ISL1208 is not set
> +# CONFIG_RTC_DRV_X1205 is not set
> +# CONFIG_RTC_DRV_PCF8563 is not set
> +# CONFIG_RTC_DRV_PCF8583 is not set
> +CONFIG_RTC_DRV_M41T80=3Dy
> +# CONFIG_RTC_DRV_M41T80_WDT is not set
> +# CONFIG_RTC_DRV_S35390A is not set
> +# CONFIG_RTC_DRV_FM3130 is not set
> +# CONFIG_RTC_DRV_RX8581 is not set
> +
> +#
> +# SPI RTC drivers
> +#
> +
> +#
> +# Platform RTC drivers
> +#
> +# CONFIG_RTC_DRV_CMOS is not set
> +# CONFIG_RTC_DRV_DS1286 is not set
> +# CONFIG_RTC_DRV_DS1511 is not set
> +# CONFIG_RTC_DRV_DS1553 is not set
> +# CONFIG_RTC_DRV_DS1742 is not set
> +# CONFIG_RTC_DRV_STK17TA8 is not set
> +# CONFIG_RTC_DRV_M48T86 is not set
> +# CONFIG_RTC_DRV_M48T35 is not set
> +# CONFIG_RTC_DRV_M48T59 is not set
> +# CONFIG_RTC_DRV_BQ4802 is not set
> +# CONFIG_RTC_DRV_V3020 is not set
> +
> +#
> +# on-CPU RTC drivers
> +#
> +# CONFIG_RTC_DRV_GENERIC is not set
> +CONFIG_RTC_DRV_MPC5121=3Dy
> +CONFIG_DMADEVICES=3Dy
> +
> +#
> +# DMA Devices
> +#
> +# CONFIG_FSL_DMA is not set
> +CONFIG_MPC512X_DMA=3Dy
> +CONFIG_DMA_ENGINE=3Dy
> +
> +#
> +# DMA Clients
> +#
> +# CONFIG_NET_DMA is not set
> +# CONFIG_ASYNC_TX_DMA is not set
> +CONFIG_DMATEST=3Dm
> +# CONFIG_AUXDISPLAY is not set
> +# CONFIG_UIO is not set
> +# CONFIG_STAGING is not set
> +
> +#
> +# File systems
> +#
> +CONFIG_EXT2_FS=3Dy
> +# CONFIG_EXT2_FS_XATTR is not set
> +CONFIG_EXT2_FS_XIP=3Dy
> +# CONFIG_EXT3_FS is not set
> +# CONFIG_EXT4_FS is not set
> +CONFIG_FS_XIP=3Dy
> +# CONFIG_REISERFS_FS is not set
> +# CONFIG_JFS_FS is not set
> +# CONFIG_FS_POSIX_ACL is not set
> +CONFIG_FILE_LOCKING=3Dy
> +# CONFIG_XFS_FS is not set
> +# CONFIG_OCFS2_FS is not set
> +# CONFIG_BTRFS_FS is not set
> +# CONFIG_DNOTIFY is not set
> +# CONFIG_INOTIFY is not set
> +# CONFIG_QUOTA is not set
> +# CONFIG_AUTOFS_FS is not set
> +# CONFIG_AUTOFS4_FS is not set
> +# CONFIG_FUSE_FS is not set
> +
> +#
> +# Caches
> +#
> +# CONFIG_FSCACHE is not set
> +
> +#
> +# CD-ROM/DVD Filesystems
> +#
> +# CONFIG_ISO9660_FS is not set
> +# CONFIG_UDF_FS is not set
> +
> +#
> +# DOS/FAT/NT Filesystems
> +#
> +# CONFIG_MSDOS_FS is not set
> +# CONFIG_VFAT_FS is not set
> +# CONFIG_NTFS_FS is not set
> +
> +#
> +# Pseudo filesystems
> +#
> +CONFIG_PROC_FS=3Dy
> +# CONFIG_PROC_KCORE is not set
> +CONFIG_PROC_SYSCTL=3Dy
> +CONFIG_PROC_PAGE_MONITOR=3Dy
> +CONFIG_SYSFS=3Dy
> +CONFIG_TMPFS=3Dy
> +# CONFIG_TMPFS_POSIX_ACL is not set
> +# CONFIG_HUGETLB_PAGE is not set
> +# CONFIG_CONFIGFS_FS is not set
> +CONFIG_MISC_FILESYSTEMS=3Dy
> +# CONFIG_ADFS_FS is not set
> +# CONFIG_AFFS_FS is not set
> +# CONFIG_HFS_FS is not set
> +# CONFIG_HFSPLUS_FS is not set
> +# CONFIG_BEFS_FS is not set
> +# CONFIG_BFS_FS is not set
> +# CONFIG_EFS_FS is not set
> +CONFIG_JFFS2_FS=3Dy
> +CONFIG_JFFS2_FS_DEBUG=3D0
> +CONFIG_JFFS2_FS_WRITEBUFFER=3Dy
> +# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
> +# CONFIG_JFFS2_SUMMARY is not set
> +# CONFIG_JFFS2_FS_XATTR is not set
> +# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
> +CONFIG_JFFS2_ZLIB=3Dy
> +# CONFIG_JFFS2_LZO is not set
> +CONFIG_JFFS2_RTIME=3Dy
> +# CONFIG_JFFS2_RUBIN is not set
> +CONFIG_UBIFS_FS=3Dy
> +# CONFIG_UBIFS_FS_XATTR is not set
> +# CONFIG_UBIFS_FS_ADVANCED_COMPR is not set
> +CONFIG_UBIFS_FS_LZO=3Dy
> +CONFIG_UBIFS_FS_ZLIB=3Dy
> +# CONFIG_UBIFS_FS_DEBUG is not set
> +# CONFIG_CRAMFS is not set
> +# CONFIG_SQUASHFS is not set
> +# CONFIG_VXFS_FS is not set
> +# CONFIG_MINIX_FS is not set
> +# CONFIG_OMFS_FS is not set
> +# CONFIG_HPFS_FS is not set
> +# CONFIG_QNX4FS_FS is not set
> +# CONFIG_ROMFS_FS is not set
> +# CONFIG_SYSV_FS is not set
> +# CONFIG_UFS_FS is not set
> +# CONFIG_NILFS2_FS is not set
> +CONFIG_NETWORK_FILESYSTEMS=3Dy
> +CONFIG_NFS_FS=3Dy
> +CONFIG_NFS_V3=3Dy
> +# CONFIG_NFS_V3_ACL is not set
> +# CONFIG_NFS_V4 is not set
> +CONFIG_ROOT_NFS=3Dy
> +# CONFIG_NFSD is not set
> +CONFIG_LOCKD=3Dy
> +CONFIG_LOCKD_V4=3Dy
> +CONFIG_NFS_COMMON=3Dy
> +CONFIG_SUNRPC=3Dy
> +# CONFIG_RPCSEC_GSS_KRB5 is not set
> +# CONFIG_RPCSEC_GSS_SPKM3 is not set
> +# CONFIG_SMB_FS is not set
> +# CONFIG_CIFS is not set
> +# CONFIG_NCP_FS is not set
> +# CONFIG_CODA_FS is not set
> +# CONFIG_AFS_FS is not set
> +
> +#
> +# Partition Types
> +#
> +# CONFIG_PARTITION_ADVANCED is not set
> +CONFIG_MSDOS_PARTITION=3Dy
> +# CONFIG_NLS is not set
> +# CONFIG_DLM is not set
> +# CONFIG_BINARY_PRINTF is not set
> +
> +#
> +# Library routines
> +#
> +CONFIG_BITREVERSE=3Dy
> +CONFIG_GENERIC_FIND_LAST_BIT=3Dy
> +# CONFIG_CRC_CCITT is not set
> +CONFIG_CRC16=3Dy
> +# CONFIG_CRC_T10DIF is not set
> +# CONFIG_CRC_ITU_T is not set
> +CONFIG_CRC32=3Dy
> +# CONFIG_CRC7 is not set
> +# CONFIG_LIBCRC32C is not set
> +CONFIG_ZLIB_INFLATE=3Dy
> +CONFIG_ZLIB_DEFLATE=3Dy
> +CONFIG_LZO_COMPRESS=3Dy
> +CONFIG_LZO_DECOMPRESS=3Dy
> +CONFIG_DECOMPRESS_GZIP=3Dy
> +CONFIG_DECOMPRESS_BZIP2=3Dy
> +CONFIG_DECOMPRESS_LZMA=3Dy
> +CONFIG_HAS_IOMEM=3Dy
> +CONFIG_HAS_IOPORT=3Dy
> +CONFIG_HAS_DMA=3Dy
> +CONFIG_HAVE_LMB=3Dy
> +CONFIG_NLATTR=3Dy
> +
> +#
> +# Kernel hacking
> +#
> +# CONFIG_PRINTK_TIME is not set
> +# CONFIG_ENABLE_WARN_DEPRECATED is not set
> +# CONFIG_ENABLE_MUST_CHECK is not set
> +CONFIG_FRAME_WARN=3D1024
> +# CONFIG_MAGIC_SYSRQ is not set
> +# CONFIG_UNUSED_SYMBOLS is not set
> +# CONFIG_DEBUG_FS is not set
> +# CONFIG_HEADERS_CHECK is not set
> +# CONFIG_DEBUG_KERNEL is not set
> +CONFIG_DEBUG_BUGVERBOSE=3Dy
> +CONFIG_DEBUG_MEMORY_INIT=3Dy
> +# CONFIG_RCU_CPU_STALL_DETECTOR is not set
> +# CONFIG_LATENCYTOP is not set
> +# CONFIG_SYSCTL_SYSCALL_CHECK is not set
> +CONFIG_HAVE_FUNCTION_TRACER=3Dy
> +CONFIG_HAVE_FUNCTION_GRAPH_TRACER=3Dy
> +CONFIG_HAVE_DYNAMIC_FTRACE=3Dy
> +CONFIG_HAVE_FTRACE_MCOUNT_RECORD=3Dy
> +CONFIG_TRACING_SUPPORT=3Dy
> +
> +#
> +# Tracers
> +#
> +# CONFIG_FUNCTION_TRACER is not set
> +# CONFIG_SCHED_TRACER is not set
> +# CONFIG_CONTEXT_SWITCH_TRACER is not set
> +# CONFIG_EVENT_TRACER is not set
> +# CONFIG_BOOT_TRACER is not set
> +# CONFIG_TRACE_BRANCH_PROFILING is not set
> +# CONFIG_STACK_TRACER is not set
> +# CONFIG_KMEMTRACE is not set
> +# CONFIG_WORKQUEUE_TRACER is not set
> +# CONFIG_BLK_DEV_IO_TRACE is not set
> +# CONFIG_SAMPLES is not set
> +CONFIG_HAVE_ARCH_KGDB=3Dy
> +CONFIG_PRINT_STACK_DEPTH=3D64
> +# CONFIG_IRQSTACKS is not set
> +# CONFIG_BOOTX_TEXT is not set
> +# CONFIG_PPC_EARLY_DEBUG is not set
> +
> +#
> +# Security options
> +#
> +# CONFIG_KEYS is not set
> +# CONFIG_SECURITY is not set
> +# CONFIG_SECURITYFS is not set
> +# CONFIG_SECURITY_FILE_CAPABILITIES is not set
> +CONFIG_CRYPTO=3Dy
> +
> +#
> +# Crypto core or helper
> +#
> +# CONFIG_CRYPTO_FIPS is not set
> +CONFIG_CRYPTO_ALGAPI=3Dy
> +CONFIG_CRYPTO_ALGAPI2=3Dy
> +# CONFIG_CRYPTO_MANAGER is not set
> +# CONFIG_CRYPTO_MANAGER2 is not set
> +# CONFIG_CRYPTO_GF128MUL is not set
> +# CONFIG_CRYPTO_NULL is not set
> +# CONFIG_CRYPTO_CRYPTD is not set
> +# CONFIG_CRYPTO_AUTHENC is not set
> +# CONFIG_CRYPTO_TEST is not set
> +
> +#
> +# Authenticated Encryption with Associated Data
> +#
> +# CONFIG_CRYPTO_CCM is not set
> +# CONFIG_CRYPTO_GCM is not set
> +# CONFIG_CRYPTO_SEQIV is not set
> +
> +#
> +# Block modes
> +#
> +# CONFIG_CRYPTO_CBC is not set
> +# CONFIG_CRYPTO_CTR is not set
> +# CONFIG_CRYPTO_CTS is not set
> +# CONFIG_CRYPTO_ECB is not set
> +# CONFIG_CRYPTO_LRW is not set
> +# CONFIG_CRYPTO_PCBC is not set
> +# CONFIG_CRYPTO_XTS is not set
> +
> +#
> +# Hash modes
> +#
> +# CONFIG_CRYPTO_HMAC is not set
> +# CONFIG_CRYPTO_XCBC is not set
> +
> +#
> +# Digest
> +#
> +# CONFIG_CRYPTO_CRC32C is not set
> +# CONFIG_CRYPTO_MD4 is not set
> +# CONFIG_CRYPTO_MD5 is not set
> +# CONFIG_CRYPTO_MICHAEL_MIC is not set
> +# CONFIG_CRYPTO_RMD128 is not set
> +# CONFIG_CRYPTO_RMD160 is not set
> +# CONFIG_CRYPTO_RMD256 is not set
> +# CONFIG_CRYPTO_RMD320 is not set
> +# CONFIG_CRYPTO_SHA1 is not set
> +# CONFIG_CRYPTO_SHA256 is not set
> +# CONFIG_CRYPTO_SHA512 is not set
> +# CONFIG_CRYPTO_TGR192 is not set
> +# CONFIG_CRYPTO_WP512 is not set
> +
> +#
> +# Ciphers
> +#
> +# CONFIG_CRYPTO_AES is not set
> +# CONFIG_CRYPTO_ANUBIS is not set
> +# CONFIG_CRYPTO_ARC4 is not set
> +# CONFIG_CRYPTO_BLOWFISH is not set
> +# CONFIG_CRYPTO_CAMELLIA is not set
> +# CONFIG_CRYPTO_CAST5 is not set
> +# CONFIG_CRYPTO_CAST6 is not set
> +# CONFIG_CRYPTO_DES is not set
> +# CONFIG_CRYPTO_FCRYPT is not set
> +# CONFIG_CRYPTO_KHAZAD is not set
> +# CONFIG_CRYPTO_SALSA20 is not set
> +# CONFIG_CRYPTO_SEED is not set
> +# CONFIG_CRYPTO_SERPENT is not set
> +# CONFIG_CRYPTO_TEA is not set
> +# CONFIG_CRYPTO_TWOFISH is not set
> +
> +#
> +# Compression
> +#
> +CONFIG_CRYPTO_DEFLATE=3Dy
> +# CONFIG_CRYPTO_ZLIB is not set
> +CONFIG_CRYPTO_LZO=3Dy
> +
> +#
> +# Random Number Generation
> +#
> +# CONFIG_CRYPTO_ANSI_CPRNG is not set
> +# CONFIG_CRYPTO_HW is not set
> +CONFIG_PPC_CLOCK=3Dy
> +# CONFIG_VIRTUALIZATION is not set
> --
> 1.6.0.6
>
>



--=20
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
