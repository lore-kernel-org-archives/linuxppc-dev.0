Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPRQH1xv7zDw8l
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 15:42:31 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id x23so2503671pgx.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 20:42:31 -0800 (PST)
Date: Thu, 24 Nov 2016 15:42:17 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, Alan Modra <amodra@gmail.com>
Subject: Re: [RFC][PATCH] powerpc/64be: use ELFv2 ABI for big endian kernels
Message-ID: <20161124154217.1374b125@roar.ozlabs.ibm.com>
In-Reply-To: <20161123143834.GB6099@gate.crashing.org>
References: <20161123130840.1877-1-npiggin@gmail.com>
 <20161123143834.GB6099@gate.crashing.org>
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

On Wed, 23 Nov 2016 08:38:34 -0600
Segher Boessenkool <segher@kernel.crashing.org> wrote:

> On Thu, Nov 24, 2016 at 12:08:40AM +1100, Nicholas Piggin wrote:
> > Question, are there any fundamental reasons we shouldn't use the ELFv2
> > ABI to build big endian kernels if the compiler supports it?  
> 
> No one uses ELFv2 for BE in production, and it isn't thoroughly tested
> at all, not even regularly tested.  "Not supported", as far as GCC is
> concerned (or any of the distros AFAIK).
> 
> There are no fundamental reasons of course, ABIs are largely just
> conventions, not laws of nature.

That's a very good reason! I didn't think of that, I'll drop the idea.

Thanks,
Nick
