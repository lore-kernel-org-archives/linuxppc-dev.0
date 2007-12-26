Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id A2232DDDEA
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Dec 2007 13:11:13 +1100 (EST)
Date: Tue, 25 Dec 2007 20:18:23 -0600
From: Olof Johansson <olof@lixom.net>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] Add information on enabling sound on the MPC8641 HPCN
Message-ID: <20071226021823.GA28651@lixom.net>
References: <11983809443854-git-send-email-timur@freescale.com>
	<20071223152613.GA4817@lixom.net> <476FEB43.8050507@freescale.com>
	<20071224231042.GA4588@lixom.net> <47716B3A.9050008@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <47716B3A.9050008@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Dec 25, 2007 at 02:42:34PM -0600, Timur Tabi wrote:
> Olof Johansson wrote:
>
>> Are freescale customers really used to going to the linux device tree
>> sources to find out how to modify their boards to achieve certain
>> functionality with their eval boards?! I guess you guys are taking the
>> "device trees are used to describe the hardware" statement to it's
>> fullest extent.
>
> Well, I've always been a rebel.
>
> Honestly, I just thought it would be harmless and a lot easier (for me) 
> than trying to convince some documentation dude to write it up and publish 
> it.

Heh. Well, it's up to Kumar what to do about this one upstream, it
just seemed like a weird choice to document board reworks in the device
tree comments.

Having it somewhere that sticks to google's database is better than
nothing at all, I suppose. :)


-Olof
