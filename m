Date: Mon, 10 May 2004 11:42:40 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Olaf Hering <olh@suse.de>
Cc: akpm@osdl.org, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	linuxppc-dev@lists.linuxppc.org, Paul Mackeras <paulus@samba.org>
Subject: Re: [PATCH] export clear_pages on ppc32
Message-ID: <20040510184240.GB2196@smtp.west.cox.net>
References: <20040510153624.GA9214@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040510153624.GA9214@suse.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, May 10, 2004 at 05:36:24PM +0200, Olaf Hering wrote:

>
> ext3 as module is not possible in 2.6.6, clear_pages, called from
> clear_page, is not exported.
>
>
> --- ./arch/ppc/kernel/ppc_ksyms.c~      2004-05-10 04:33:19.000000000 +0200
> +++ ./arch/ppc/kernel/ppc_ksyms.c       2004-05-10 17:32:17.663513410 +0200
> @@ -73,6 +73,7 @@ int abs(int);
>  extern unsigned long mm_ptov (unsigned long paddr);
>
>  EXPORT_SYMBOL(clear_page);
> +EXPORT_SYMBOL(clear_pages);
>  EXPORT_SYMBOL(clear_user_page);
>  EXPORT_SYMBOL(do_signal);
>  EXPORT_SYMBOL(do_syscall_trace);

Where are clean_page and clear_pages defined?  They should both be
exported there.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
