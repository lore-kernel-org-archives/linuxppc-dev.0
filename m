Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 84DD367B1E
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Feb 2006 06:54:47 +1100 (EST)
Date: Tue, 14 Feb 2006 20:54:42 +0100
From: Christoph Hellwig <hch@lst.de>
To: Olaf Hering <olh@suse.de>
Subject: Re: [PATCH] kprobes depends on xmon
Message-ID: <20060214195442.GA21583@lst.de>
References: <20060214131050.GA25820@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060214131050.GA25820@suse.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 14, 2006 at 02:10:50PM +0100, Olaf Hering wrote:
> 
> KPROBES depends on XMON.
> arch/powerpc/lib/step.c is only compiled if CONFIG_XMON is enabled.
> 
> arch/powerpc/kernel/built-in.o:
> In function `resume_execution':arch/powerpc/kernel/kprobes.c:331: undefined reference to
> `.emulate_step'

Please compile step.o if either CONFIG_KPROBES or CONFIG_XMON is defined
instead of adding a depency.
