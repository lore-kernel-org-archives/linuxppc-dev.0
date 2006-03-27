Return-Path: <siju@india.tejasnetworks.com>
Received: from anche.india.tejasnetworks.com (india.tejasnetworks.com
	[164.164.94.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 15C0B67A63
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 27 Mar 2006 15:51:02 +1100 (EST)
Subject: Re: [BULK]  Re: "transmit timed out" on FCC in MPC8260 => bug
	corrected
From: Siju Viswanath K E <siju@india.tejasnetworks.com>
To: "hubert.loewenguth" <hubert.loewenguth@thales-bm.com>
In-Reply-To: <4423DB92.5070305@thales-bm.com>
References: <20060324075148.4C106353BFB@atlas.denx.de>
	<1143193658.22246.20.camel@Blaze>  <4423DB92.5070305@thales-bm.com>
Content-Type: text/plain
Message-Id: <1143433880.1476.10.camel@Blaze>
Mime-Version: 1.0
Date: 27 Mar 2006 10:01:20 +0530
Cc: "Hunter, David" <David.Hunter@ipc.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks for the patch.. I have implemented the changes but since it is
not very frequent in my case, I dont know whether it works for me yet.

regards,
siju
On Fri, 2006-03-24 at 17:14, hubert.loewenguth wrote:
> Hi to the community.
> 
> I'm the man who has posted numerous questions about this problem of
> fcc_enet timeout in ppc8260.
> I just want to say that the 2.6 kernel doesn't solve the problem if
> you have it on your board (I tried it,  normally I have a 2.4-20 linux
> too).
> I have search for this bug during a long time, and fortunatly, I 'm
> happy to say you that finally, it is corrected since few days. 
> Special thanks to "Hunter, David" for having take in consideration my
> problem, and proposing me some way of invastigations in this thread:
> 
> http://ozlabs.org/pipermail/linuxppc-embedded/2006-January/021842.html
> 
> In fact the solution comes from the new "MPC8260 PowerQUICC II Family
> Reference Manual"   fresescale has delivered 01/19/2006.
> http://www.freescale.com/files/product/doc/MPC8260UM.pdf
