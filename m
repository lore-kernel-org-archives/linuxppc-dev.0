Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3szLnJ4HF5zDsyx
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Oct 2016 16:57:24 +1100 (AEDT)
Date: Wed, 19 Oct 2016 16:57:23 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 6/7] powerpc: switch to using thin archives if
 COMPILE_TEST is set
Message-ID: <20161019165723.7fda6701@canb.auug.org.au>
In-Reply-To: <20161019031600.17933-7-npiggin@gmail.com>
References: <20161019031600.17933-1-npiggin@gmail.com>
 <20161019031600.17933-7-npiggin@gmail.com>
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

Hi Nick,

On Wed, 19 Oct 2016 14:15:59 +1100 Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Enable thin archives build for powerpc when COMPILE_TEST is set.
> Thin archives are explained in this commit:
> 
>   a5967db9af51a84f5e181600954714a9e4c69f1f

This reference should be like this:

  a5967db9af51 ("kbuild: allow architectures to use thin archives instead of ld -r")

-- 
Cheers,
Stephen Rothwell
