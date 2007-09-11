Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5EA13DDF1B
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 03:48:54 +1000 (EST)
Message-ID: <46E6D4D4.2050600@freescale.com>
Date: Tue, 11 Sep 2007 12:48:04 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] [POWERPC] 85xx: Add basic Uniprocessor MPC8572 DS port
References: <Pine.LNX.4.64.0709110128040.27648@blarg.am.freescale.net>
	<20070911141821.GA32545@lixom.net>
	<230A7A2A-3184-4BC2-B8AC-C94090B532B0@kernel.crashing.org>
	<20070911155558.GA10743@lixom.net>
	<11B85E70-D643-4013-A9B3-59CD76F9D7AB@kernel.crashing.org>
	<20070911171521.GB10743@lixom.net> <46E6CE9A.8080402@freescale.com>
	<20070911173308.GA11951@lixom.net>
In-Reply-To: <20070911173308.GA11951@lixom.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:
> On Tue, Sep 11, 2007 at 12:21:30PM -0500, Scott Wood wrote:
>> Olof Johansson wrote:
>>> On Tue, Sep 11, 2007 at 11:00:28AM -0500, Kumar Gala wrote:
>>>> well the ifdefs are orthogonal.  We don't have a way of knowing  
>>>> primary from the device tree today.
>>> How about something like "fsl,primary-phb" in the bus device node? I don't
>>> know, maybe it's already been discussed and turned down for some reason.
>> It's more of a Linux issue than anything to do with the hardware.
> 
> That doesn't stop firmware from telling linux which bus is the primary
> one on the system to help out.

The entire notion of a "primary" PCI bus is due to a Linux flaw.

If we did put it in the device tree, it should be something like 
"linux,primary-phb".  But since Linux can tell from the node's children, 
there doesn't seem to be much point.

-Scott
