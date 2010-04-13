Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 2E0ABB7C33
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Apr 2010 18:34:00 +1000 (EST)
Date: Tue, 13 Apr 2010 01:34:03 -0700 (PDT)
Message-Id: <20100413.013403.184052247.davem@davemloft.net>
To: grant.likely@secretlab.ca
Subject: Re: [PATCH 2/2] [V5] Add non-Virtex5 support for LL TEMAC driver
From: David Miller <davem@davemloft.net>
In-Reply-To: <x2sfa686aa41004091110l87cd2234rc68906080fc4fe03@mail.gmail.com>
References: <1270746482-29914-1-git-send-email-john.linn@xilinx.com>
	<960dddba-8a63-4480-8245-f06fad59ab36@SG2EHSMHS005.ehs.local>
	<x2sfa686aa41004091110l87cd2234rc68906080fc4fe03@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: eric.dumazet@gmail.com, michal.simek@petalogix.com, netdev@vger.kernel.org,
	jtyner@cs.ucr.edu, linuxppc-dev@ozlabs.org, john.linn@xilinx.com,
	john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>
Date: Fri, 9 Apr 2010 12:10:21 -0600

> On Thu, Apr 8, 2010 at 11:08 AM, John Linn <john.linn@xilinx.com> wrote:
>> This patch adds support for using the LL TEMAC Ethernet driver on
>> non-Virtex 5 platforms by adding support for accessing the Soft DMA
>> registers as if they were memory mapped instead of solely through the
>> DCR's (available on the Virtex 5).
>>
>> The patch also updates the driver so that it runs on the MicroBlaze.
>> The changes were tested on the PowerPC 440, PowerPC 405, and the
>> MicroBlaze platforms.
>>
>> Signed-off-by: John Tyner <jtyner@cs.ucr.edu>
>> Signed-off-by: John Linn <john.linn@xilinx.com>
> 
> Picked up and build tested both patches on 405, 440, 60x and ppc64.
> No build problems found either built-in or as a module.
> 
> for both:
> Acked-by: Grant Likely <grant.likely@secretlab.ca>

Ok, both applied to net-next-2.6, thanks everyone for sorting this
out.
