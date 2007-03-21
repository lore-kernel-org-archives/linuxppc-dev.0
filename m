Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AA6FCDDF56
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2007 03:14:50 +1100 (EST)
Date: Wed, 21 Mar 2007 17:14:47 +0100
From: Christoph Hellwig <hch@lst.de>
To: anton@samba.org
Subject: Re: [patch 06/10] Add notify die hooks and remove some redundant
	debugger hooks
Message-ID: <20070321161447.GB17211@lst.de>
References: <20070321013810.404636000@samba.org>
	<20070321013825.283024000@samba.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070321013825.283024000@samba.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Index: linux-2.6/include/asm-powerpc/kdebug.h
> ===================================================================
> --- linux-2.6.orig/include/asm-powerpc/kdebug.h	2007-03-11 12:36:52.000000000 -0500
> +++ linux-2.6/include/asm-powerpc/kdebug.h	2007-03-11 12:37:05.000000000 -0500
> @@ -30,6 +30,7 @@
>  	DIE_BPT,
>  	DIE_SSTEP,
>  	DIE_PAGE_FAULT,
> +	DIE_MACHINE_CHECK,
>  };
>  
>  static inline int notify_die(enum die_val val,char *str,struct pt_regs *regs,long err,int trap, int sig)

this is not around anymore after my patch to move the die notifier to
common code and will need some trivial rediffing.
