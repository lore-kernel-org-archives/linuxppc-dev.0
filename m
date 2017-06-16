Return-Path: <sfr@canb.auug.org.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wpmCt5rVHzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Jun 2017 13:32:58 +1000 (AEST)
Date: Fri, 16 Jun 2017 13:32:58 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Rowand, Frank" <Frank.Rowand@sony.com>, Abdul Haleem
 <abdhalee@linux.vnet.ibm.com>, sachinp <sachinp@linux.vnet.ibm.com>,
 linux-next <linux-next@vger.kernel.org>, linux-kernel
 <linux-kernel@vger.kernel.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, Rob Herring  <robh@kernel.org>
Subject: Re: [Oops][next-20170614][] powerpc boot fails with WARNING: CPU:
 12 PID: 0 at mm/memblock.c
Message-ID: <20170616133258.74900bc3@canb.auug.org.au>
In-Reply-To: <20170616111335.4e1a818a@canb.auug.org.au>
References: <1497506437.15415.60.camel@abdul.in.ibm.com>
 <1497518696.15415.68.camel@abdul.in.ibm.com>
 <ED290C750E1B324E972B0017C9D4BAB02E5A7EAF@USCULXMSG03.am.sony.com>
 <87injwwxzh.fsf@concordia.ellerman.id.au>
 <20170616111335.4e1a818a@canb.auug.org.au>
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

Hi all,

On Fri, 16 Jun 2017 11:13:35 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> On Fri, 16 Jun 2017 10:57:22 +1000 Michael Ellerman <mpe@ellerman.id.au> wrote:
> >
> > "Rowand, Frank" <Frank.Rowand@sony.com> writes:
> >   
> > > On Thursday, June 15, 2017 2:25 AM, Abdul Haleem [mailto:abdhalee@linux.vnet.ibm.com]  wrote:    
> > >>
> > >> On Thu, 2017-06-15 at 11:30 +0530, Abdul Haleem wrote:    
> > >>>
> > >>> linux-next fails to boot on powerpc Bare-metal with these warnings.
> > >>>
> > >>> machine booted fine on next-20170613    
> > >>
> > >> Thanks Michael, Yes it is (75fe04e59 of: remove *phandle properties from
> > >> expanded device tree)
> > >>
> > >> Frank, would you please take a look at the trace.
> > >>
> > >> Thanks    
> > >
> > > < snip >
> > >
> > > My patch series 'of: remove *phandle properties from expanded device tree'
> > > in -next seems to have broken boot for a significant number of powerpc
> > > systems.  I am actively working on understanding and fixing the problem.    
> > 
> > Thanks.
> > 
> > At least for me reverting that patch on top of linux-next gets things
> > booting again.
> > 
> > Stephen can you revert that patch in linux-next today?  
> 
> OK.

Actually, Rob removed it from his tree before I merged it.

-- 
Cheers,
Stephen Rothwell
