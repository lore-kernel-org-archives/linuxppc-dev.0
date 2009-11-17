Return-Path: <fthain@telegraphics.com.au>
Received: from mail.telegraphics.com.au (www.telegraphics.com.au
	[204.15.192.19]) by ozlabs.org (Postfix) with ESMTP id 74BBEB7093
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 15:58:39 +1100 (EST)
Date: Tue, 17 Nov 2009 15:58:33 +1100 (EST)
From: Finn Thain <fthain@telegraphics.com.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/13] pmac-zilog: cleanup
In-Reply-To: <1258423668.2140.557.camel@pasglop>
Message-ID: <alpine.OSX.2.00.0911171521240.371@silk.local>
References: <alpine.OSX.2.00.0911031441280.483@silk.local>
	<1258423668.2140.557.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-m68k@vger.kernel.org,
	Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Ben,

On Tue, 17 Nov 2009, Benjamin Herrenschmidt wrote:

> On Wed, 2009-11-04 at 00:40 +1100, Finn Thain wrote:
> > Whitespace cleanups and comment typo fix.
> > 
> > Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Hi Finn. Do you want me to carry and merge those patches via the powerpc 
> tree ?

The CUDA changes are probably detrimental without the macfb changes. The 
m68k side of the pmac-zilog patch won't apply without a patch earlier in 
the series, and the pmac-zilog changes as a whole are no use without that.
So I think it is best if Geert merges them with your acked-by, once they 
pass review.

Finn

> 
> Cheers,
> Ben.
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-m68k" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
