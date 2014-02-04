Return-Path: <cascardo@linux.vnet.ibm.com>
Received: from e24smtp01.br.ibm.com (e24smtp01.br.ibm.com [32.104.18.85])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 73FB72C0079
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Feb 2014 02:59:38 +1100 (EST)
Received: from /spool/local
 by e24smtp01.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cascardo@linux.vnet.ibm.com>;
 Tue, 4 Feb 2014 13:59:32 -0200
Received: from d24relay02.br.ibm.com (d24relay02.br.ibm.com [9.13.184.26])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id EA0D53520066
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Feb 2014 10:59:26 -0500 (EST)
Received: from d24av03.br.ibm.com (d24av03.br.ibm.com [9.8.31.95])
 by d24relay02.br.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s14FwnCm50724880
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Feb 2014 13:58:50 -0200
Received: from d24av03.br.ibm.com (localhost [127.0.0.1])
 by d24av03.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s14FxRmo002334
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Feb 2014 13:59:27 -0200
Date: Tue, 4 Feb 2014 13:59:21 -0200
From: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
To: John Donnelly <john.d@servergy.com>
Subject: Re: Oops on shutdown : 3.11.0-5-powerpc-e500mc Ubuntu
Message-ID: <20140204155921.GA31582@oc0268524204.ibm.com>
References: <CAGtOQbSJeJ85Nj-M2XB+w3p5+PTVWrpsFKZqCbEqZYkwsa0GGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAGtOQbSJeJ85Nj-M2XB+w3p5+PTVWrpsFKZqCbEqZYkwsa0GGg@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 04, 2014 at 08:47:14AM -0600, John Donnelly wrote:
> Hi,
>  Where is a appropriate place to file a bug for this : This is the second
> occurrence I have seen.
> 

If this is a Ubuntu kernel, probably report it at Canonical's Launchpad.
If it is provided by Freescale, report it to Freescale.
If you can run a mainline kernel (best now would be 3.14-rc1) and
reproduce that, then best place would be linux-nfs@vger.kernel.org.

Hope that helps.
Cascardo.

