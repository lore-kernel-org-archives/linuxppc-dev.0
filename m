Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tXDzk187RzDvgw
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Dec 2016 17:16:34 +1100 (AEDT)
Date: Mon, 5 Dec 2016 17:16:33 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, PowerPC <linuxppc-dev@lists.ozlabs.org>,
 linux-next@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: linux-next: build failure in the powerpc allyesconfig build
Message-ID: <20161205171633.4e0cc235@canb.auug.org.au>
In-Reply-To: <20161205164153.43c84010@roar.ozlabs.ibm.com>
References: <20161205162204.02c2c236@canb.auug.org.au>
 <20161205162431.71013317@canb.auug.org.au>
 <20161205164153.43c84010@roar.ozlabs.ibm.com>
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

On Mon, 5 Dec 2016 16:41:53 +1100 Nicholas Piggin <npiggin@gmail.com> wrote:
>
> In scripts/kallsyms.c, is there a table[i].sym string you can print?

=46rom a quick try, it printed nothing useful i.e. just some garbled
random characters.

--=20
Cheers,
Stephen Rothwell
