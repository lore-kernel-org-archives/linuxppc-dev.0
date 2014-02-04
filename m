Return-Path: <john.d@servergy.com>
Received: from mail-ob0-f181.google.com (mail-ob0-f181.google.com
 [209.85.214.181])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 290F62C0084
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Feb 2014 03:43:27 +1100 (EST)
Received: by mail-ob0-f181.google.com with SMTP id va2so9712786obc.40
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Feb 2014 08:43:24 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20140204155921.GA31582@oc0268524204.ibm.com>
References: <CAGtOQbSJeJ85Nj-M2XB+w3p5+PTVWrpsFKZqCbEqZYkwsa0GGg@mail.gmail.com>
 <20140204155921.GA31582@oc0268524204.ibm.com>
Date: Tue, 4 Feb 2014 10:43:23 -0600
Message-ID: <CAGtOQbR2sL6EkJRVqrG-6V8D_MY05Z3jatE=9LSRtgSe6yJDng@mail.gmail.com>
Subject: Re: Oops on shutdown : 3.11.0-5-powerpc-e500mc Ubuntu
From: John Donnelly <john.d@servergy.com>
To: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
Content-Type: multipart/alternative; boundary=089e015369f0b7fe4d04f19756fb
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--089e015369f0b7fe4d04f19756fb
Content-Type: text/plain; charset=ISO-8859-1

Thanks.
It appears to be a Ubuntu component :

(saucy)root@(none)# dpkg -S /boot/vmlinux-3.11.0-5-powerpc-e500mc
linux-image-3.11.0-5-powerpc-e500mc: /boot/vmlinux-3.11.0-5-powerpc-e500mc


On Tue, Feb 4, 2014 at 9:59 AM, Thadeu Lima de Souza Cascardo <
cascardo@linux.vnet.ibm.com> wrote:

