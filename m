Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A9B1AB6F99
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Oct 2011 08:53:49 +1100 (EST)
Date: Mon, 17 Oct 2011 17:51:41 -0400 (EDT)
Message-Id: <20111017.175141.1489173261757833533.davem@davemloft.net>
To: dpmcgee@gmail.com
Subject: Re: [PATCH] powerpc/mm: remove hack in mmap randomize layout
From: David Miller <davem@davemloft.net>
In-Reply-To: <1318882661-26859-1-git-send-email-dpmcgee@gmail.com>
References: <1318882661-26859-1-git-send-email-dpmcgee@gmail.com>
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
Date: Mon, 17 Oct 2011 15:17:36 -0500

> Since commit 8a0a9bd4db63bc45e301, this comment in mmap_rnd() does not
> hold true as the value returned by get_random_int() will in fact be
> different every single call. Remove the comment and simplify the code
> back to its original desired form.
> 
> This reverts commit a5adc91a4b44b5d1 which is no longer necessary.
> 
> Signed-off-by: Dan McGee <dpmcgee@gmail.com>

Can you please fix up all the other architectures which use the same
logic, because they have simply copied over what powerpc does?

At a minimum, Sparc has two such locations.
