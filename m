Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40zvwd0wjdzF18B
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jun 2018 22:52:33 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH v2 00/14] Remove unneccessary included headers
In-Reply-To: <cover.1527868006.git.christophe.leroy@c-s.fr>
References: <cover.1527868006.git.christophe.leroy@c-s.fr>
Date: Mon, 04 Jun 2018 22:52:31 +1000
Message-ID: <87d0x6bto0.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> The purpose of this serie is to limit the number of includes to
> only the necessary ones in order to reduce the number of files
> recompiled everytime a header file is modified.
>
> This is the start of the work, please provide feedback if any so
> that I don't go in the wrong direction.
>
> Handled inclusion changes more carrefully after Michael feedback.
>
> Started splitting some headers in order to reduce their coverage.
>
> Christophe Leroy (14):
>   powerpc: remove kdump.h from page.h
>   powerpc: remove unneeded inclusions of cpu_has_feature.h
>   powerpc/405: move PPC405_ERR77 in asm-405.h
>   powerpc: move ASM_CONST and stringify_in_c() into asm-const.h
>   powerpc: clean the inclusion of stringify.h
>   powerpc: clean inclusions of asm/feature-fixups.h
>   powerpc: remove superflous inclusions of asm/fixmap.h
>   powerpc: declare set_breakpoint() static
>   powerpc/book3s: Remove PPC_PIN_SIZE
>   powerpc: fix includes in asm/processor.h
>   powerpc/nohash: fix hash related comments in pgtable.h
>   powerpc/44x: remove page.h from mmu-44x.h
>   powerpc: split reg.h in two parts
>   powerpc: Split synch.h in two parts

Still some problems :)

  http://kisskb.ellerman.id.au/kisskb/head/14047/

cheers


arch/powerpc/include/asm/reg.h:1286:31: error: expected ':' or ')' before 'ASM_FTR_IFCLR':
  allmodconfig+64K_PAGES powerpc
  allmodconfig+64K_PAGES powerpc-5.3
  allmodconfig+ppc64le ppc64le
  powernv_defconfig+NO_NUMA ppc64le
  powernv_defconfig+NO_PERF ppc64le
  powernv_defconfig+NO_RADIX ppc64le
  powernv_defconfig+STRICT_RWX ppc64le
  powernv_defconfig+THIN ppc64le
  powerpc-allmodconfig powerpc
  powerpc-allmodconfig powerpc-5.3
  powerpc-allyesconfig powerpc
  powerpc-allyesconfig powerpc-5.3
  ppc64_defconfig powerpc
  ppc64_defconfig powerpc-5.3
  ppc64_defconfig+NO_ALTIVEC powerpc
  ppc64_defconfig+NO_ALTIVEC powerpc-5.3
  ppc64_defconfig+NO_HUGETLB powerpc
  ppc64_defconfig+NO_HUGETLB powerpc-5.3
  ppc64_defconfig+NO_KVM powerpc
  ppc64_defconfig+NO_KVM powerpc-5.3
  ppc64_defconfig+NO_RADIX powerpc
  ppc64_defconfig+NO_TM powerpc
  ppc64_defconfig+NO_TM powerpc-5.3
  ppc64_defconfig+UP powerpc
  ppc64_defconfig+UP powerpc-5.3
  ppc64e_defconfig powerpc
  ppc64e_defconfig powerpc-5.3
  ppc64e_defconfig+KEXEC powerpc
  ppc64e_defconfig+KEXEC powerpc-5.3
  ppc64e_defconfig+UP powerpc
  ppc64e_defconfig+UP powerpc-5.3
  ppc64le_defconfig ppc64le
  ppc64le_defconfig+NO_KPROBES ppc64le
  ppc64le_defconfig+NO_KVM ppc64le
  ppc6xx_defconfig powerpc
  ppc6xx_defconfig powerpc-5.3
  pseries_defconfig powerpc
  pseries_defconfig powerpc-5.3
  pseries_defconfig+FA_DUMP powerpc
  pseries_defconfig+FA_DUMP powerpc-5.3
  pseries_defconfig+NO_MEMORY_HOTPLUG powerpc
  pseries_defconfig+NO_MEMORY_HOTPLUG powerpc-5.3
  pseries_defconfig+NO_MEMORY_HOTREMOVE powerpc
  pseries_defconfig+NO_SPLPAR powerpc
  pseries_defconfig+NO_SPLPAR powerpc-5.3
  pseries_le_defconfig ppc64le
  pseries_le_defconfig+NO_NUMA ppc64le
  pseries_le_defconfig+NO_SPLPAR ppc64le
  skiroot_defconfig ppc64le
