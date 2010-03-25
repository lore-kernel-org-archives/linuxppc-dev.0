Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id AC581B7CBD
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 25 Mar 2010 19:28:22 +1100 (EST)
Subject: Re: [PATCH 1/2] mm/vmalloc: Export purge_vmap_area_lazy()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Nick Piggin <npiggin@suse.de>
In-Reply-To: <20100325052814.GA7493@laptop.nomadix.com>
References: <1269417391.8599.188.camel@pasglop>
	<20100325052814.GA7493@laptop.nomadix.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 25 Mar 2010 19:25:59 +1100
Message-ID: <1269505559.8599.239.camel@pasglop>
Mime-Version: 1.0
Cc: "linux-mm@kvack.org" <linux-mm@kvack.org>,
	linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> You want vm_unmap_aliases(), which also flushes entries in the
> per-cpu vmap allocator (and is already exported for other code
> that has similar problems).

Ok, I missed that one. I'll update my patch. Thanks.

Cheers,
Ben.
