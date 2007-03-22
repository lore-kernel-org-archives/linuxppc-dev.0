Return-Path: <domen.puncer@telargo.com>
Received: from out002.atlarge.net (out002.atlarge.net [129.41.63.60])
	by ozlabs.org (Postfix) with ESMTP id 2ED95DE1CE
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Mar 2007 18:41:13 +1100 (EST)
Date: Thu, 22 Mar 2007 08:41:09 +0100
From: Domen Puncer <domen.puncer@telargo.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 5/5] lite5200b suspend: low-power mode
Message-ID: <20070322074109.GA4620@moe.telargo.com>
References: <20070315103959.GA22215@moe.telargo.com>
	<20070315104447.GG22215@moe.telargo.com>
	<528646bc0703150709v49af8085p959bd36e0adf1e4a@mail.gmail.com>
	<20070315163648.GG19297@nd47.coderock.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070315163648.GG19297@nd47.coderock.org>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 15/03/07 17:36 +0100, Domen Puncer wrote:
> On 15/03/07 08:09 -0600, Grant Likely wrote:
> > On 3/15/07, Domen Puncer <domen.puncer@telargo.com> wrote:
> ...
> > >+       /* map registers */
> > >+       mbar = ioremap_nocache(0xf0000000, 0x8000);
> > 
> > Magic numbers?  Really?  This should be retrieved from the device
> > tree.  There is always the possibility of mbar getting moved.
> > 
> ...
> > >+       gpw = mbar + 0xc00;
> > >+       bes = mbar + 0x1200;
> > >+       xlb = mbar + 0x1f00;
> > 
> > Again, magic numbers
> 
> Well... the code is only applicable for Lite5200b/mpc5200
> and numbers are from specs.
> And it's shorter than mpc52xx_find_and_map() lines.
> I guess I could rewrite it.

In asm code I need access to SDRAM controller registers (MBAR+0x100).
Do I add an entry to dts, or do you have other suggestions?


	Domen