> On Tue, Feb 04, 2014 at 08:47:14AM -0600, John Donnelly wrote:
> > Hi,
> >  Where is a appropriate place to file a bug for this : This is the second
> > occurrence I have seen.
> >
>
> If this is a Ubuntu kernel, probably report it at Canonical's Launchpad.
> If it is provided by Freescale, report it to Freescale.
> If you can run a mainline kernel (best now would be 3.14-rc1) and
> reproduce that, then best place would be linux-nfs@vger.kernel.org.
>
> Hope that helps.
> Cascardo.
>
> >
> >
> > saucy)root@(none):/work/svy/tools#  * Stopping MD monitoring service
> mdadm
> > --monitor
> >  [ OK ]
> >  * Asking all remaining processes to terminate...
>  [
> > OK ]
> >  * All processes ended within 1 seconds...
> [
> > OK ]
> > [65426.692405] Oops: Exception in kernel mode, sig: 11 [#1]
> > [65426.697721] SMP NR_CPUS=8 P4080 DS
> > [65426.701122] Modules linked in: btrfs(F) raid6_pq(F) zlib_deflate(F)
> > xor(F) ufs(F) qnx4(F) hfsplus(F) hfs(F) minix(F) ntfs(F) msdos(F) jfs(F)
> > xfs(F) libcrc32c(F) reiserfs(F) nls_iso8859_1(F) nls_cp437(F) vfat(F)
> > fat(F) dm_multipath(F) scsi_dh(F) usb_storage(F) ext2(F)
> rpcsec_gss_krb5(F)
> > nfsv4(F) nfsd(F) auth_rpcgss(F) nfs_acl(F) nfs(F) lockd(F) sunrpc(F)
> > fscache(F) ofpart(F) redboot(F) cmdlinepart(F) cfi_cmdset_0002(F)
> > cfi_probe(F) cfi_util(F) gen_probe(F) physmap_of(F) map_funcs(F)
> chipreg(F)
> > mtd(F) lm90(F) at24(F) caam(F) i2c_mpc(F) mpc85xx_edac(F) edac_core(F)
> > uio_pdrv_genirq(F) uio(F) ata_generic(F) ahci(F) libahci(F)
> pata_jmicron(F)
> > fsl_pq_mdio(F)
> > [65426.759065] CPU: 6 PID: 19006 Comm: umount.nfs Tainted: GF
> >  3.11.0-5-powerpc-e500mc #8-Ubuntu
> > [65426.768461] task: ea0f3900 ti: ea05c000 task.ti: ea05c000
> > [65426.773858] NIP: f99a0f50 LR: f998250c CTR: c07f85c0
> > [65426.778820] REGS: ea05dda0 TRAP: 0700   Tainted: GF
> > (3.11.0-5-powerpc-e500mc)
> > [65426.786998] MSR: 00029002 <CE,EE,ME>  CR: 24000422  XER: 20000000
> > [65426.793107]
> > GPR00: f9982d20 ea05de50 ea0f3900 e7e66ee0 00029002 00000001 00000000
> > 00000000
> > GPR08: eadc2504 00000000 00000000 00000001 c07f85c0 1002e3ac 10010000
> > 00008000
> > GPR16: 100112e4 1000f3c4 1000f3e0 1000f594 1000f59c 1000f440 c0b4fb6c
> > 10010000
> > GPR24: 10010000 00000000 c0089180 ea05de84 f99ab064 ea2bf500 c0b41380
> > ea54ef00
> > [65426.822949] NIP [f99a0f50] rpc_remove_client_dir+0x0/0x30 [sunrpc]
> > [65426.829143] LR [f998250c] __rpc_clnt_remove_pipedir+0x5c/0x80 [sunrpc]
> > [65426.835668] Call Trace:
> > [65426.838128] [ea05de50] [f999f9f0] rpc_get_sb_net+0x70/0xa0 [sunrpc]
> > (unreliable)
> > [65426.845542] [ea05de60] [f9982d20] rpc_free_client+0x50/0xa0 [sunrpc]
> > [65426.851910] [ea05de70] [f9982c58] rpc_shutdown_client+0x68/0xe0
> [sunrpc]
> > [65426.858647] [ea05dec0] [f9a3fd04] nfs_free_server+0x124/0x190 [nfs]
> > [65426.864920] [ea05dee0] [c01c5f34] deactivate_locked_super+0x74/0xa0
> > [65426.871193] [ea05def0] [c01e9184] SyS_umount+0x94/0x3d0
> > [65426.876422] [ea05df40] [c0010604] ret_from_syscall+0x0/0x3c
> > [65426.882002] --- Exception: c01 at 0xfec55dc
> > [65426.882002]     LR = 0xff88d54
> > [65426.889225] Instruction dump:
> > [65426.892191] 00001b50 0000aa32 00000706 00000120 0000aa36 00000706
> > 00001af8 0000aa3a
> > [65426.899964] 00000706 00001aa0 0000aa46 00000704 <00000058> 0000aa4a
> > 00000704 00001b74
> > [65426.907949] udlfb: /dev/fb0 FB_BLANK mode 1 --> 0
> > [65426.912666] udlfb: set_par mode 1024x768
> > [65426.927196] ---[ end trace b25b3039b99e0391 ]---
> > [65426.931816]
> > umount.nfs: /work: not mounted
> > [65426.960296] init: idmapd main process (2394) killed by TERM signal
> > [65426.983998] init: systemd-logind main process (544) killed by TERM
> signal
> > [65426.994070] Oops: Exception in kernel mode, sig: 11 [#2]
> > [65426.999386] SMP NR_CPUS=8 P4080 DS
> > [65427.002787] Modules linked in: btrfs(F) raid6_pq(F) zlib_deflate(F)
> > xor(F) ufs(F) qnx4(F) hfsplus(F) hfs(F) minix(F) ntfs(F) msdos(F) jfs(F)
> > xfs(F) libcrc32c(F) reiserfs(F) nls_iso8859_1(F) nls_cp437(F) vfat(F)
> > fat(F) dm_multipath(F) scsi_dh(F) usb_storage(F) ext2(F)
> rpcsec_gss_krb5(F)
> > nfsv4(F) nfsd(F) auth_rpcgss(F) nfs_acl(F) nfs(F) lockd(F) sunrpc(F)
> > fscache(F) ofpart(F) redboot(F) cmdlinepart(F) cfi_cmdset_0002(F)
> > cfi_probe(F) cfi_util(F) gen_probe(F) physmap_of(F) map_funcs(F)
> chipreg(F)
> > mtd(F) lm90(F) at24(F) caam(F) i2c_mpc(F) mpc85xx_edac(F) edac_core(F)
> > uio_pdrv_genirq(F) uio(F) ata_generic(F) ahci(F) libahci(F)
> pata_jmicron(F)
> > fsl_pq_mdio(F)
> > [65427.060734] CPU: 7 PID: 19014 Comm: umount Tainted: GF     D
> >  3.11.0-5-powerpc-e500mc #8-Ubuntu
> > [65427.069783] task: e5d55580 ti: ea2f0000 task.ti: ea2f0000
> > [65427.075180] NIP: f99a0270 LR: c01c5f34 CTR: f99a0270
> > [65427.080142] REGS: ea2f1e30 TRAP: 0700   Tainted: GF     D
> > (3.11.0-5-powerpc-e500mc)
> > [65427.088320] MSR: 00029002 <CE,EE,ME>  CR: 24004424  XER: 00000000
> > [65427.094430]
> > GPR00: c01c5f24 ea2f1ee0 e5d55580 ea1e7800 c1d404e0 ea027a80 c01e7b78
> > 00000001
> > GPR08: ffffffff f99a0270 ffffffff 0000000d 003fe0f9 100192e0 10010000
> > 00008000
> > GPR16: 100112e4 1000f3c4 1000f3e0 1000f594 1000f59c ea027aa0 c0b4fb6c
> > ea2f1ef8
> > GPR24: 00000000 ea027a80 00000000 ea027a80 ea027aa0 ea027abc f99aba78
> > ea1e7800
> > [65427.124275] NIP [f99a0270] rpc_kill_sb+0x0/0x110 [sunrpc]
> > [65427.129677] LR [c01c5f34] deactivate_locked_super+0x74/0xa0
> > [65427.135246] Call Trace:
> > [65427.137689] [ea2f1ee0] [c01c5f24] deactivate_locked_super+0x64/0xa0
> > (unreliable)
> > [65427.145094] [ea2f1ef0] [c01e9184] SyS_umount+0x94/0x3d0
> > [65427.150322] [ea2f1f40] [c0010604] ret_from_syscall+0x0/0x3c
> > [65427.155902] --- Exception: c01 at 0xfec45cc
> > [65427.155902]     LR = 0x10003130
> > [65427.163212] Instruction dump:
> > [65427.166178] 0000867e 00000706 00001288 00008682 00000706 00000058
> > 00008686 00000704
> > [65427.173952] 00001288 0000868a 00000704 00000058 <00008690> 0006320a
> > 00000000 00008694
> > [65427.181901] ---[ end trace b25b3039b99e0392 ]---
> > [65427.186514]
> > rpcbind: rpcbind terminating on signal. Restart with "rpcbind -w"
> > [65427.235270] init: rpcbind main process (2082) terminated with status 2
> > [65427.294746] init: Disconnected from system bus
> >  * Deactivating swap...
>  [
> > OK ]
> >  * Unmounting local filesystems...
> [
> > OK ]
> > mount: / is busy
> >  * Will now restart
> >
> > --
> >
> > *Regards,*
> > * John.*
> >
> > *--*
> >
> > *o* Energy-efficiency is #1 reason data centers look to expand.  --
> Digital
> > Realty Trust
> > *o* Green Data Centers spending to increase 300% worldwide by 2016.  --
> > Pike Research
> > *o *Data Centers have become as vital to the functioni
> > ng of society as power stations.  -- The Economist
>
> > _______________________________________________
> > Linuxppc-dev mailing list
> > Linuxppc-dev@lists.ozlabs.org
> > https://lists.ozlabs.org/listinfo/linuxppc-dev
>
>


-- 

*Regards,*
* John.*

*--*

*o* Energy-efficiency is #1 reason data centers look to expand.  -- Digital
Realty Trust
*o* Green Data Centers spending to increase 300% worldwide by 2016.  --
Pike Research
*o *Data Centers have become as vital to the functioni
ng of society as power stations.  -- The Economist

--089e015369f0b7fe4d04f19756fb
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Thanks.<div>It appears to be a Ubuntu component :<div><br>=
</div><div><div>(saucy)root@(none)# dpkg -S /boot/vmlinux-3.11.0-5-powerpc-=
e500mc</div><div>linux-image-3.11.0-5-powerpc-e500mc: /boot/vmlinux-3.11.0-=
5-powerpc-e500mc</div>
</div></div></div><div class=3D"gmail_extra"><br><br><div class=3D"gmail_qu=
ote">On Tue, Feb 4, 2014 at 9:59 AM, Thadeu Lima de Souza Cascardo <span di=
r=3D"ltr">&lt;<a href=3D"mailto:cascardo@linux.vnet.ibm.com" target=3D"_bla=
nk">cascardo@linux.vnet.ibm.com</a>&gt;</span> wrote:<br>
<blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1p=
x #ccc solid;padding-left:1ex"><div class=3D"im">On Tue, Feb 04, 2014 at 08=
:47:14AM -0600, John Donnelly wrote:<br>
&gt; Hi,<br>
&gt; =A0Where is a appropriate place to file a bug for this : This is the s=
econd<br>
&gt; occurrence I have seen.<br>
&gt;<br>
<br>
</div>If this is a Ubuntu kernel, probably report it at Canonical&#39;s Lau=
nchpad.<br>
If it is provided by Freescale, report it to Freescale.<br>
If you can run a mainline kernel (best now would be 3.14-rc1) and<br>
reproduce that, then best place would be <a href=3D"mailto:linux-nfs@vger.k=
ernel.org">linux-nfs@vger.kernel.org</a>.<br>
<br>
Hope that helps.<br>
Cascardo.<br>
<div><div class=3D"h5"><br>
&gt;<br>
&gt;<br>
&gt; saucy)root@(none):/work/svy/tools# =A0* Stopping MD monitoring service=
 mdadm<br>
&gt; --monitor<br>
&gt; =A0[ OK ]<br>
&gt; =A0* Asking all remaining processes to terminate... =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[<br>
&gt; OK ]<br>
&gt; =A0* All processes ended within 1 seconds... =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [<br>
&gt; OK ]<br>
&gt; [65426.692405] Oops: Exception in kernel mode, sig: 11 [#1]<br>
&gt; [65426.697721] SMP NR_CPUS=3D8 P4080 DS<br>
&gt; [65426.701122] Modules linked in: btrfs(F) raid6_pq(F) zlib_deflate(F)=
<br>
&gt; xor(F) ufs(F) qnx4(F) hfsplus(F) hfs(F) minix(F) ntfs(F) msdos(F) jfs(=
F)<br>
&gt; xfs(F) libcrc32c(F) reiserfs(F) nls_iso8859_1(F) nls_cp437(F) vfat(F)<=
br>
&gt; fat(F) dm_multipath(F) scsi_dh(F) usb_storage(F) ext2(F) rpcsec_gss_kr=
b5(F)<br>
&gt; nfsv4(F) nfsd(F) auth_rpcgss(F) nfs_acl(F) nfs(F) lockd(F) sunrpc(F)<b=
r>
&gt; fscache(F) ofpart(F) redboot(F) cmdlinepart(F) cfi_cmdset_0002(F)<br>
&gt; cfi_probe(F) cfi_util(F) gen_probe(F) physmap_of(F) map_funcs(F) chipr=
eg(F)<br>
&gt; mtd(F) lm90(F) at24(F) caam(F) i2c_mpc(F) mpc85xx_edac(F) edac_core(F)=
<br>
&gt; uio_pdrv_genirq(F) uio(F) ata_generic(F) ahci(F) libahci(F) pata_jmicr=
on(F)<br>
&gt; fsl_pq_mdio(F)<br>
&gt; [65426.759065] CPU: 6 PID: 19006 Comm: umount.nfs Tainted: GF<br>
&gt; =A03.11.0-5-powerpc-e500mc #8-Ubuntu<br>
&gt; [65426.768461] task: ea0f3900 ti: ea05c000 task.ti: ea05c000<br>
&gt; [65426.773858] NIP: f99a0f50 LR: f998250c CTR: c07f85c0<br>
&gt; [65426.778820] REGS: ea05dda0 TRAP: 0700 =A0 Tainted: GF<br>
&gt; (3.11.0-5-powerpc-e500mc)<br>
&gt; [65426.786998] MSR: 00029002 &lt;CE,EE,ME&gt; =A0CR: 24000422 =A0XER: =
20000000<br>
&gt; [65426.793107]<br>
&gt; GPR00: f9982d20 ea05de50 ea0f3900 e7e66ee0 00029002 00000001 00000000<=
br>
&gt; 00000000<br>
&gt; GPR08: eadc2504 00000000 00000000 00000001 c07f85c0 1002e3ac 10010000<=
br>
&gt; 00008000<br>
&gt; GPR16: 100112e4 1000f3c4 1000f3e0 1000f594 1000f59c 1000f440 c0b4fb6c<=
br>
&gt; 10010000<br>
&gt; GPR24: 10010000 00000000 c0089180 ea05de84 f99ab064 ea2bf500 c0b41380<=
br>
&gt; ea54ef00<br>
&gt; [65426.822949] NIP [f99a0f50] rpc_remove_client_dir+0x0/0x30 [sunrpc]<=
br>
&gt; [65426.829143] LR [f998250c] __rpc_clnt_remove_pipedir+0x5c/0x80 [sunr=
pc]<br>
&gt; [65426.835668] Call Trace:<br>
&gt; [65426.838128] [ea05de50] [f999f9f0] rpc_get_sb_net+0x70/0xa0 [sunrpc]=
<br>
&gt; (unreliable)<br>
&gt; [65426.845542] [ea05de60] [f9982d20] rpc_free_client+0x50/0xa0 [sunrpc=
]<br>
&gt; [65426.851910] [ea05de70] [f9982c58] rpc_shutdown_client+0x68/0xe0 [su=
nrpc]<br>
&gt; [65426.858647] [ea05dec0] [f9a3fd04] nfs_free_server+0x124/0x190 [nfs]=
<br>
&gt; [65426.864920] [ea05dee0] [c01c5f34] deactivate_locked_super+0x74/0xa0=
<br>
&gt; [65426.871193] [ea05def0] [c01e9184] SyS_umount+0x94/0x3d0<br>
&gt; [65426.876422] [ea05df40] [c0010604] ret_from_syscall+0x0/0x3c<br>
&gt; [65426.882002] --- Exception: c01 at 0xfec55dc<br>
&gt; [65426.882002] =A0 =A0 LR =3D 0xff88d54<br>
&gt; [65426.889225] Instruction dump:<br>
&gt; [65426.892191] 00001b50 0000aa32 00000706 00000120 0000aa36 00000706<b=
r>
&gt; 00001af8 0000aa3a<br>
&gt; [65426.899964] 00000706 00001aa0 0000aa46 00000704 &lt;00000058&gt; 00=
00aa4a<br>
&gt; 00000704 00001b74<br>
&gt; [65426.907949] udlfb: /dev/fb0 FB_BLANK mode 1 --&gt; 0<br>
&gt; [65426.912666] udlfb: set_par mode 1024x768<br>
&gt; [65426.927196] ---[ end trace b25b3039b99e0391 ]---<br>
&gt; [65426.931816]<br>
&gt; umount.nfs: /work: not mounted<br>
&gt; [65426.960296] init: idmapd main process (2394) killed by TERM signal<=
br>
&gt; [65426.983998] init: systemd-logind main process (544) killed by TERM =
signal<br>
&gt; [65426.994070] Oops: Exception in kernel mode, sig: 11 [#2]<br>
&gt; [65426.999386] SMP NR_CPUS=3D8 P4080 DS<br>
&gt; [65427.002787] Modules linked in: btrfs(F) raid6_pq(F) zlib_deflate(F)=
<br>
&gt; xor(F) ufs(F) qnx4(F) hfsplus(F) hfs(F) minix(F) ntfs(F) msdos(F) jfs(=
F)<br>
&gt; xfs(F) libcrc32c(F) reiserfs(F) nls_iso8859_1(F) nls_cp437(F) vfat(F)<=
br>
&gt; fat(F) dm_multipath(F) scsi_dh(F) usb_storage(F) ext2(F) rpcsec_gss_kr=
b5(F)<br>
&gt; nfsv4(F) nfsd(F) auth_rpcgss(F) nfs_acl(F) nfs(F) lockd(F) sunrpc(F)<b=
r>
&gt; fscache(F) ofpart(F) redboot(F) cmdlinepart(F) cfi_cmdset_0002(F)<br>
&gt; cfi_probe(F) cfi_util(F) gen_probe(F) physmap_of(F) map_funcs(F) chipr=
eg(F)<br>
&gt; mtd(F) lm90(F) at24(F) caam(F) i2c_mpc(F) mpc85xx_edac(F) edac_core(F)=
<br>
&gt; uio_pdrv_genirq(F) uio(F) ata_generic(F) ahci(F) libahci(F) pata_jmicr=
on(F)<br>
&gt; fsl_pq_mdio(F)<br>
&gt; [65427.060734] CPU: 7 PID: 19014 Comm: umount Tainted: GF =A0 =A0 D<br=
>
&gt; =A03.11.0-5-powerpc-e500mc #8-Ubuntu<br>
&gt; [65427.069783] task: e5d55580 ti: ea2f0000 task.ti: ea2f0000<br>
&gt; [65427.075180] NIP: f99a0270 LR: c01c5f34 CTR: f99a0270<br>
&gt; [65427.080142] REGS: ea2f1e30 TRAP: 0700 =A0 Tainted: GF =A0 =A0 D<br>
&gt; (3.11.0-5-powerpc-e500mc)<br>
&gt; [65427.088320] MSR: 00029002 &lt;CE,EE,ME&gt; =A0CR: 24004424 =A0XER: =
00000000<br>
&gt; [65427.094430]<br>
&gt; GPR00: c01c5f24 ea2f1ee0 e5d55580 ea1e7800 c1d404e0 ea027a80 c01e7b78<=
br>
&gt; 00000001<br>
&gt; GPR08: ffffffff f99a0270 ffffffff 0000000d 003fe0f9 100192e0 10010000<=
br>
&gt; 00008000<br>
&gt; GPR16: 100112e4 1000f3c4 1000f3e0 1000f594 1000f59c ea027aa0 c0b4fb6c<=
br>
&gt; ea2f1ef8<br>
&gt; GPR24: 00000000 ea027a80 00000000 ea027a80 ea027aa0 ea027abc f99aba78<=
br>
&gt; ea1e7800<br>
&gt; [65427.124275] NIP [f99a0270] rpc_kill_sb+0x0/0x110 [sunrpc]<br>
&gt; [65427.129677] LR [c01c5f34] deactivate_locked_super+0x74/0xa0<br>
&gt; [65427.135246] Call Trace:<br>
&gt; [65427.137689] [ea2f1ee0] [c01c5f24] deactivate_locked_super+0x64/0xa0=
<br>
&gt; (unreliable)<br>
&gt; [65427.145094] [ea2f1ef0] [c01e9184] SyS_umount+0x94/0x3d0<br>
&gt; [65427.150322] [ea2f1f40] [c0010604] ret_from_syscall+0x0/0x3c<br>
&gt; [65427.155902] --- Exception: c01 at 0xfec45cc<br>
&gt; [65427.155902] =A0 =A0 LR =3D 0x10003130<br>
&gt; [65427.163212] Instruction dump:<br>
&gt; [65427.166178] 0000867e 00000706 00001288 00008682 00000706 00000058<b=
r>
&gt; 00008686 00000704<br>
&gt; [65427.173952] 00001288 0000868a 00000704 00000058 &lt;00008690&gt; 00=
06320a<br>
&gt; 00000000 00008694<br>
&gt; [65427.181901] ---[ end trace b25b3039b99e0392 ]---<br>
&gt; [65427.186514]<br>
&gt; rpcbind: rpcbind terminating on signal. Restart with &quot;rpcbind -w&=
quot;<br>
&gt; [65427.235270] init: rpcbind main process (2082) terminated with statu=
s 2<br>
&gt; [65427.294746] init: Disconnected from system bus<br>
&gt; =A0* Deactivating swap... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0[<br>
&gt; OK ]<br>
&gt; =A0* Unmounting local filesystems... =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 [<br>
&gt; OK ]<br>
&gt; mount: / is busy<br>
&gt; =A0* Will now restart<br>
&gt;<br>
&gt; --<br>
&gt;<br>
</div></div>&gt; *Regards,*<br>
&gt; * John.*<br>
&gt;<br>
&gt; *--*<br>
&gt;<br>
&gt; *o* Energy-efficiency is #1 reason data centers look to expand. =A0-- =
Digital<br>
&gt; Realty Trust<br>
&gt; *o* Green Data Centers spending to increase 300% worldwide by 2016. =
=A0--<br>
&gt; Pike Research<br>
&gt; *o *Data Centers have become as vital to the functioni<br>
<div class=3D"im">&gt; ng of society as power stations. =A0-- The Economist=
<br>
<br>
</div>&gt; _______________________________________________<br>
&gt; Linuxppc-dev mailing list<br>
&gt; <a href=3D"mailto:Linuxppc-dev@lists.ozlabs.org">Linuxppc-dev@lists.oz=
labs.org</a><br>
&gt; <a href=3D"https://lists.ozlabs.org/listinfo/linuxppc-dev" target=3D"_=
blank">https://lists.ozlabs.org/listinfo/linuxppc-dev</a><br>
<br>
</blockquote></div><br><br clear=3D"all"><div><br></div>-- <br><div dir=3D"=
ltr"><div style=3D"font-family:Arial;font-size:12px"><span style=3D"border-=
collapse:collapse"><div style=3D"border-collapse:collapse"><div style=3D"ma=
rgin:0px;display:inline!important">
<span style=3D"color:rgb(80,0,80);border-collapse:collapse"><font color=3D"=
#67b545"><b><br></b></font></span></div></div><div style=3D"border-collapse=
:collapse"><font color=3D"#67b545"><b>Regards,</b></font></div><div style=
=3D"border-collapse:collapse">
<font color=3D"#67b545"><b>=A0John.</b></font></div><div style=3D"border-co=
llapse:collapse"><font color=3D"#67b545"><b><br></b></font></div><div style=
=3D"border-collapse:collapse"><div style=3D"margin:0px;display:inline!impor=
tant"><span style=3D"color:rgb(80,0,80);border-collapse:collapse"><font col=
or=3D"#67b545"><b>--</b></font></span></div>
</div><div style=3D"border-collapse:collapse"><div style=3D"margin:0px;disp=
lay:inline!important"><span style=3D"color:rgb(80,0,80);border-collapse:col=
lapse"><font color=3D"#67b545"><b><br></b></font></span></div></div><div st=
yle=3D"border-collapse:collapse">
<div style=3D"margin:0px;display:inline!important"><span style=3D"color:rgb=
(80,0,80);border-collapse:collapse"><font color=3D"#67b545"><b>o</b></font>=
=A0</span><span style=3D"border-collapse:collapse"><font color=3D"#000000">=
Energy-efficiency is #1 reason data centers look to expand. =A0-- Digital R=
ealty Trust</font></span></div>
</div><div style=3D"border-collapse:collapse"><div style=3D"margin:0px;disp=
lay:inline!important"><font style=3D"color:rgb(51,204,0)"><b style=3D"color=
:rgb(103,181,69)">o</b>=A0</font><font color=3D"#000000">Green Data Centers=
 spending to increase 300% worldwide by 2016. =A0-- Pike Research</font></d=
iv>
</div></span></div><div style=3D"font-family:Arial;font-size:12px"><div sty=
le=3D"margin:0px"><b style=3D"color:rgb(103,181,69)">o=A0</b><font color=3D=
"#000000">Data Centers have=A0become as vital to the=A0functioni</font><div=
 style=3D"margin:0px;display:inline!important">
<font color=3D"#000000">ng</font><font color=3D"#000000">=A0of society as p=
ower stations. =A0-- The Economist</font></div></div><div style=3D"margin:0=
px"><br></div></div></div>
</div>

--089e015369f0b7fe4d04f19756fb--
