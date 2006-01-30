Return-Path: <trini@kernel.crashing.org>
Received: from fed1rmmtao11.cox.net (fed1rmmtao11.cox.net [68.230.241.28])
	by ozlabs.org (Postfix) with ESMTP id 70EF1689FD
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 31 Jan 2006 04:28:52 +1100 (EST)
Date: Mon, 30 Jan 2006 10:28:51 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Laurent Pinchart <laurent.pinchart@tbox.biz>
Subject: Re: [RFC] arch/ppc/boot/simple/embed_boot.c : Merging all keyvals
	parsing code
Message-ID: <20060130172851.GF22672@smtp.west.cox.net>
References: <200601251215.10816.laurent.pinchart@tbox.biz>
	<bc2424c0c5f69931784ea76791f8ee39@embeddedalley.com>
	<200601251702.20332.laurent.pinchart@tbox.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200601251702.20332.laurent.pinchart@tbox.biz>
Cc: Dan Malek <dan@embeddedalley.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Jan 25, 2006 at 05:02:20PM +0100, Laurent Pinchart wrote:
> > > Should I submit a patch, or leave the code as it is ?
> >
> > Port Das U-Boot.
> 
> Of course, that's another solution. We will use Das U-Boot for our custom 
> design.
> 
> What I wanted to do here is completely different. As the board comes with a 
> proprietary boot loader, I thought it would be interesting for future users 
> to have the board supported in the vanilla kernel, like many other boards 
> are. Is that a mistake ?

No, that's good.  If you can cleanly merge the existing parsing code, by
all means please do so.  Thanks.

-- 
Tom Rini
http://gate.crashing.org/~trini/
