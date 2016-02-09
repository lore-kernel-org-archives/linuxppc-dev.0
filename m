Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 222C71A0191
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 02:49:32 +1100 (AEDT)
Subject: Re: [PATCH v7 00/23] powerpc/8xx: Use large pages for RAM and IMMR
 and other improvments
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>, Jonathan Corbet <corbet@lwn.net>
References: <cover.1454932181.git.christophe.leroy@c-s.fr>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <56BA0A88.3050704@c-s.fr>
Date: Tue, 9 Feb 2016 16:49:28 +0100
MIME-Version: 1.0
In-Reply-To: <cover.1454932181.git.christophe.leroy@c-s.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Le 09/02/2016 11:23, Christophe Leroy a écrit :
> The main purpose of this patchset is to dramatically reduce the time
> spent in DTLB miss handler. This is achieved by:
> 1/ Mapping RAM with 8M pages
> 2/ Mapping IMMR with a fixed 512K page
>
>
> Change in v7:
> * Don't include x_block_mapped() from compilation in
> arch/powerpc/mm/fsl_booke_mmu.c when CONFIG_FSL_BOOKE is not set
> (reported by kbuild test robot)
>
>

Please don't apply it, for some reason the modification supposed to be 
in v7 didn't get in. I will submit v8. Sorry for the noise.

Christophe
