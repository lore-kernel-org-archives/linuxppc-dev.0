Return-Path: <hch@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zY4D36fdLzF0Y8
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Feb 2018 04:46:26 +1100 (AEDT)
Date: Fri, 2 Feb 2018 18:46:22 +0100
From: Christoph Hellwig <hch@lst.de>
To: Mathieu Malaterre <malat@debian.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Christoph Hellwig <hch@lst.de>
Subject: Re: [ppc32] WARNING: CPU: 0 PID: 1 at
 ./include/linux/dma-mapping.h:516 dmam_alloc_coherent+0xd8/0x118
Message-ID: <20180202174622.GA7996@lst.de>
References: <CA+7wUsybeT=pdkX7AkiC=JsG2ShDMZF+Z_anxryeJ=UJFHkSYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CA+7wUsybeT=pdkX7AkiC=JsG2ShDMZF+Z_anxryeJ=UJFHkSYQ@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 02, 2018 at 02:11:33PM +0100, Mathieu Malaterre wrote:
> Hi there,
> 
> What is this warning all about (system is Mac Mini G4) ? Thanks

What kernel version is this?
