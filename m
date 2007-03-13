Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4B050DDE22
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 20:42:31 +1100 (EST)
Date: Tue, 13 Mar 2007 10:42:29 +0100
From: Christoph Hellwig <hch@lst.de>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] ppc: Add support for bigger page sizes than 4KB on PPC44x
Message-ID: <20070313094229.GA13567@lst.de>
References: <200703122254.27087.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200703122254.27087.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 12, 2007 at 10:54:26PM +0100, Stefan Roese wrote:
>  arch/ppc/Kconfig               |   10 ++++++++
>  arch/ppc/kernel/head_44x.S     |   23 ++++++++++---------
>  arch/ppc/kernel/misc.S         |   13 ++++++-----
>  arch/ppc/kernel/vmlinux.lds.S  |   15 +++++++-----
>  include/asm-ppc/page.h         |    6 ++++-
>  include/asm-ppc/ppc_page_asm.h |   49 ++++++++++++++++++++++++++++++++++++++++

I though we'd given up on arch/ppc by now?
Can you try to redo this over the arch/powerpc/ 44x port?
