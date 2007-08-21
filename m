Return-Path: <scottwood@freescale.com>
Message-ID: <46CB10C5.2090405@freescale.com>
Date: Tue, 21 Aug 2007 11:20:21 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 12/20] bootwrapper: Add 8xx cuboot support.
References: <20070820173920.GA30546@ld0162-tx32.am.freescale.net>
	<20070820174001.GK30562@ld0162-tx32.am.freescale.net>
	<20070821024432.GL15469@localhost.localdomain>
In-Reply-To: <20070821024432.GL15469@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Mon, Aug 20, 2007 at 12:40:01PM -0500, Scott Wood wrote:
> 
>>This allows booting on legacy, non-device-tree aware versions of
>>U-boot.
> 
> 
> Is this really sufficient for all 8xx platforms?

It should be enough for all u-boot-based 8xx boards, barring some u-boot 
which needs special fixups (as is done in cuboot-pq2.c).  If such a need 
arises, they can be added to cuboot-8xx.c (if they're generic enough to 
work on all boards, even if not actually needed) or to a board-specific 
platform file (which can coexist just fine with the generic 8xx one).

-Scott
