Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 500531A19CC
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2015 15:55:39 +1000 (AEST)
Message-ID: <553494D8.8000801@c-s.fr>
Date: Mon, 20 Apr 2015 07:55:36 +0200
From: leroy christophe <christophe.leroy@c-s.fr>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, scottwood@freescale.com
Subject: Re: [PATCH 00/11] powerpc8xx: Further optimisation of TLB handling
References: <20150420052622.7EC181A242C@localhost.localdomain>
In-Reply-To: <20150420052622.7EC181A242C@localhost.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Le 20/04/2015 07:26, Christophe Leroy a écrit :
> This patchset provides a further optimisation of TLB handling in the 8xx.
> Main changes are based on:
> - Using processor handling of PGD/PTE Validity bits instead of testing ourselves
> the entries validity
> - Aligning PGD address to allow direct bit manipulation
> - Not saving registers like CR when not needed
>
> It also adds support to any TASK_SIZE
>
> Patchset:
> 01 - powerpc/8xx: remove remaining unnecessary code in FixupDAR
> 02 - powerpc/8xx: remove tests on PGDIR entry validity
> 03 - powerpc32: Use kmem_cache memory for PGDIR
> 04 - powerpc/8xx: Take benefit of aligned PGDIR
> 05 - powerpc/8xx: Optimise access to swapper_pg_dir
> 06 - powerpc/8xx: Remove duplicated code in set_context()
> 07 - powerpc/8xx: macro for handling CPU15 errata
> 08 - powerpc/8xx: Handle CR out of exception PROLOG/EPILOG
> 09 - powerpc/8xx: dont save CR in SCRATCH registers
> 10 - powerpc/8xx: Use SPRG2 instead of DAR for saving r3
> 11 - powerpc/8xx: Add support for TASK_SIZE greater than 0x80000000
>
> All changes have been successfully tested on MPC885
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Tested-by: Christophe Leroy <christophe.leroy@c-s.fr>
Sorry, forget than one, my finger slipped and I resent a very old one 
already applied

Christophe
