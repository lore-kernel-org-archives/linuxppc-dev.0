Return-Path: <penberg@gmail.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6D48AB71C2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 17 Jun 2009 14:16:31 +1000 (EST)
Received: from mail-bw0-f219.google.com (mail-bw0-f219.google.com
	[209.85.218.219]) by ozlabs.org (Postfix) with ESMTP id 96A4EDDD01
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Jun 2009 14:16:30 +1000 (EST)
Received: by bwz19 with SMTP id 19so53213bwz.9
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jun 2009 21:16:28 -0700 (PDT)
MIME-Version: 1.0
Sender: penberg@gmail.com
In-Reply-To: <1245210519.21602.16.camel@pasglop>
References: <1245210519.21602.16.camel@pasglop>
Date: Wed, 17 Jun 2009 07:16:28 +0300
Message-ID: <84144f020906162116v2d6f449fgc19aac69f19dd34f@mail.gmail.com>
Subject: Re: mm: Move pgtable_cache_init() earlier
From: Pekka Enberg <penberg@cs.helsinki.fi>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>, linux-mm <linux-mm@kvack.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>, Chris Zankel <chris@zankel.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

On Wed, Jun 17, 2009 at 6:48 AM, Benjamin
Herrenschmidt<benh@kernel.crashing.org> wrote:
> Some architectures need to initialize SLAB caches to be able
> to allocate page tables. They do that from pgtable_cache_init()
> so the later should be called earlier now, best is before
> vmalloc_init().
>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Looks good to me!

Acked-by: Pekka Enberg <penberg@cs.helsinki.fi>
