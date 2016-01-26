Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2E9191A02EA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 01:00:31 +1100 (AEDT)
Date: Tue, 26 Jan 2016 15:00:27 +0100
From: Torsten Duwe <duwe@lst.de>
To: Miroslav Benes <mbenes@suse.cz>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Jiri Kosina <jkosina@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 live-patching@vger.kernel.org, pmladek@suse.cz
Subject: Re: [PATCH v6 8/9] Implement kernel live patching for ppc64le (ABIv2)
Message-ID: <20160126140027.GB28664@lst.de>
References: <20160125170459.14DB7692CE@newverein.lst.de>
 <20160125170804.A11DB692DD@newverein.lst.de>
 <alpine.LNX.2.00.1601261142190.24510@pobox.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.LNX.2.00.1601261142190.24510@pobox.suse.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jan 26, 2016 at 11:50:25AM +0100, Miroslav Benes wrote:
> > + */
> > +int klp_write_module_reloc(struct module *mod, unsigned long type,
> > +			    unsigned long loc, unsigned long value)
> > +{
> > +	/* This requires infrastructure changes; we need the loadinfos. */
> > +	pr_err("lpc_write_module_reloc not yet supported\n");
> 
> This is a nit, but there is no lpc_write_module_reloc. It should be 
> klp_write_module_reloc.

Indeed. Michael, feel free to fix this on the fly or not. It needs to
disappear anyway and be replaced with functionality.

	Torsten
