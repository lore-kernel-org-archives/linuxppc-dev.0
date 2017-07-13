Return-Path: <gromero@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x7dv40KslzDqk3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 14 Jul 2017 00:46:55 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6DEimgr029300
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 10:46:53 -0400
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bnt3qv9e6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 10:46:53 -0400
Received: from localhost
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gromero@linux.vnet.ibm.com>;
 Thu, 13 Jul 2017 11:46:50 -0300
Received: from d24av01.br.ibm.com (d24av01.br.ibm.com [9.8.31.91])
 by d24relay03.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6DEgPqO25493546
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 11:42:25 -0300
Received: from d24av01.br.ibm.com (localhost [127.0.0.1])
 by d24av01.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6DEklie013920
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Jul 2017 11:46:47 -0300
Subject: Re: [bug] KVM: Unrecoverable TM Unavailable Exception f60
To: Jan Stancek <jstancek@redhat.com>, linuxppc-dev@lists.ozlabs.org
References: <1184529176.51045609.1499943136316.JavaMail.zimbra@redhat.com>
 <295894956.51100272.1499947620915.JavaMail.zimbra@redhat.com>
Cc: David Gibson <dgibson@redhat.com>, thuth@redhat.com,
 Laurent Vivier <lvivier@redhat.com>, Steve Best <sbest@redhat.com>
From: Gustavo Romero <gromero@linux.vnet.ibm.com>
Date: Thu, 13 Jul 2017 11:46:45 -0300
MIME-Version: 1.0
In-Reply-To: <295894956.51100272.1499947620915.JavaMail.zimbra@redhat.com>
Content-Type: text/plain; charset=utf-8
Message-Id: <596787D5.7000704@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Jan

