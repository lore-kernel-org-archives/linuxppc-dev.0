Return-Path: <gerhard_pircher@gmx.net>
Received: from mailout-de.gmx.net (mailout-de.gmx.net [213.165.64.23])
	by ozlabs.org (Postfix) with SMTP id 01C1CB710B
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Mar 2011 04:14:55 +1100 (EST)
Content-Type: text/plain; charset="utf-8"
Date: Tue, 15 Mar 2011 18:14:48 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <AANLkTim6urK-1-0MXrXZPTDWifZsi+7QEH_c8S-vzWSL@mail.gmail.com>
Message-ID: <20110315171448.100300@gmx.net>
MIME-Version: 1.0
References: <AANLkTimJwBfz=RksRtuj3M2VQoMjj1msUb78s1H=GfJM@mail.gmail.com>
	<AANLkTikKWrEqKH-4f2aMFnVUy-xCLnvxhtjF-pKUuC6e@mail.gmail.com>
	<AANLkTinOo9tJ5=WWF2WJEZn3VwAUOa+SOYE0txNm-moM@mail.gmail.com>
	<AANLkTim6urK-1-0MXrXZPTDWifZsi+7QEH_c8S-vzWSL@mail.gmail.com>
Subject: Re: any chance to use a modern linux kernel on Pegasos1 G3 ?
To: nello martuscielli <ppc.addon@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, acrux_it@libero.it
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Tue, 15 Mar 2011 17:44:49 +0100
> Von: nello martuscielli <ppc.addon@gmail.com>
> An: 
> CC: linuxppc-dev@lists.ozlabs.org, "acrux @ cruxppc" <acrux_it@libero.it>
> Betreff: Re: any chance to use a modern linux kernel on Pegasos1 G3 ?

