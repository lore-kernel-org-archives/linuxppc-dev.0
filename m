Return-Path: <nvbolhuis@aimvalley.nl>
Received: from smtp-vbr12.xs4all.nl (smtp-vbr12.xs4all.nl [194.109.24.32])
	by ozlabs.org (Postfix) with ESMTP id BAE00DDD0B
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Feb 2009 03:29:18 +1100 (EST)
Message-ID: <49A4205B.30207@aimvalley.nl>
Date: Tue, 24 Feb 2009 17:29:15 +0100
From: Norbert van Bolhuis <nvbolhuis@aimvalley.nl>
MIME-Version: 1.0
To: Eric Cottrell <wb1hbu@runbox.com>
Subject: Re: Can not get "new" MPC8313e-RDB to boot "as-shipped" flash image
References: <E1LbNft-0007z6-Pf@garm.runbox.com> <49A3EBFF.4030906@aimvalley.nl>
	<E1LbyOG-0000uL-Hf@garm.runbox.com>
In-Reply-To: <E1LbyOG-0000uL-Hf@garm.runbox.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Eric,

So it never ever booted properly ?

Hmm, it certainly looks like your distributor (or whoever you got the MPC8313E-RDB
from) lend it out and got a messed up board back. Or maybe they messed it up
themselfes.

Go complain and send it back.

indeed, rev 2.x is better (much less TSEC bugs).

---
N. van Bolhuis.



Eric Cottrell wrote:
> Hello,
> 
> Thanks for the help.  I will look into that.  It is confusing as the latest ltib appears not to have the aliases.  This is my first venture into Embedded Linux as our existing PowerPC products use PSOS.  Most of my Linux experience is on the Intel PC platform.
> 
> Yes, the 1.3.3 version was what was shipped with the board.  The rootfs and kernel appear to be older.  So I suspect someone upgraded the uBoot and ran into trouble.
> 
> I am comparing this with the Rev B board we also got.  I hope to return the Rev A4 and make the boards all Rev B because it has a later processor.  The Rev B boards have 1.3.0 so it should need the aliases as well.  Looking in the uBoot changelogs there are some nice additions and fixes for this board so I will look to dig more into uBoot and upgrade it.  I hate to stumble out of the box.
> 
> 73 Eric
> 
