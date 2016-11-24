Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPwkT0850zDw7R
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Nov 2016 10:43:13 +1100 (AEDT)
Date: Fri, 25 Nov 2016 10:43:12 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-next@vger.kernel.org,
 linux-kernel@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, PowerPC
 <linuxppc-dev@lists.ozlabs.org>
Subject: Re: linux-next: build failure after merge of the akpm-current tree
Message-ID: <20161125104312.6bc3fdaf@canb.auug.org.au>
In-Reply-To: <9443137.1vHEJqnA2s@morokweng>
References: <20161124160151.20206af7@canb.auug.org.au>
 <9443137.1vHEJqnA2s@morokweng>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Thiago,

On Thu, 24 Nov 2016 13:02:39 -0200 Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> wrote:
>
> Am Donnerstag, 24. November 2016, 16:01:51 BRST schrieb Stephen Rothwell:
> > Hi Andrew,
> > 
> > After merging the akpm-current tree, today's linux-next build (powerpc
> > ppc64_defconfig) failed like this:
> > 
> > powerpc-linux-ld: unrecognized option '--no-dynamic-linker'
> > 
> > Caused by patch
> > 
> >   "powerpc: add purgatory for kexec_file_load implementation"
> >   
> 
> Sorry about that. --no-dynamic-linker was added in binutils 2.26.
> The patch below fixes the problem.

OK, I will apply that patch instead of disabling CONFIG_KEXEC_FILE
today.

-- 
Cheers,
Stephen Rothwell