> 
> 
> saucy)root@(none):/work/svy/tools#  * Stopping MD monitoring service mdadm
> --monitor
>  [ OK ]
>  * Asking all remaining processes to terminate...                        [
> OK ]
>  * All processes ended within 1 seconds...                               [
> OK ]
> [65426.692405] Oops: Exception in kernel mode, sig: 11 [#1]
> [65426.697721] SMP NR_CPUS=8 P4080 DS
> [65426.701122] Modules linked in: btrfs(F) raid6_pq(F) zlib_deflate(F)
> xor(F) ufs(F) qnx4(F) hfsplus(F) hfs(F) minix(F) ntfs(F) msdos(F) jfs(F)
> xfs(F) libcrc32c(F) reiserfs(F) nls_iso8859_1(F) nls_cp437(F) vfat(F)
> fat(F) dm_multipath(F) scsi_dh(F) usb_storage(F) ext2(F) rpcsec_gss_krb5(F)
> nfsv4(F) nfsd(F) auth_rpcgss(F) nfs_acl(F) nfs(F) lockd(F) sunrpc(F)
> fscache(F) ofpart(F) redboot(F) cmdlinepart(F) cfi_cmdset_0002(F)
> cfi_probe(F) cfi_util(F) gen_probe(F) physmap_of(F) map_funcs(F) chipreg(F)
> mtd(F) lm90(F) at24(F) caam(F) i2c_mpc(F) mpc85xx_edac(F) edac_core(F)
> uio_pdrv_genirq(F) uio(F) ata_generic(F) ahci(F) libahci(F) pata_jmicron(F)
> fsl_pq_mdio(F)
> [65426.759065] CPU: 6 PID: 19006 Comm: umount.nfs Tainted: GF
>  3.11.0-5-powerpc-e500mc #8-Ubuntu
> [65426.768461] task: ea0f3900 ti: ea05c000 task.ti: ea05c000
> [65426.773858] NIP: f99a0f50 LR: f998250c CTR: c07f85c0
> [65426.778820] REGS: ea05dda0 TRAP: 0700   Tainted: GF
> (3.11.0-5-powerpc-e500mc)
> [65426.786998] MSR: 00029002 <CE,EE,ME>  CR: 24000422  XER: 20000000
> [65426.793107]
> GPR00: f9982d20 ea05de50 ea0f3900 e7e66ee0 00029002 00000001 00000000
> 00000000
> GPR08: eadc2504 00000000 00000000 00000001 c07f85c0 1002e3ac 10010000
> 00008000
> GPR16: 100112e4 1000f3c4 1000f3e0 1000f594 1000f59c 1000f440 c0b4fb6c
> 10010000
> GPR24: 10010000 00000000 c0089180 ea05de84 f99ab064 ea2bf500 c0b41380
> ea54ef00
> [65426.822949] NIP [f99a0f50] rpc_remove_client_dir+0x0/0x30 [sunrpc]
> [65426.829143] LR [f998250c] __rpc_clnt_remove_pipedir+0x5c/0x80 [sunrpc]
> [65426.835668] Call Trace:
> [65426.838128] [ea05de50] [f999f9f0] rpc_get_sb_net+0x70/0xa0 [sunrpc]
> (unreliable)
> [65426.845542] [ea05de60] [f9982d20] rpc_free_client+0x50/0xa0 [sunrpc]
> [65426.851910] [ea05de70] [f9982c58] rpc_shutdown_client+0x68/0xe0 [sunrpc]
> [65426.858647] [ea05dec0] [f9a3fd04] nfs_free_server+0x124/0x190 [nfs]
> [65426.864920] [ea05dee0] [c01c5f34] deactivate_locked_super+0x74/0xa0
> [65426.871193] [ea05def0] [c01e9184] SyS_umount+0x94/0x3d0
> [65426.876422] [ea05df40] [c0010604] ret_from_syscall+0x0/0x3c
> [65426.882002] --- Exception: c01 at 0xfec55dc
> [65426.882002]     LR = 0xff88d54
> [65426.889225] Instruction dump:
> [65426.892191] 00001b50 0000aa32 00000706 00000120 0000aa36 00000706
> 00001af8 0000aa3a
> [65426.899964] 00000706 00001aa0 0000aa46 00000704 <00000058> 0000aa4a
> 00000704 00001b74
> [65426.907949] udlfb: /dev/fb0 FB_BLANK mode 1 --> 0
> [65426.912666] udlfb: set_par mode 1024x768
> [65426.927196] ---[ end trace b25b3039b99e0391 ]---
> [65426.931816]
> umount.nfs: /work: not mounted
> [65426.960296] init: idmapd main process (2394) killed by TERM signal
> [65426.983998] init: systemd-logind main process (544) killed by TERM signal
> [65426.994070] Oops: Exception in kernel mode, sig: 11 [#2]
> [65426.999386] SMP NR_CPUS=8 P4080 DS
> [65427.002787] Modules linked in: btrfs(F) raid6_pq(F) zlib_deflate(F)
> xor(F) ufs(F) qnx4(F) hfsplus(F) hfs(F) minix(F) ntfs(F) msdos(F) jfs(F)
> xfs(F) libcrc32c(F) reiserfs(F) nls_iso8859_1(F) nls_cp437(F) vfat(F)
> fat(F) dm_multipath(F) scsi_dh(F) usb_storage(F) ext2(F) rpcsec_gss_krb5(F)
> nfsv4(F) nfsd(F) auth_rpcgss(F) nfs_acl(F) nfs(F) lockd(F) sunrpc(F)
> fscache(F) ofpart(F) redboot(F) cmdlinepart(F) cfi_cmdset_0002(F)
> cfi_probe(F) cfi_util(F) gen_probe(F) physmap_of(F) map_funcs(F) chipreg(F)
> mtd(F) lm90(F) at24(F) caam(F) i2c_mpc(F) mpc85xx_edac(F) edac_core(F)
> uio_pdrv_genirq(F) uio(F) ata_generic(F) ahci(F) libahci(F) pata_jmicron(F)
> fsl_pq_mdio(F)
> [65427.060734] CPU: 7 PID: 19014 Comm: umount Tainted: GF     D
>  3.11.0-5-powerpc-e500mc #8-Ubuntu
> [65427.069783] task: e5d55580 ti: ea2f0000 task.ti: ea2f0000
> [65427.075180] NIP: f99a0270 LR: c01c5f34 CTR: f99a0270
> [65427.080142] REGS: ea2f1e30 TRAP: 0700   Tainted: GF     D
> (3.11.0-5-powerpc-e500mc)
> [65427.088320] MSR: 00029002 <CE,EE,ME>  CR: 24004424  XER: 00000000
> [65427.094430]
> GPR00: c01c5f24 ea2f1ee0 e5d55580 ea1e7800 c1d404e0 ea027a80 c01e7b78
> 00000001
> GPR08: ffffffff f99a0270 ffffffff 0000000d 003fe0f9 100192e0 10010000
> 00008000
> GPR16: 100112e4 1000f3c4 1000f3e0 1000f594 1000f59c ea027aa0 c0b4fb6c
> ea2f1ef8
> GPR24: 00000000 ea027a80 00000000 ea027a80 ea027aa0 ea027abc f99aba78
> ea1e7800
> [65427.124275] NIP [f99a0270] rpc_kill_sb+0x0/0x110 [sunrpc]
> [65427.129677] LR [c01c5f34] deactivate_locked_super+0x74/0xa0
> [65427.135246] Call Trace:
> [65427.137689] [ea2f1ee0] [c01c5f24] deactivate_locked_super+0x64/0xa0
> (unreliable)
> [65427.145094] [ea2f1ef0] [c01e9184] SyS_umount+0x94/0x3d0
> [65427.150322] [ea2f1f40] [c0010604] ret_from_syscall+0x0/0x3c
> [65427.155902] --- Exception: c01 at 0xfec45cc
> [65427.155902]     LR = 0x10003130
> [65427.163212] Instruction dump:
> [65427.166178] 0000867e 00000706 00001288 00008682 00000706 00000058
> 00008686 00000704
> [65427.173952] 00001288 0000868a 00000704 00000058 <00008690> 0006320a
> 00000000 00008694
> [65427.181901] ---[ end trace b25b3039b99e0392 ]---
> [65427.186514]
> rpcbind: rpcbind terminating on signal. Restart with "rpcbind -w"
> [65427.235270] init: rpcbind main process (2082) terminated with status 2
> [65427.294746] init: Disconnected from system bus
>  * Deactivating swap...                                                  [
> OK ]
>  * Unmounting local filesystems...                                       [
> OK ]
> mount: / is busy
>  * Will now restart
> 
> -- 
> 
> *Regards,*
> * John.*
> 
> *--*
> 
> *o* Energy-efficiency is #1 reason data centers look to expand.  -- Digital
> Realty Trust
> *o* Green Data Centers spending to increase 300% worldwide by 2016.  --
> Pike Research
> *o *Data Centers have become as vital to the functioni
> ng of society as power stations.  -- The Economist

> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
