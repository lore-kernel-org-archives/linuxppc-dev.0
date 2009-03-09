Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id CE634DDFCA
	for <linuxppc-dev@ozlabs.org>; Mon,  9 Mar 2009 21:53:29 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1Lgd6r-0000lh-Uu
	for linuxppc-dev@ozlabs.org; Mon, 09 Mar 2009 03:53:25 -0700
Message-ID: <22410889.post@talk.nabble.com>
Date: Mon, 9 Mar 2009 03:53:25 -0700 (PDT)
From: Felix Radensky <felix@embedded-sol.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: Machine check in 4xx ethernet driver
In-Reply-To: <20090309103820.GA17943@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <22408005.post@talk.nabble.com>
	<20090309103820.GA17943@zod.rchland.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>




Josh Boyer-4 wrote:
> 
> On Mon, Mar 09, 2009 at 12:47:02AM -0700, Felix Radensky wrote:
>>
>>Hi,
>>
>>I'm getting machine check exception when trying to dump
>>emac registers on 405EX Kilauea board. The kernel is 2.6.29-rc7
>>The problem seems not new, I can reproduce it on 2.6.25 Denx kernel
> 
> I've not looked at what that code path does, but the EMAC regs are
> in DCR space, not MMIO.  Using memcpy_fromio there seems odd.
> 
> 

At least on 405EX MAL registers are in DCR space, but EMAC and RGMII
ones are in MMIO space.

-- 
View this message in context: http://www.nabble.com/Machine-check-in-4xx-ethernet-driver-tp22408005p22410889.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
