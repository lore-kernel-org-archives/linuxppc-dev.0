Return-Path: <scottwood@freescale.com>
Message-ID: <469F7D99.8080303@freescale.com>
Date: Thu, 19 Jul 2007 10:04:57 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH 17/61] bootwrapper: Add 8xx support.
References: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
	<20070718013318.GP15238@ld0162-tx32.am.freescale.net>
	<20070718033026.GG18251@localhost.localdomain>
	<469E3C11.1090809@freescale.com>
	<20070719013230.GB20458@localhost.localdomain>
In-Reply-To: <20070719013230.GB20458@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Wed, Jul 18, 2007 at 11:13:05AM -0500, Scott Wood wrote:
>>Well, no.  Even on a given board, it depends on the version of u-boot.
>>
>>There's nothing after enet1addr that the bootwrapper cares about, 
>>though, so the only harm is if the device tree has a second network 
>>interface but u-boot doesn't know about it, and the bootwrapper ends up 
>>pulling in junk rather than leaving zeroes.
> 
> 
> That sounds like a terribly fragile way of handling things.

Yes, but that's inherent in the way the bd_t is defined.  The robust way 
is to get device tree support into u-boot.

-Scott
