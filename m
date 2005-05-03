Return-Path: <akpm@osdl.org>
Received: from smtp.osdl.org (fire.osdl.org [65.172.181.4])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "smtp.osdl.org", Issuer "OSDL Hostmaster" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 359A5679F9
	for <linuxppc-dev@ozlabs.org>; Tue,  3 May 2005 11:38:06 +1000 (EST)
Date: Mon, 2 May 2005 18:37:33 -0700
From: Andrew Morton <akpm@osdl.org>
To: David Woodhouse <dwmw2@infradead.org>
Message-Id: <20050502183733.52db7703.akpm@osdl.org>
In-Reply-To: <1115020651.3287.0.camel@localhost.localdomain>
References: <1115020651.3287.0.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] ppc32: platform-specific functions missing from
 kallsyms.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Woodhouse <dwmw2@infradead.org> wrote:
>
> The PPC32 kernel puts platform-specific functions into separate sections
>  so that unneeded parts of it can be freed when we've booted and actually
>  worked out what we're running on today. 
> 
>  This makes kallsyms ignore those functions, because they're not between
>  _[se]text or _[se]inittext. Rather than teaching kallsyms about the
>  various pmac/chrp/etc sections, this patch adds '_[se]extratext' markers
>  for kallsyms.
> 

Current kernels have fixes in exactly this area.  Please redo, retest, resend.

> 
>  --- linux-2.6.11/arch/ppc/kernel/vmlinux.lds~	2005-05-01 10:43:10.000000000 +0100
>  +++ linux-2.6.11/arch/ppc/kernel/vmlinux.lds	2005-05-02 08:06:52.000000000 +0100

2.6.11?  Wow.
