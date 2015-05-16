Return-Path: <duwe@lst.de>
Received: from newverein.lst.de (verein.lst.de [213.95.11.211])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2DD121A0007
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 May 2015 18:05:39 +1000 (AEST)
Date: Sat, 16 May 2015 10:05:34 +0200
From: Torsten Duwe <duwe@lst.de>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] ppc64 ftrace: mark data_access callees "notrace" (pt.1)
Message-ID: <20150516080534.GA27059@lst.de>
References: <20150513161100.GA1619@lst.de>
 <1431653687.13498.1.camel@ellerman.id.au> <20150515084542.GA20453@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150515084542.GA20453@suse.de>
Cc: ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 15, 2015 at 10:45:42AM +0200, Torsten Duwe wrote:
> On Fri, May 15, 2015 at 11:34:47AM +1000, Michael Ellerman wrote:
> >
> > There's got to be a better solution than this.
>
> Can you think of a better approach?

Maybe a per thread variable to lock out a recursion into tracing?
Thanks for your doubt.

	Torsten
