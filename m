Return-Path: <0000014035b06a9d-e8b10680-e321-4d3b-95a8-0833fa3fb7c9-000000@amazonses.com>
Received: from a9-46.smtp-out.amazonses.com (a9-46.smtp-out.amazonses.com
 [54.240.9.46]) by ozlabs.org (Postfix) with ESMTP id 1440A2C008E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Aug 2013 03:10:20 +1000 (EST)
Date: Wed, 31 Jul 2013 17:04:49 +0000
From: Christoph Lameter <cl@gentwo.org>
To: Wladislav Wiebe <wladislav.kw@gmail.com>
Subject: Re: mm/slab: ppc: ubi: kmalloc_slab WARNING / PPC + UBI driver
In-Reply-To: <51F93C64.4090601@gmail.com>
Message-ID: <0000014035b06a9d-e8b10680-e321-4d3b-95a8-0833fa3fb7c9-000000@email.amazonses.com>
References: <51F8F827.6020108@gmail.com>
 <alpine.DEB.2.02.1307310858150.30572@gentwo.org>
 <alpine.DEB.2.02.1307311015320.30997@gentwo.org>
 <000001403567762a-60a27288-f0b2-4855-b88c-6a6f21ec537c-000000@email.amazonses.com>
 <51F93C64.4090601@gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: dedekind1@gmail.com, Mel Gorman <mel@csn.ul.ie>, dwmw2@infradead.org,
 Pekka Enberg <penberg@kernel.org>, linux-mm@kvack.org,
 linux-mtd@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 31 Jul 2013, Wladislav Wiebe wrote:

> Thanks for the point, do you plan to make kmalloc_large available for extern access in a separate mainline patch?
> Since kmalloc_large is statically defined in slub_def.h and when including it to seq_file.c
> we have a lot of conflicting types:

You cannot separatly include slub_def.h. slab.h includes slub_def.h for
you. What problem did you try to fix by doing so?

There is a patch pending that moves kmalloc_large to slab.h. So maybe we
have to wait a merge period in order to be able to use it with other
allocators than slub.
