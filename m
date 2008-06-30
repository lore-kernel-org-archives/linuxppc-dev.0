Return-Path: <hch@lst.de>
Received: from verein.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5E9AEDDF04
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Jul 2008 00:29:16 +1000 (EST)
Date: Mon, 30 Jun 2008 16:28:34 +0200
From: Christoph Hellwig <hch@lst.de>
To: Adrian Bunk <bunk@kernel.org>
Subject: Re: [RFC: 2.6 patch] powerpc: asm/elf.h: reduce userspace header
Message-ID: <20080630142834.GA29372@lst.de>
References: <20080623174828.GG4756@cs181140183.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080623174828.GG4756@cs181140183.pp.htv.fi>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 23, 2008 at 08:48:28PM +0300, Adrian Bunk wrote:
> This patch makes asm/elf.h export less non-userspace stuff to userspace.

I don't think this header should be exported at all.  There's a
userspace elf.h that should be used instead.
