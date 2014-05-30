Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 17A8E1A06CB
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 30 May 2014 16:07:11 +1000 (EST)
Message-ID: <1401430030.29324.6.camel@concordia>
Subject: Re: [PATCH] powerpc: Remove platforms/wsp and associated pieces
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 30 May 2014 16:07:10 +1000
In-Reply-To: <20140529193950.2d6f788d@canb.auug.org.au>
References: <1401353429-29036-1-git-send-email-mpe@ellerman.id.au>
 <20140529193252.05902952@canb.auug.org.au>
 <20140529193950.2d6f788d@canb.auug.org.au>
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

On Thu, 2014-05-29 at 19:39 +1000, Stephen Rothwell wrote:
> Hi Michael,
> 
> On Thu, 29 May 2014 19:32:52 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > On Thu, 29 May 2014 18:50:29 +1000 Michael Ellerman <mpe@ellerman.id.au> wrote:
> > >
> > > __attribute__ ((unused))
> > > 
> > > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> > 
> > So this was the only use of CONFIG_PPC_A2 ... so more cleanup
> > possible :-)
> 
> And also seems to be the only thing that selects CONFIG_PPC_ICSWX.
> However, this is user selectable ...

Yeah, that in theory works on Power7. I'm not sure it ever got used though.
Will have to think about it a bit more.

cheers
