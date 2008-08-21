Return-Path: <jwboyer@gmail.com>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.228])
	by ozlabs.org (Postfix) with ESMTP id B3B8CDDFED
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 02:10:43 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id c48so55260wra.1
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 09:10:41 -0700 (PDT)
Subject: Re: [PATCH] add a simple 405EP based board
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Arnd Bergmann <arnd@arndb.de>
In-Reply-To: <200808211542.38395.arnd@arndb.de>
References: <200808211007.59965.super.firetwister@gmail.com>
	<1219319729.26429.40.camel@jdub.homelinux.org>
	<200808211542.38395.arnd@arndb.de>
Content-Type: text/plain
Date: Thu, 21 Aug 2008 12:10:06 -0400
Message-Id: <1219335007.26429.51.camel@jdub.homelinux.org>
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: Markus Brunner <super.firetwister@googlemail.com>, linuxppc-dev@ozlabs.org
Reply-To: jwboyer@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-08-21 at 15:42 +0200, Arnd Bergmann wrote:
> On Thursday 21 August 2008, Josh Boyer wrote:
> > On Thu, 2008-08-21 at 10:07 +0200, Markus Brunner wrote:
> > > This adds support for a simple ppc405ep board. 
> > > At the moment, there are no 405ep boards in arch/powerpc, so this can be used as a template
> > > for new boards, or migrating them from arch/ppc.
> > > I2c, UART and EMAC are working. PCI could not be tested, so it was not included in the dts.
> > 
> > I plan on adding more 405 board support very soon.  When I do, it'll be
> > along the lines of the patch series I just sent out for 44x.  There's
> > really no reason to have a per CPU/board file if we can avoid it.
> > 
> 
> This may be a stupid question, but is there really a reason to keep 40x and 44x
> setup files separate? AFAICT, the ppc_md structures are the same, so even you
> can never have a common binary between 40x and 44x, you may have the same platform
> file.

arch/ppc had them all lumped under platforms/4xx, but this was split in
the original arch/powerpc port when arch/powerpc/platforms/44x was
created.  That left arch/powerpc/platforms/4xx for 40x which didn't
really make sense, so it was renamed to 40x.  

I can understand why, as they are really two different platforms.  So
logically it makes sense to have them separate.  I'm not overly
motivated to convert it back to the old way but I might be able to be
convinced.

josh
