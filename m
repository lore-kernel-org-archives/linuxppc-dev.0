Return-Path: <julia.lawall@lip6.fr>
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xVhJz3lxDzDrG2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 14 Aug 2017 00:41:55 +1000 (AEST)
Date: Sun, 13 Aug 2017 16:41:51 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Joe Perches <joe@perches.com>
cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 kernel-janitors@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] powerpc: store the intended structure
In-Reply-To: <1502635063.8295.1.camel@perches.com>
Message-ID: <alpine.DEB.2.20.1708131640300.2129@hadrien>
References: <1502630663-18599-1-git-send-email-Julia.Lawall@lip6.fr>
 <1502635063.8295.1.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Sun, 13 Aug 2017, Joe Perches wrote:

> On Sun, 2017-08-13 at 15:24 +0200, Julia Lawall wrote:
> > Normally the values in the resource field and the argument to ARRAY_SIZE
> > in the num_resources are the same.  In this case, the value in the reousrce
> > field is the same as the one in the previous platform_device structure, and
> > appears to be a copy-paste error.  Replace the value in the resource field
> > with the argument to the local call to ARRAY_SIZE.
>
> found by a script or eyeballs?

A script that was looking for something else.  But I wrote a script for
this specific issue and this was the only match.  I am currently checking
in a more general way.

julia
