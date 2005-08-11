Return-Path: <dan@embeddededge.com>
In-Reply-To: <DE2CC80C-91A2-4860-B452-6AD171F3588A@freescale.com>
References: <20050811201821.GY3187@smtp.west.cox.net>
	<DE2CC80C-91A2-4860-B452-6AD171F3588A@freescale.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c74341910a387ed9114187e7af1661e0@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 11 Aug 2005 19:29:57 -0400
To: Kumar Gala <kumar.gala@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Gill Becky-BGILL <becky.bruce@freescale.com>,
	linuxppc64-dev@ozlabs.org, Tom Rini <trini@kernel.crashing.org>
Subject: Re: RFC: proposed arch/powerpc directory structure
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 11, 2005, at 7:07 PM, Kumar Gala wrote:

> ......  The idea being that we might be able to build kernels in 
> either directory that supported a large number of boards with one 
> image.

Please don't go there :-)  I'm having enough trouble meeting reasonable
performance goals in 2.6 on embedded systems that I don't need the 
overhead
of code bloat or extra cycles to determine what board I'm on.  Contrary 
to
the belief of developers, products don't have the resource wealth we see
on these evaluation and ODM boards.  Embedded products still require
we build kernels (and everything else) as concisely and efficient as 
possible.

Thanks.

	-- Dan
