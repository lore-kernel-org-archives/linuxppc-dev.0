Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id D15B5B6F05
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 18 Dec 2009 19:25:24 +1100 (EST)
Message-ID: <4B2B3C3D.4090308@grandegger.com>
Date: Fri, 18 Dec 2009 09:24:29 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: Roman Fietze <roman.fietze@telemotive.de>
Subject: Re: MPC5200B XLB Configuration Issues, FEC RFIFO Events, ATA Crashes
References: <200912091529.13913.roman.fietze@telemotive.de>	<20091209145748.GB3112@pengutronix.de>
	<200912161237.09796.roman.fietze@telemotive.de>
In-Reply-To: <200912161237.09796.roman.fietze@telemotive.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Roman Fietze wrote:
> Hello Wolfram,
> 
> On Wednesday 09 December 2009 15:57:48 Wolfram Sang wrote:
> 
>> Do you have a way to measure performance penalties?
> 
> As I said, I do.
> 
> And here they are. They won't win a price for the most impartial
> benchmarks ever seen, but thet'll be a good starting point to get a
> feeling what stability might cost.
> 
> The board is using the MPC5200B on a board derived from the old
> lite5200, but with the fixes for the MPC5200B. All tests are run using
> an ST940813AM hard drive with an ext2 and an ext3 of 10GB each,
> default mkfs options. The OS is Debian 4.0. The network connection is
> between a fast Athlon XP2 6400 and the target, using 100MBit/s wiring
> and a 100MBit/s switch.
> 
> The F always stands for fast settings, coherent cache, XLB features
> like snooping, etc. turned on, XLB config 0x0000a006 or 0x0001a006
> (makes no or no big difference).
> 
> The S always stands for slow settings, non coherent cache, XLB
> features like snooping, etc. turned on, XLB config 0x80012006.

What disc access modes, (pio, mwdma or udma) did you use for these tests.

Wolfgang.