> ok, it seems that no one is interested to fix Pegasos1 G3 600MHz
> support.
> 
> But if someone is capable (i don't have this skill) here what it
> happens reading from serial debug console untill it freezes with
> linux-2.6.36.4
> 
> Pegasos Boot Strap (c) 2002 bplan GmbH
> Running on CPU PVR:00083311
> PLL setting : 00000001
> Enable L1 ICache...                                                   
> Done.
> Setting ROM Defaults...                                               
> Done.
> Configuring SDRAM...
> 08000000
> 10000000
> Delaying...Done.
> RAMSIZE = 18000000
> 00000004
> Reading W83194 : 00FFFFFFFFFF0000                                     
> Done.
> Setting Front Side Bus to 100MHz...                                   
> Done.
> Releasing IDE reset ...                                               
> Done.
> Configuring Legacy Devices
> Initializing KBD...                                                   
> Done.
> PLL setting : 00000003
> 10000000
> Done.
> FFFFFFFF
> BIOS: Stage 2 entered arg(FFFC0000,00000000,18000000)
> BIOS: MachineInfo at 0FFFFE68
> BIOS: set MemPool limit to BAT size (old=18000000 new=10000000)
> BIOS: 0F6FFFE8 bytes added to mempool
> LoadFromRFS: starting
> LoadFromRFS: lib module 00 has abs load adr at 00C00000
> CopyModule: start
> CopyModule: load address : 00C00000
> CopyModule: copy module to ram...done
> ModuleCopy: expanding... done
> LoadFromRFS: 00000001 modules out of 00000001 loaded
> InitLib: start
> InitLib: call module as OF
> allocated g_e=0xFD00008 (len=19232)
> install_root: pkg=0xFD53B90
> after init_environ e=0xFD00008
> running nvramrc...
> after running nvramrc
> no/bad nvramrc - performing default startup script
> Bus addresses:
>            253@2
> I/O addresses:
>           7936@FE002100
> Memory addresses:
>           127M@88040000
>           1.3G@98000000
> Prefetchable memory addresses:
> install_ata_disk_driver: reg=0x1000
> init_drive: reset controller 0x1000/0x100E
> init_drive: allow 4-bits for heads
> init_drive: select drive 0
> init_drive: seccnt=0x1 sector=0x1 cyl_lo=0x0 cyl_hi=0x0
> init_drive: error=0x1 status=0x50 status2=0x50
> init_drive: identify drive: atapi=0
> install_ata_disk_driver: return no error (0)
> install_ata_disk_driver: reg=0x1000
> init_drive: allow 4-bits for heads
> init_drive: select drive 1
> init_drive: seccnt=0x1 sector=0x1 cyl_lo=0x14 cyl_hi=0xEB
> init_drive: error=0x1 status=0x0 status2=0x0
> init_drive: identify drive: atapi=1
> atapi_cmd: cmdlen=12
> atapi_cmd: inlen=8 len=65534
> install_ata_disk_driver: return no error (0)
> install_ata_disk_driver: reg=0x1010
> init_drive: reset controller 0x1010/0x101E
> init_drive: allow 4-bits for heads
> init_drive: select drive 0
> init_drive: seccnt=0x20 sector=0x20 cyl_lo=0x20 cyl_hi=0x20
> init_drive: error=0x20 status=0x20 status2=0x20
> ATA-wait-ready: timeout: status=0x20
> init_drive: failed
> install_ata_disk_driver: reg=0x1010
> init_drive: allow 4-bits for heads
> init_drive: select drive 1
> init_drive: seccnt=0x30 sector=0x30 cyl_lo=0x30 cyl_hi=0x30
> init_drive: error=0x30 status=0x30 status2=0x30
> ATA-wait-ready: timeout: status=0x30
> init_drive: failed
> Bus addresses:
>            254@2
> I/O addresses:
>              8@FE001038
>           3072@FE001400
>            48K@FE004000
> Memory addresses:
>           1792@A0000100
>           1.2G@A0001000
> Prefetchable memory addresses:
>            12M@FD400000
> F_INSTALL_CONSOLE: BEGIN
> F_INSTALL_CONSOLE: ALIASING SCREEN
> F_INSTALL_CONSOLE: ALIASING KBD
> EMULATION INT HANDLER ENTERED WITH:
> INT NO: 15
> 
> EAX=0003 EBX=1111 ECX=2222 EDX=3333 ESP=0000 EBP=5555 ESI=6666 EDI=7777
>  AX=4E08  BX=C505  CX=0003  DX=202A  SP=6CAA  BP=5555  SI=5CF9  DI=7777
>  DS=C000  ES=BAD0  SS=C000  CS=F000  IP=FE15   NV UP -- PL ZR NA PE NC
> CS:IP = F4  C558 C000 0244 3000 0000 01B4 AC63 0200
> UNHANDLED INT 10 FUNCTION 0007 WITHIN EMULATION
> F_INSTALL_CONSOLE: END
> auto-booting...
> do_load: dev="" dlen=0 args="" alen=0
> do_load: alstr=""
> do_load: path doesn't start with /
> do_load: <diag-device> == <eth>
> do_load: no args..use the default
> do_load: <diag-file> == <diag>
> try_load: dev="eth" dlen=3 args="diag" alen=4
> entering main read/eval loop...
> 
> [...]
> atapi_cmd: cmdlen=12
> atapi_cmd: inlen=2048 len=2048
> iso_walk: read: name="zImage.chrp" extent=0x44FD size=0x337272 ret=no
> error
> iso9660: return R_END
> file_system: return end (-4089)
> disk-label return len=3371634 ret=end (-4089)
> ata_disk_close
> disk-label close:
> checking exec type Fcode
> fcode_is_exec: load=0x400000 loadlen=3371634
> checking exec type Forth
> checking exec type ELF
> f_go:
> checking exec type Fcode
> fcode_is_exec: load=0x400000 loadlen=3371634
> checking exec type Forth
> checking exec type ELF
> alloc_aligned: a 0xFD548E8 align 0xFD5491C size 0xFD54918 addr 0xFD54914
> alloc_constrained: min 0x0, max 0xFFFFFFFF, align 0x1000, mask
> 0xFFFFFFFF, size 0x332000, addr 0x300000
> alloc_constrained: acells 0x1 scells 0x1 t1 0xC t2 0xFD5490C u1
> 0xFD54910 u2 0xFD54914 u3 0xFD54918
> alloc_constrained: allocator_block 0xFD54930, next 0x0 addr 0x300000
> size 0xFD00000
> alloc_constrained: fsblock 0x0
> alloc_constrained: addr[] 0x300000
> alloc_constrained: bsize[] 0xFD00000
> alloc_constrained: passed min check
> alloc_constrained: addr 0x300000, align 0xFFF, off 0x69696969
> sum 0x0
> alloc_constrained: passed align check
> alloc_constrained: passed max check
> alloc_constrained: passed mask check
> alloc_constrained: passed full size check
> alloc_constrained: passed size check
> alloc_aligned: a 0xFD548E8 align 0xFD5491C size 0xFD54918 addr 0xFD54914
> alloc_constrained: min 0x0, max 0xFFFFFFFF, align 0x1000, mask
> 0xFFFFFFFF, size 0x6883C0, addr 0x632000
> alloc_constrained: acells 0x1 scells 0x1 t1 0xC t2 0xFD5490C u1
> 0xFD54910 u2 0xFD54914 u3 0xFD54918
> alloc_constrained: allocator_block 0xFD54930, next 0x0 addr 0x632000
> size 0xF9CE000
> alloc_constrained: fsblock 0x0
> alloc_constrained: addr[] 0x632000
> alloc_constrained: bsize[] 0xF9CE000
> alloc_constrained: passed min check
> alloc_constrained: addr 0x632000, align 0xFFF, off 0x0
> sum 0x0
> alloc_constrained: passed align check
> alloc_constrained: passed max check
> alloc_constrained: passed mask check
> alloc_constrained: passed full size check
> alloc_constrained: passed size check
> 
> 
> 
> and here giving a try with a smaller (1.9MB) linux boot kernel
> [...]
> atapi_cmd: cmdlen=12
> atapi_cmd: inlen=2048 len=2048
> iso_walk: read: name="zImage.chrp" extent=0x3CC size=0x1D8A1A ret=no error
> iso9660: return R_END
> file_system: return end (-4089)
> disk-label return len=1935898 ret=end (-4089)
> ata_disk_close
> disk-label close:
> checking exec type Fcode
> fcode_is_exec: load=0x400000 loadlen=1935898
> checking exec type Forth
> checking exec type ELF
> f_go:
> checking exec type Fcode
> fcode_is_exec: load=0x400000 loadlen=1935898
> checking exec type Forth
> checking exec type ELF
> alloc_aligned: a 0xFD548E8 align 0xFD5491C size 0xFD54918 addr 0xFD54914
> alloc_constrained: min 0x0, max 0xFFFFFFFF, align 0x1000, mask
> 0xFFFFFFFF, size 0x1D3000, addr 0x300000
> alloc_constrained: acells 0x1 scells 0x1 t1 0xC t2 0xFD5490C u1
> 0xFD54910 u2 0xFD54914 u3 0xFD54918
> alloc_constrained: allocator_block 0xFD54930, next 0x0 addr 0x300000
> size 0xFD00000
> alloc_constrained: fsblock 0x0
> alloc_constrained: addr[] 0x300000
> alloc_constrained: bsize[] 0xFD00000
> alloc_constrained: passed min check
> alloc_constrained: addr 0x300000, align 0xFFF, off 0x69696969
> sum 0x0
> alloc_constrained: passed align check
> alloc_constrained: passed max check
> alloc_constrained: passed mask check
> alloc_constrained: passed full size check
> alloc_constrained: passed size check
> alloc_aligned: a 0xFD548E8 align 0xFD5491C size 0xFD54918 addr 0xFD54914
> alloc_constrained: min 0x0, max 0xFFFFFFFF, align 0x1000, mask
> 0xFFFFFFFF, size 0x3AC9A0, addr 0x4D3000
> alloc_constrained: acells 0x1 scells 0x1 t1 0xC t2 0xFD5490C u1
> 0xFD54910 u2 0xFD54914 u3 0xFD54918
> alloc_constrained: allocator_block 0xFD54930, next 0x0 addr 0x4D3000
> size 0xFB2D000
> alloc_constrained: fsblock 0x0
> alloc_constrained: addr[] 0x4D3000
> alloc_constrained: bsize[] 0xFB2D000
> alloc_constrained: passed min check
> alloc_constrained: addr 0x4D3000, align 0xFFF, off 0x0
> sum 0x0
> alloc_constrained: passed align check
> alloc_constrained: passed max check
> alloc_constrained: passed mask check
> alloc_constrained: passed full size check
> alloc_constrained: passed size check

I don't know much about the Pegasos OF, but did you give GRUB2 for OF
a try? Maybe it can boot a newer Linux kernel, if it is not a device
tree related problem.

On the other side you mentioned this workaround in
arch/ppc/kernel/prom_init.c to me some time ago:

unsigned long __init prom_init(int r3, int r4, prom_entry pp) :
>        node = call_prom("finddevice", 1, 1, "/");
>        rc = call_prom("getprop", 4, 1, node, "model", model, sizeof(model));
>        if (rc > 0 && !strncmp (model, "Pegasos", 7)
>                && strncmp (model, "Pegasos2", 8)) {
>                /* Pegasos 1 has a broken translate method in the OF,
>                 * and furthermore the BATs are mapped 1:1 so the phys
>                 * address calculated above is correct, so let's use
>                 * it directly.
>                 */
>        } else if (offset == 0) {
>                /* If we are already running at 0xc0000000, we assume we were
>                 * loaded by an OF bootloader which did set a BAT for us.
>                 * This breaks OF translate so we force phys to be 0.
>                 */
>                prom_print("(already at 0xc0000000) phys=0\n");
>                phys = 0;
>        } else if (call_prom("getprop", 4, 1, prom_chosen, "mmu",
>                             &prom_mmu, sizeof(prom_mmu)) <= 0) {
>                prom_print(" no MMU found\n");
>        } else if (call_prom_ret("call-method", 4, 4, result, "translate",
>                                 prom_mmu, &_stext, 1) != 0) {
>                prom_print(" (translate failed)\n");
>        } else {
>                /* We assume the phys. address size is 3 cells */
>                phys = result[2];
>        }

Can anybody comment, if this "broken translate method in the OF" would
still be needed for arch/powerpc?

Gerhard

-- 
Schon gehört? GMX hat einen genialen Phishing-Filter in die
Toolbar eingebaut! http://www.gmx.net/de/go/toolbar
