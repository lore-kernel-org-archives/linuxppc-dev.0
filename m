Return-Path: <trini@kernel.crashing.org>
Date: Thu, 11 Aug 2005 16:19:48 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kumar Gala <kumar.gala@freescale.com>
Message-ID: <20050811231948.GA3187@smtp.west.cox.net>
References: <20050811201821.GY3187@smtp.west.cox.net>
	<DE2CC80C-91A2-4860-B452-6AD171F3588A@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <DE2CC80C-91A2-4860-B452-6AD171F3588A@freescale.com>
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

On Thu, Aug 11, 2005 at 06:07:03PM -0500, Kumar Gala wrote:
[snip]
> I think this causes confusion.  the reason we suggested pq2 and  
> classic32 was to handle things like sandpoint.  Sandpoint would live  
> in classic32.  The confusion partial comes from the fact that we can  
> run 8240/1/5 on a Sandpoint.  The thinking was everything that was  
> 6xx/7xx/74xx + things like 8240/1/5 which can be thought of as 603 +  
> 10x bridge would be classic32.

Thanks for the explanation.  But I think this is overkill for the
sandpoint or true like a sandpoint (Zynx something, Willow, neither of
which are in the kernel tree).  I think we can field the "I wanna hack
on my Sandpoint/8240, but don't see the code under 82xx/!" question. :)

> If it was 82xx w/o a CPM it went into classic32.  If it was a 82xx w/ 
> CPM it went into pq2.  The idea being that we might be able to build  
> kernels in either directory that supported a large number of boards  
> with one image.

We can certainly investigate just how many distinct boards can be
supported with one image when infos are passed dynamically.  If we can
simplify things enough, maybe we can break the rule of no .[ch] files in
arch/powerpc/platforms since it'll just be 82xx.[ch], 83xx.[ch] and so
on, execept for that damn pmac. ;)

-- 
Tom Rini
http://gate.crashing.org/~trini/
