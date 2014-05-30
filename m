Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 66C511A06C7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 May 2014 16:06:34 +1000 (EST)
Message-ID: <1401429993.29324.5.camel@concordia>
Subject: Re: [PATCH] powerpc: Remove platforms/wsp and associated pieces
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 30 May 2014 16:06:33 +1000
In-Reply-To: <20140529193252.05902952@canb.auug.org.au>
References: <1401353429-29036-1-git-send-email-mpe@ellerman.id.au>
 <20140529193252.05902952@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, pebolle@tiscali.nl
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-05-29 at 19:32 +1000, Stephen Rothwell wrote:
> Hi Michael,
> 
> On Thu, 29 May 2014 18:50:29 +1000 Michael Ellerman <mpe@ellerman.id.au> wrote:
> >
> > __attribute__ ((unused))
> > 
> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> So this was the only use of CONFIG_PPC_A2 ... so more cleanup
> possible :-)
> 
> I always appreciate negative work :-)

Hmm, yeah, well spotted.

I'll send another patch.

cheers