On 13-07-2017 09:07, Jan Stancek wrote:
>> [  181.328511] Unrecoverable TM Unavailable Exception f60 at d00000001e7d9980
>> [  181.328605] Oops: Unrecoverable TM Unavailable Exception, sig: 6 [#1]
>> [  181.328613] SMP NR_CPUS=2048
>> [  181.328613] NUMA
>> [  181.328618] PowerNV
>> [  181.328646] Modules linked in: vhost_net vhost tap nfs_layout_nfsv41_files
>> rpcsec_gss_krb5 nfsv4 dns_resolver nfs fscache xt_CHECKSUM iptable_mangle
>> ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat
>> nf_conntrack_ipv4 nf_defrag_ipv4 xt_conntrack nf_conntrack ipt_REJECT
>> nf_reject_ipv4 tun ebtable_filter ebtables ip6table_filter ip6_tables
>> iptable_filter bridge stp llc kvm_hv kvm nfsd ses enclosure
>> scsi_transport_sas ghash_generic auth_rpcgss gf128mul xts sg ctr nfs_acl
>> lockd vmx_crypto shpchp ipmi_powernv i2c_opal grace ipmi_devintf i2c_core
>> powernv_rng sunrpc ipmi_msghandler ibmpowernv uio_pdrv_genirq uio
>> leds_powernv powernv_op_panel ip_tables xfs sd_mod lpfc ipr bnx2x libata
>> mdio ptp pps_core scsi_transport_fc libcrc32c dm_mirror dm_region_hash
>> dm_log dm_mod
>> [  181.329278] CPU: 40 PID: 9926 Comm: CPU 0/KVM Not tainted 4.12.0+ #1
>> [  181.329337] task: c000003fc6980000 task.stack: c000003fe4d80000
>> [  181.329396] NIP: d00000001e7d9980 LR: d00000001e77381c CTR:
>> d00000001e7d98f0
>> [  181.329465] REGS: c000003fe4d837e0 TRAP: 0f60   Not tainted  (4.12.0+)
>> [  181.329523] MSR: 9000000000009033 <SF,HV,EE,ME,IR,DR,RI,LE>
>> [  181.329527]   CR: 24022448  XER: 00000000
>> [  181.329608] CFAR: d00000001e773818 SOFTE: 1
>> [  181.329608] GPR00: d00000001e77381c c000003fe4d83a60 d00000001e7ef410
>> c000003fdcfe0000
>> [  181.329608] GPR04: c000003fe4f00000 0000000000000000 0000000000000000
>> c000003fd7954800
>> [  181.329608] GPR08: 0000000000000001 c000003fc6980000 0000000000000000
>> d00000001e7e2880
>> [  181.329608] GPR12: d00000001e7d98f0 c000000007b19000 00000001295220e0
>> 00007fffc0ce2090
>> [  181.329608] GPR16: 0000010011886608 00007fff8c89f260 0000000000000001
>> 00007fff8c080028
>> [  181.329608] GPR20: 0000000000000000 00000100118500a6 0000010011850000
>> 0000010011850000
>> [  181.329608] GPR24: 00007fffc0ce1b48 0000010011850000 00000000d673b901
>> 0000000000000000
>> [  181.329608] GPR28: 0000000000000000 c000003fdcfe0000 c000003fdcfe0000
>> c000003fe4f00000
>> [  181.330199] NIP [d00000001e7d9980] kvmppc_vcpu_run_hv+0x90/0x6b0 [kvm_hv]
>> [  181.330264] LR [d00000001e77381c] kvmppc_vcpu_run+0x2c/0x40 [kvm]
>> [  181.330322] Call Trace:
>> [  181.330351] [c000003fe4d83a60] [d00000001e773478]
>> kvmppc_set_one_reg+0x48/0x340 [kvm] (unreliable)
>> [  181.330437] [c000003fe4d83b30] [d00000001e77381c]
>> kvmppc_vcpu_run+0x2c/0x40 [kvm]
>> [  181.330513] [c000003fe4d83b50] [d00000001e7700b4]
>> kvm_arch_vcpu_ioctl_run+0x114/0x2a0 [kvm]
>> [  181.330586] [c000003fe4d83bd0] [d00000001e7642f8]
>> kvm_vcpu_ioctl+0x598/0x7a0 [kvm]
>> [  181.330658] [c000003fe4d83d40] [c0000000003451b8] do_vfs_ioctl+0xc8/0x8b0
>> [  181.330717] [c000003fe4d83de0] [c000000000345a64] SyS_ioctl+0xc4/0x120
>> [  181.330776] [c000003fe4d83e30] [c00000000000b004] system_call+0x58/0x6c
>> [  181.330833] Instruction dump:
>> [  181.330869] e92d0260 e9290b50 e9290108 792807e3 41820058 e92d0260 e9290b50
>> e9290108
>> [  181.330941] 792ae8a4 794a1f87 408204f4 e92d0260 <7d4022a6> f9490ff0
>> e92d0260 7d4122a6
>> [  181.331013] ---[ end trace 6f6ddeb4bfe92a92 ]---
>> [  181.334574]
>> [  183.334758] Kernel panic - not syncing: Fatal exception
>> [  183.338352] Rebooting in 10 seconds..


Looks like that TM unavailable exception will only able to recover
properly if it comes from problem state and since the trigger comes
from kernel space (kvm module) it does not match
"if (user_mode(regs))" in tm_unavailable().

I'm able to avoid this problem using the following patch:

diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index d4e545d27ef9..1091dc4f4274 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1433,13 +1433,11 @@ void vsx_unavailable_exception(struct pt_regs *regs)
 static void tm_unavailable(struct pt_regs *regs)
 {
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
-       if (user_mode(regs)) {
-               current->thread.load_tm++;
-               regs->msr |= MSR_TM;
-               tm_enable();
-               tm_restore_sprs(&current->thread);
-               return;
-       }
+       current->thread.load_tm++;
+       regs->msr |= MSR_TM;
+       tm_enable();
+       tm_restore_sprs(&current->thread);
+       return;
 #endif
        pr_emerg("Unrecoverable TM Unavailable Exception "
                        "%lx at %lx\n", regs->trap, regs->nip);

Regards,
Gustavo
