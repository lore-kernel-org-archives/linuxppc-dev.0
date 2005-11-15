Return-Path: <galak@gate.crashing.org>
Date: Tue, 15 Nov 2005 10:45:01 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20051115092042.GA2060@lst.de>
Message-ID: <Pine.LNX.4.44.0511151038440.24755-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: put page page_to_virt for Book-e processors
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 15 Nov 2005, Christoph Hellwig wrote:

> On Mon, Nov 14, 2005 at 05:21:44PM -0600, Kumar Gala wrote:
> > Book-E processors use page_to_virt since we have to always translate.
> 
> Why can't you use the proper page_address() macro?

I really want is lowmem_page_address() since the only current ppc user of
page_to_virt() in include/asm-ppc/pgalloc.h is pmd_populate() for book-e.  
We have to have pages in lowmem.

- kumar
