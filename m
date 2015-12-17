Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1EC191A127C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Dec 2015 21:05:29 +1100 (AEDT)
Message-ID: <1450346722.13536.5.camel@ellerman.id.au>
Subject: Re: [PATCH v3 2/3] powerpc: Add __raw_rm_writeq() function
From: Michael Ellerman <mpe@ellerman.id.au>
To: Gabriel Paubert <paubert@iram.es>, Alistair Popple <alistair@popple.id.au>
Cc: linuxppc-dev@ozlabs.org, gwshan@linux.vnet.ibm.com
Date: Thu, 17 Dec 2015 21:05:22 +1100
In-Reply-To: <20151217091906.GA24014@visitor2.iram.es>
References: <1450320193-20116-1-git-send-email-alistair@popple.id.au>
 <1450320193-20116-3-git-send-email-alistair@popple.id.au>
 <20151217091906.GA24014@visitor2.iram.es>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-12-17 at 10:19 +0100, Gabriel Paubert wrote:
> On Thu, Dec 17, 2015 at 01:43:12PM +1100, Alistair Popple wrote:
> > Move __raw_rw_writeq() from platforms/powernv/pci-ioda.c to
>               ^
> Typo?
> (not a big deal)

Thanks for noticing, I saw this just in time and fixed it up before merging.

cheers
