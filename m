Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tP4hl06mmzDw9P
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 01:38:46 +1100 (AEDT)
Date: Wed, 23 Nov 2016 08:38:34 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Alan Modra <amodra@gmail.com>
Subject: Re: [RFC][PATCH] powerpc/64be: use ELFv2 ABI for big endian kernels
Message-ID: <20161123143834.GB6099@gate.crashing.org>
References: <20161123130840.1877-1-npiggin@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20161123130840.1877-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 24, 2016 at 12:08:40AM +1100, Nicholas Piggin wrote:
> Question, are there any fundamental reasons we shouldn't use the ELFv2
> ABI to build big endian kernels if the compiler supports it?

No one uses ELFv2 for BE in production, and it isn't thoroughly tested
at all, not even regularly tested.  "Not supported", as far as GCC is
concerned (or any of the distros AFAIK).

There are no fundamental reasons of course, ABIs are largely just
conventions, not laws of nature.


Segher
