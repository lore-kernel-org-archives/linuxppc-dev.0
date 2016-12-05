Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tXDD212FmzDvQC
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Dec 2016 16:42:10 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id p66so15318383pga.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 04 Dec 2016 21:42:10 -0800 (PST)
Date: Mon, 5 Dec 2016 16:41:53 +1100
From: Nicholas Piggin <npiggin@gmail.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>,
 linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: linux-next: build failure in the powerpc allyesconfig build
Message-ID: <20161205164153.43c84010@roar.ozlabs.ibm.com>
In-Reply-To: <20161205162431.71013317@canb.auug.org.au>
References: <20161205162204.02c2c236@canb.auug.org.au>
 <20161205162431.71013317@canb.auug.org.au>
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

On Mon, 5 Dec 2016 16:24:31 +1100
Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi all,
> 
> On Mon, 5 Dec 2016 16:22:04 +1100 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > After mergeing everything but Andrew's tree, today's linux-next build
> > (powerpc allyesconfig) failed like this:
> > 
> > kallsyms failure: relative symbol value 0xc000000000000000 out of range in relative mode
> > 
> > I have no idea what caused this, so I have left the powerpc allyesconfig
> > build broken for now.  
> 
> Just as a data point, I tried reverting commit
> 
>   dadc4a1bb9f0 ("powerpc/64: Fix placement of .text to be immediately following .head.text")
> 
> but that did not help.

In scripts/kallsyms.c, is there a table[i].sym string you can print?
