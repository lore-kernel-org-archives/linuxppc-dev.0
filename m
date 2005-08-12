Return-Path: <trini@kernel.crashing.org>
Date: Thu, 11 Aug 2005 20:38:50 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20050812033850.GB3187@smtp.west.cox.net>
References: <20050811231948.GA3187@smtp.west.cox.net>
	<9C2E830E-288C-4373-BDE3-49C5FE47A01C@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9C2E830E-288C-4373-BDE3-49C5FE47A01C@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Gill Becky-BGILL <becky.bruce@freescale.com>,
	linuxppc64-dev@ozlabs.org
Subject: Re: RFC: proposed arch/powerpc directory structure
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 11, 2005 at 09:34:57PM -0500, Kumar Gala wrote:
> 
> On Aug 11, 2005, at 6:19 PM, Tom Rini wrote:
> 
> >On Thu, Aug 11, 2005 at 06:07:03PM -0500, Kumar Gala wrote:
> >[snip]
> >
> >>I think this causes confusion.  the reason we suggested pq2 and
> >>classic32 was to handle things like sandpoint.  Sandpoint would live
> >>in classic32.  The confusion partial comes from the fact that we can
> >>run 8240/1/5 on a Sandpoint.  The thinking was everything that was
> >>6xx/7xx/74xx + things like 8240/1/5 which can be thought of as 603 +
> >>10x bridge would be classic32.
> >>
> >
> >Thanks for the explanation.  But I think this is overkill for the
> >sandpoint or true like a sandpoint (Zynx something, Willow, neither of
> >which are in the kernel tree).  I think we can field the "I wanna hack
> >on my Sandpoint/8240, but don't see the code under 82xx/!"  
> >question. :)
> 
> So where do you suggest Sandpoint goes in this directory structure?

classic32/

-- 
Tom Rini
http://gate.crashing.org/~trini/
