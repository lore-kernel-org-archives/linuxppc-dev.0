Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 0FC48DE22B
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 01:40:06 +1000 (EST)
Date: Mon, 14 Apr 2008 11:40:04 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: Laurent Pinchart <laurentp@cse-semaphore.com>
Subject: Re: [PATCH 5/5] WDT driver
Message-ID: <20080414114004.522bf7f6@lappy.seanm.ca>
In-Reply-To: <200804141033.29929.laurentp@cse-semaphore.com>
References: <20080412134831.424480cf@lappy.seanm.ca>
	<20080412141146.3050e521@lappy.seanm.ca>
	<200804141033.29929.laurentp@cse-semaphore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 14 Apr 2008 10:33:27 +0200
Laurent Pinchart <laurentp@cse-semaphore.com> wrote:

> What about
> 
> setbits32((u32 __iomem *)(pikawdt_fpga + 0x14), 0xf80);

Nice! I didn't know about that call. Thanks.

Cheers,
  Sean
