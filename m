Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 by lists.ozlabs.org (Postfix) with ESMTP id 671001A0DF4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jan 2015 23:51:48 +1100 (AEDT)
Date: Wed, 21 Jan 2015 09:51:42 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 0/8] Fix perf probe issues on powerpc
Message-ID: <20150121125142.GC3420@kernel.org>
References: <cover.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1418146300.git.naveen.n.rao@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Tue, Dec 09, 2014 at 11:03:58PM +0530, Naveen N. Rao escreveu:
> This patchset fixes various issues with perf probe on powerpc
> across ABIv1 and ABIv2:
> - in the presence of DWARF debug-info,
> - in the absence of DWARF, but with the symbol table, and
> - in the absence of debug-info, but with kallsyms.
> 
> Applies cleanly on v3.18 and on -tip with minor changes to patch 6.
> Tested on ppc64 BE and LE.
> 
> - Naveen
> 
> Naveen N. Rao (8):
>   kprobes: Fix kallsyms lookup across powerpc ABIv1 and ABIv2
>   perf probe powerpc: Fix symbol fixup issues due to ELF type
>   perf probe: Improve detection of file/function name in the probe
>     pattern
>   perf probe powerpc: Handle powerpc dot symbols
>   perf probe powerpc: Allow matching against dot symbols
>   perf tools powerpc: Fix PPC64 ELF ABIv2 symbol decoding
>   perf probe powerpc: Use DWARF info only if necessary
>   perf probe powerpc: Fixup function entry if using kallsyms lookup

Naveen,

	I saw several comments by Michael, have you tried to address
those comments and have you resubmitted this patchset?

Best regards,

- Arnaldo
