Return-Path: <scottwood@freescale.com>
Message-ID: <469E6241.5090604@freescale.com>
Date: Wed, 18 Jul 2007 13:56:01 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 10/61] bootwrapper: flatdevtree fixes
References: <9b26986bc99c74c5e17e08191eb07d67@bga.com>
In-Reply-To: <9b26986bc99c74c5e17e08191eb07d67@bga.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Milton Miller wrote:
> In-Reply-To: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
> 
> On Wed Jul 18 11:33:08 EST 2007, Scott Wood wrote:
> 
>> 1. ft_create_node was returning the internal pointer rather than a 
>> phandle.
>> 2. ft_find_device_rel was treating lookups relative to root as an error.
> 
> 
> No, it is treating lookups relative to NULL as an error.
> 
> Your patch changes it to treat lookups relative to the NULL phandle as 
> relative to root.

Other parts of the code (such as ft_create_node) already do that. 
What's wrong with it?

> I've no objections to the other part, can you split these?

No, because change #1 won't work without change #2.

-Scott
