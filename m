Return-Path: <a.othieno@bluewin.ch>
Received: from mail15.bluewin.ch (mail15.bluewin.ch [195.186.18.63])
	by ozlabs.org (Postfix) with ESMTP id A0C1067E8D
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 15 Aug 2005 02:58:29 +1000 (EST)
Date: Sun, 14 Aug 2005 12:36:16 -0400
To: Shawn Jin <shawnxjin@gmail.com>
Message-ID: <20050814163616.GA2726@mars>
References: <c3d0340b0508121811e7b6fc2@mail.gmail.com>
	<20050812203335.K30033@cox.net>
	<c3d0340b0508132056651e8c97@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <c3d0340b0508132056651e8c97@mail.gmail.com>
From: a.othieno@bluewin.ch (Arthur Othieno)
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: writel(), readl() in <asm-ppc/io.h>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, Aug 13, 2005 at 08:56:50PM -0700, Shawn Jin wrote:
> > read*()/write*() are accessors for PCI and PCI only.  PCI is little
> 
> If read*()/write*() are designed for PCI access only as you claimed,
> that explains why they call in/out_leXX() funcitons.
> 
> The problem is that read*()/write*() are misused in some places, e.g.,
> serial drivers such as serial8250. The serial_in() and serial_out()
> call read*() and write*() respectively. So what's your recommendation
> in such a case?
 
See here for the gory details:

  http://lwn.net/Articles/102232/
  http://lwn.net/Articles/132804/

	Arthur
