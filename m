Return-Path: <s1seetee@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tz00Y00lhzDqGp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 17:51:08 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 v0B6n4hX106350
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 01:51:06 -0500
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27w8ru7bh2-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 11 Jan 2017 01:51:06 -0500
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <s1seetee@linux.vnet.ibm.com>;
 Tue, 10 Jan 2017 23:51:05 -0700
Subject: Re: WARNING at fs/sysfs/group.c:237 .sysfs_remove_group+0xc4/0xd0 on
 Linus mainline
To: abdul <abdhalee@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
References: <dea4763b-e2e2-75b9-7e88-ec0e9bced266@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, mpe@ellerman.id.au
From: seeteena <s1seetee@linux.vnet.ibm.com>
Date: Wed, 11 Jan 2017 12:20:57 +0530
MIME-Version: 1.0
In-Reply-To: <dea4763b-e2e2-75b9-7e88-ec0e9bced266@linux.vnet.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <90351df2-c57b-42d9-21a2-62fbe3d0cd1f@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi , Let me know if the below community fix is been merged into upstream 
code.

https://www.mail-archive.com/linux-scsi@vger.kernel.org/msg39187.html

Thanks

Seeteena


On 01/11/2017 12:14 PM, abdul wrote:
> Hi
>
> Today's mainline shows warning while load/unload lpfc module on PowerPC
>
> Machine : Power8 PowerVM LPAR
> Kernel version : 4.10.0-rc3
>
> Steps to recreate:
> modprobe lpfc
> mpdprobe -r lpfc
>
> ------------[ cut here ]------------
> WARNING: CPU: 3 PID: 3819 at fs/sysfs/group.c:237 
> .sysfs_remove_group+0xc4/0xd0
> Modules linked in: dm_snapshot(E) dm_bufio(E) ext4(E) mbcache(E) 
> jbd2(E) ip6t_rpfilter(E) ipt_REJECT(E) nf_reject_ipv4(E) 
> ip6t_REJECT(E) nf_reject_ipv6(E) xt_conntrack(E) ip_set(E) 
> nfnetlink(E) ebtable_nat(E) ebtable_broute(E) bridge(E) stp(E) llc(E) 
> ip6table_nat(E) nf_conntrack_ipv6(E) nf_defrag_ipv6(E) nf_nat_ipv6(E) 
> ip6table_mangle(E) ip6table_security(E) ip6table_raw(E) iptable_nat(E) 
> nf_conntrack_ipv4(E) nf_defrag_ipv4(E) nf_nat_ipv4(E) nf_nat(E) 
> nf_conntrack(E) iptable_mangle(E) iptable_security(E) iptable_raw(E) 
> ebtable_filter(E) ebtables(E) ip6table_filter(E) ip6_tables(E) 
> iptable_filter(E) rpcrdma(E) sunrpc(E) ib_isert(E) iscsi_target_mod(E) 
> ib_iser(E) libiscsi(E) scsi_transport_iscsi(E) ib_srpt(E) 
> target_core_mod(E) ib_srp(E) ib_ipoib(E) rdma_ucm(E) ib_ucm(E) 
> ib_uverbs(E) ib_umad(E)
> rdma_cm(E) ib_cm(E) iw_cm(E) iw_cxgb4(E) ib_core(E) libcxgb(E) 
> nls_utf8(E) isofs(E) loop(E) dm_mirror(E) dm_region_hash(E) dm_log(E) 
> sg(E) pseries_rng(E) ghash_generic(E) shpchp(E) xts(E) gf128mul(E) 
> vmx_crypto(E) dm_multipath(E) dm_mod(E) ip_tables(E) xfs(E) 
> libcrc32c(E) sr_mod(E) cdrom(E) sd_mod(E) ibmvscsi(E) 
> scsi_transport_srp(E) ibmveth(E) lpfc(E-) cxgb4(E) scsi_transport_fc(E)
> CPU: 3 PID: 3819 Comm: rmmod Tainted: G            E 
> 4.10.0-rc3-autotest #1
> task: c000000002404200 task.stack: c000000158868000
> NIP: c00000000038f074 LR: c00000000038f070 CTR: 00000000006338e4
> REGS: c00000015886b1c0 TRAP: 0700   Tainted: G E (4.10.0-rc3-autotest)
> MSR: 800000000282b032 <SF,VEC,VSX,EE,FP,ME,IR,DR,RI>
> CR: 22008822  XER: 00000004
> CFAR: c0000000008a9510 SOFTE: 1
> GPR00: c00000000038f070 c00000015886b440 c0000000011faa00 
> 0000000000000033
> GPR04: c00000028fbcada0 c00000028fbdf628 0000000002ab5b98 
> 0000000000000000
> GPR08: 0000000000000000 c000000000c9f41c 000000028ef30000 
> 000000000000026d
> GPR12: 0000000022008844 c00000000e7f1b00 0000000000000000 
> 0000000000000000
> GPR16: 0000000000000000 0000000000000000 000001000e7e01d0 
> 000000001001f8e0
> GPR20: 000000001001f898 000000001001f880 000000001001f8c0 
> 000000001001f8f8
> GPR24: 0000000000000000 c000000002a011d8 c0000001890270b0 
> c00000000110f1f0
> GPR28: c0000000fe81b188 c000000189027010 c000000001128c50 
> 0000000000000000
> NIP [c00000000038f074] .sysfs_remove_group+0xc4/0xd0
> LR [c00000000038f070] .sysfs_remove_group+0xc0/0xd0
> Call Trace:
> [c00000015886b440] [c00000000038f070] .sysfs_remove_group+0xc0/0xd0 
> (unreliable)
> [c00000015886b4d0] [c000000000592950] .dpm_sysfs_remove+0x70/0x90
> [c00000015886b560] [c00000000057ea6c] .device_del+0x12c/0x3b0
> [c00000015886b610] [c00000000057ed10] .device_unregister+0x20/0x90
> [c00000015886b690] [c000000000452a28] .bsg_unregister_queue+0x78/0x110
> [c00000015886b720] [c0000000005d130c] .__scsi_remove_device+0xfc/0x130
> [c00000015886b7a0] [c0000000005ce934] .scsi_forget_host+0x94/0xa0
> [c00000015886b820] [c0000000005beac4] .scsi_remove_host+0x94/0x1a0
> [c00000015886b8b0] [d0000000031e2f14] 
> .lpfc_sli4_queue_destroy+0xb94/0x1000 [lpfc]
> [c00000015886b980] [c0000000004d1b70] .pci_device_remove+0x60/0x100
> [c00000015886ba10] [c0000000005859f8] 
> .device_release_driver_internal+0x1e8/0x2b0
> [c00000015886bab0] [c000000000585b3c] .driver_detach+0x6c/0xf0
> [c00000015886bb40] [c0000000005840e4] .bus_remove_driver+0x74/0x130
> [c00000015886bbc0] [c0000000005867d8] .driver_unregister+0x38/0x70
> [c00000015886bc40] [c0000000004cf4a4] .pci_unregister_driver+0x34/0x120
> [c00000015886bce0] [d000000003215d64] .cleanup_module+0x34/0x6fa0 [lpfc]
> [c00000015886bd60] [c0000000001784f4] .SyS_delete_module+0x1e4/0x280
> [c00000015886be30] [c00000000000b184] system_call+0x38/0xe0
> Instruction dump:
> 4e800020 60000000 60000000 4bff93b1 60000000 4bffffa0 e89e0000 e8bd0000
> 3c62ff93 3863d598 4851a445 60000000 <0fe00000> 4bffffb4 60000000 7c0802a6
> ---[ end trace 8eb607cc8c5cea78 ]---
> sysfs group 'power' not found for kobject '2:0:0:0'
>
> Thanks
> Abdul
