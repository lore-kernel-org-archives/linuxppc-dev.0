Return-Path: <mbenes@suse.cz>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7FB4E1A02EA
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jan 2016 01:14:21 +1100 (AEDT)
Date: Tue, 26 Jan 2016 15:14:16 +0100 (CET)
From: Miroslav Benes <mbenes@suse.cz>
To: Torsten Duwe <duwe@lst.de>
cc: Steven Rostedt <rostedt@goodmis.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Jiri Kosina <jkosina@suse.cz>,
 linuxppc-dev@lists.ozlabs.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 live-patching@vger.kernel.org, pmladek@suse.cz, jeyu@redhat.com
Subject: Re: [PATCH v6 8/9] Implement kernel live patching for ppc64le (ABIv2)
In-Reply-To: <20160126140027.GB28664@lst.de>
Message-ID: <alpine.LNX.2.00.1601261510550.24510@pobox.suse.cz>
References: <20160125170459.14DB7692CE@newverein.lst.de>
 <20160125170804.A11DB692DD@newverein.lst.de>
 <alpine.LNX.2.00.1601261142190.24510@pobox.suse.cz>
 <20160126140027.GB28664@lst.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


[ Jessica added to CC list so she is aware that there are plans to 
implement livepatch on ppc64le ]

On Tue, 26 Jan 2016, Torsten Duwe wrote:

> On Tue, Jan 26, 2016 at 11:50:25AM +0100, Miroslav Benes wrote:
> > > + */
> > > +int klp_write_module_reloc(struct module *mod, unsigned long type,
> > > +			    unsigned long loc, unsigned long value)
> > > +{
> > > +	/* This requires infrastructure changes; we need the loadinfos. */
> > > +	pr_err("lpc_write_module_reloc not yet supported\n");
> > 
> > This is a nit, but there is no lpc_write_module_reloc. It should be 
> > klp_write_module_reloc.
> 
> Indeed. Michael, feel free to fix this on the fly or not. It needs to
> disappear anyway and be replaced with functionality.

Or not at all thanks to Jessica's effort [1].

Miroslav

[1] http://lkml.kernel.org/g/1452281304-28618-1-git-send-email-jeyu@redhat.com
