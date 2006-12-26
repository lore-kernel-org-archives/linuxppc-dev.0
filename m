Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BB76EDDEE1
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Dec 2006 08:09:32 +1100 (EST)
Message-ID: <45918F77.1010806@pobox.com>
Date: Tue, 26 Dec 2006 16:09:11 -0500
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Linas Vepstas <linas@austin.ibm.com>
Subject: Re: [PATCH 1/14] Spidernet DMA coalescing
References: <20061213210010.GR4329@austin.ibm.com>
	<20061213210659.GA1915@austin.ibm.com>
In-Reply-To: <20061213210659.GA1915@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andrew Morton <akpm@osdl.org>, Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	linuxppc-dev@ozlabs.org, Jens Osterkamp <Jens.Osterkamp@gmx.de>,
	James K Lewis <jim@jklewis.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Linas Vepstas wrote:
> The current driver code performs 512 DMA mappings of a bunch of 
> 32-byte ring descriptor structures. This is silly, as they are 
> all in contiguous memory. This patch changes the code to 
> dma_map_coherent() each rx/tx ring as a whole.
> 
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>
> Cc: James K Lewis <jklewis@us.ibm.com>
> Cc: Arnd Bergmann <arnd@arndb.de>

applied 1-13 of 14 to netdev-2.6.git#upstream
