Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id B308FB7090
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2011 09:56:05 +1100 (EST)
Date: Mon, 17 Oct 2011 18:53:57 -0400 (EDT)
Message-Id: <20111017.185357.1185691091043314919.davem@davemloft.net>
To: dpmcgee@gmail.com
Subject: Re: [PATCH] powerpc/mm: remove hack in mmap randomize layout
From: David Miller <davem@davemloft.net>
In-Reply-To: <CAEik5nPXQXESnNLJCWd48LLiEYsN6MgnjKhd_a4SMHFGHBbm8w@mail.gmail.com>
References: <1318882661-26859-1-git-send-email-dpmcgee@gmail.com>
 <20111017.175141.1489173261757833533.davem@davemloft.net>
 <CAEik5nPXQXESnNLJCWd48LLiEYsN6MgnjKhd_a4SMHFGHBbm8w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Dan McGee <dpmcgee@gmail.com>
Date: Mon, 17 Oct 2011 17:43:11 -0500

> Aha, I wasn't aware this was also being done elsewhere as there was no
> comment to tip me off. I found the one in
> arch/sparc/kernel/sys_sparc_64.c (mmap_rnd) and have fixed that
> locally and will resend, but I'm not seeing get_random_int() in use
> anywhere else in that architecture so I'm not quite sure where your
> second mentioned location is- or did you just mean the two calls 2
> lines apart in mmap_rnd()?

My bad, I thought we had implemented address randomization on 32-bit
sparc as well, unfortunately we haven't even though sparc64 has it
for 32-bit compat tasks.

That should be fixed at some point, but is outside of the scope of
what you're doing.

Thanks!
