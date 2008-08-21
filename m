Return-Path: <jwboyer@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.243])
	by ozlabs.org (Postfix) with ESMTP id 11DD9DE973
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 21:55:54 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so236299anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 04:55:53 -0700 (PDT)
Subject: Re: [PATCH] add a simple 405EP based board
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Markus Brunner <super.firetwister@googlemail.com>
In-Reply-To: <200808211007.59965.super.firetwister@gmail.com>
References: <200808211007.59965.super.firetwister@gmail.com>
Content-Type: text/plain
Date: Thu, 21 Aug 2008 07:55:27 -0400
Message-Id: <1219319729.26429.40.camel@jdub.homelinux.org>
Mime-Version: 1.0
Sender: Josh Boyer <jwboyer@gmail.com>
Cc: linuxppc-dev@ozlabs.org
Reply-To: jwboyer@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-08-21 at 10:07 +0200, Markus Brunner wrote:
> This adds support for a simple ppc405ep board. 
> At the moment, there are no 405ep boards in arch/powerpc, so this can be used as a template
> for new boards, or migrating them from arch/ppc.
> I2c, UART and EMAC are working. PCI could not be tested, so it was not included in the dts.

I plan on adding more 405 board support very soon.  When I do, it'll be
along the lines of the patch series I just sent out for 44x.  There's
really no reason to have a per CPU/board file if we can avoid it.

Your code is simple enough overall, so I might even use it as a starting
point.  If I do, I'll certainly give you credit.  Though it's incomplete
in that you have a DTS that requires something to poke values into it,
and nothing readily apparent to do so.  A cuImage wrapper is probably
warranted here.

josh
