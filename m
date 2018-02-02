Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zY4hR4YJCzF0bm
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Feb 2018 05:07:35 +1100 (AEDT)
Date: Fri, 2 Feb 2018 19:07:32 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mathieu Malaterre <malat@debian.org>
Cc: Christoph Hellwig <hch@lst.de>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [ppc32] WARNING: CPU: 0 PID: 1 at
 ./include/linux/dma-mapping.h:516 dmam_alloc_coherent+0xd8/0x118
Message-ID: <20180202180732.GA8463@lst.de>
References: <CA+7wUsybeT=pdkX7AkiC=JsG2ShDMZF+Z_anxryeJ=UJFHkSYQ@mail.gmail.com>
 <20180202174622.GA7996@lst.de>
 <CA+7wUsw6jee9+PT0JUQ-gSL=A79d-uxSqgNd4LsHkUYn+zXPyw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+7wUsw6jee9+PT0JUQ-gSL=A79d-uxSqgNd4LsHkUYn+zXPyw@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 02, 2018 at 07:06:14PM +0100, Mathieu Malaterre wrote:
> On Fri, Feb 2, 2018 at 6:46 PM, Christoph Hellwig <hch@lst.de> wrote:
> > On Fri, Feb 02, 2018 at 02:11:33PM +0100, Mathieu Malaterre wrote:
> >> Hi there,
> >>
> >> What is this warning all about (system is Mac Mini G4) ? Thanks
> >
> > What kernel version is this?
> 
> I've synced with git/master this morning

Ok, that means it is the warning for the lack of a coherent dma mask.

Seems like the macio bus isn't setting a proper coherent mask.
