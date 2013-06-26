Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EDB142C007C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jun 2013 07:56:50 +1000 (EST)
Message-ID: <1372283780.18612.31.camel@pasglop>
Subject: Re: linux-next: manual merge of the akpm tree with the powerpc tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Oleg Nesterov <oleg@redhat.com>
Date: Thu, 27 Jun 2013 07:56:20 +1000
In-Reply-To: <20130626141916.GA30716@redhat.com>
References: <20130626165642.8740ecb6d5d5882b06f173c8@canb.auug.org.au>
 <1372234231.18612.6.camel@pasglop> <20130626141916.GA30716@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Michael Neuling <mikey@neuling.org>, linux-kernel@vger.kernel.org,
 linux-next@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-06-26 at 16:19 +0200, Oleg Nesterov wrote:
> 
> You were cc'ed every time ;)
> 
> > Why didn't it go through the powerpc tree ?
> 
> Because this series needs to update any user of
> ptrace_get/put_breakpoints
> in arch/ (simply remove these calls), then change the core kernel
> code, then
> fix arch/86.

That's fine. I didn't realize that was a series, thought it was a
standalone patch I had missed.

Ben.
