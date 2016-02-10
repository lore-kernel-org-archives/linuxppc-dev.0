Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0BA121A03B1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Feb 2016 05:03:26 +1100 (AEDT)
Date: Wed, 10 Feb 2016 19:03:21 +0100
From: Torsten Duwe <duwe@lst.de>
To: Denis Kirjanov <kda@linux-powerpc.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Jiri Kosina <jkosina@suse.cz>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, live-patching@vger.kernel.org
Subject: Re: [PATCH v6 8/9] Implement kernel live patching for ppc64le (ABIv2)
Message-ID: <20160210180321.GC19199@lst.de>
References: <20160125170459.14DB7692CE@newverein.lst.de>
 <20160125170804.A11DB692DD@newverein.lst.de>
 <CAOJe8K2eABAD4rmuE8nKg6QSCAS68Dba_pHQkbcLuNX9y=qR2A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAOJe8K2eABAD4rmuE8nKg6QSCAS68Dba_pHQkbcLuNX9y=qR2A@mail.gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 02, 2016 at 04:46:27PM +0300, Denis Kirjanov wrote:
> > +
> > +#ifdef CONFIG_LIVEPATCH
> > +static inline int klp_check_compiler_support(void)
> > +{
> > +#if !defined(_CALL_ELF) || _CALL_ELF != 2 ||
> > !defined(CC_USING_MPROFILE_KERNEL)
> > +	return 1;
> > +#endif
> > +	return 0;
> > +}
> This function can be boolean.

Yes, like on the other archs, too.

	Torsten
