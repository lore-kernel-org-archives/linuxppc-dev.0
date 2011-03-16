Return-Path: <ppc.addon@gmail.com>
Received: from mail-yx0-f179.google.com (mail-yx0-f179.google.com
	[209.85.213.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B8ECDB7004
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 17 Mar 2011 10:39:04 +1100 (EST)
Received: by yxp4 with SMTP id 4so965137yxp.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 16 Mar 2011 16:39:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110315171448.100300@gmx.net>
References: <AANLkTimJwBfz=RksRtuj3M2VQoMjj1msUb78s1H=GfJM@mail.gmail.com>
	<AANLkTikKWrEqKH-4f2aMFnVUy-xCLnvxhtjF-pKUuC6e@mail.gmail.com>
	<AANLkTinOo9tJ5=WWF2WJEZn3VwAUOa+SOYE0txNm-moM@mail.gmail.com>
	<AANLkTim6urK-1-0MXrXZPTDWifZsi+7QEH_c8S-vzWSL@mail.gmail.com>
	<20110315171448.100300@gmx.net>
Date: Thu, 17 Mar 2011 00:39:00 +0100
Message-ID: <AANLkTimpJBX5LjrKj5f5CgKx5dy-4bfReZ+awVSp3hQb@mail.gmail.com>
Subject: Re: any chance to use a modern linux kernel on Pegasos1 G3 ?
From: nello martuscielli <ppc.addon@gmail.com>
To: Gerhard Pircher <gerhard_pircher@gmx.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, acrux_it@libero.it
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

hi all,

here instead the log from serial debug console booting the last
working kernel i.e. linux-2.16.62 compiled with arch=ppc .


[...]
do_load: dev="/ide/disk:0" dlen=11 args="CRUX root=/dev/hdb
video=radeonfb:800x600" alen=41
do_load: alstr=""
try_load: dev="/ide/disk:0" dlen=11 args="CRUX root=/dev/hdb
video=radeonfb:800x600" alen=41
create_well_formed_chain: pkg=0xFD57D58 parent=0xFD53B90
currpkg=0xFD53B90 inst=0xFE6EE50
        pkg=/pci@80000000 parent=/ currpkg=/ currinst=/
create_well_formed_chain: pkg=0xFD53B90 parent=0x0 currpkg=0xFD53B90
inst=0xFE6EE50
        pkg=/ parent= currpkg=/ currinst=/
        pkg=0xFD57D58:/pci@80000000 parent=0xFE6EE50:/
inst=0xFE6EEA8:/pci@80000000 instparent=0xFE6EE50
ata_disk_open: pkg=0xFD5B870 parent=0xFD5B2C8
ata_disk_open: CTLR=0x0 ID=0x0
ata_disk_open: args="0"
deblocker open
ata_disk_max_transfer: 512
deblocker open: block-size=0x200 max-transfer=0x200
deblocker open: return 0
open-package: ret=0:no error r=-1
ata_disk_open: $open-package deblocker ret=0
ata_disk_open: deblocker=0xFE6EFC8
disk-label open
disk-label open: self=0xFE702B0 s->buf=0xFE71000
disk-label open: return 0
open-package: ret=0:no error r=-1
ata_disk_open: $open-package disk-label ret=0
ata_disk_open: disklabel=0xFE70258
disk-label load: addr=0x400000 loadargs=CRUX root=/dev/hdb
video=radeonfb:800x600 args=0,CRUX root=/dev/hdb
video=radeonfb:800x600
file_system: e=0xFD00008 disk=0xFE6EF58 loc=0x0 start=0x0
path=0xFE703C0 buf=0xFE71000 size=512
file_system: probing filesys dos-partition

dos_partition: enter
dos-partition: boot_sect_sig0/1=0x55.0xAA jump=0x0 boot_signature=0x0
drive_number=0x0
dos_partition: partition=0 size=0x32F8E start=0x3F typ=0x6
        flag=0x80 shd=0x1 ssect=0x1 scyl=0x0 ehd=0xFE esect=0x3F ecyl=0xC
file_system: e=0xFD00008 disk=0xFE6EF58 loc=0x7E00 start=0x3F
path=0xFE703C2 buf=0xFE71000 size=512
file_system: probing filesys dos-partition
file_system: probing filesys dos-fat
file_system: return end (-4089)
file_system: return end (-4089)
disk-label return len=1782093 ret=end (-4089)
ata_disk_close
disk-label close:
checking exec type Fcode
fcode_is_exec: load=0x400000 loadlen=1782093
checking exec type Forth
checking exec type ELF
f_go:
checking exec type Fcode
fcode_is_exec: load=0x400000 loadlen=1782093
checking exec type Forth
checking exec type ELF
alloc_aligned: a 0xFD548E8 align 0xFD5491C size 0xFD54918 addr 0xFD54914
alloc_constrained: min 0x0, max 0xFFFFFFFF, align 0x1000, mask
0xFFFFFFFF, size 0x7E0000, addr 0x300000
alloc_constrained: acells 0x1 scells 0x1 t1 0xC t2 0xFD5490C u1
0xFD54910 u2 0xFD54914 u3 0xFD54918
alloc_constrained: allocator_block 0xFD54930, next 0x0 addr 0x300000
size 0xFD00000
alloc_constrained: fsblock 0x0
alloc_constrained: addr[] 0x300000
alloc_constrained: bsize[] 0xFD00000
alloc_constrained: passed min check
alloc_constrained: addr 0x300000, align 0xFFF, off 0x69696969
sum 0x0
alloc_constrained: passed align check
alloc_constrained: passed max check
alloc_constrained: passed mask check
alloc_constrained: passed full size check
alloc_constrained: passed size check


i'm not an expert but from a quick logs comparison I saw two times the
alloc_aligned,alloc_constrained section instead in the working one i
see it only one time.
Maybe it's an usefull observation.


cheers,
Nell
--
1861 - 2011: 150 years of Italian Unity
