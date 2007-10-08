Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B1EFADDF36
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Oct 2007 22:16:12 +1000 (EST)
Date: Mon, 8 Oct 2007 16:16:47 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH respin 0/7] MPC8568E-MDS related patches
Message-ID: <20071008121647.GB32540@localhost.localdomain>
References: <20071005174015.GA11016@localhost.localdomain>
	<27C7E568-B28A-4659-803F-9D271B2E1AF6@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <27C7E568-B28A-4659-803F-9D271B2E1AF6@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 05, 2007 at 05:09:28PM -0500, Kumar Gala wrote:
>
> On Oct 5, 2007, at 12:40 PM, Anton Vorontsov wrote:
>
>> Hello Kumar,
>>
>> This is respin of MPC8568E-MDS patches, on top of master branch
>> as of today.
>>
>> If there are no objections against SPI patch, please Ack it, thus
>> David could pick it up.
>
> I've applied patches 1-5 however I'm not able to get UCC enet working on my 
> board.

I wonder how you managed to boot it w/o sixth (PCI) patch in this patch set,
for me board hanged w/o it.

> Is there something special that has to be done?  (I've got the card 
> standalone, no MDS backplane).

Nothing special, from what I can remember. Though, double checking switches
on the board might help.

Also, .config and bootlog would help.

> I'm using the 1.3.0-rc2 u-boot w/o any modifications.

1.2.0-g60174746 here.

> Also, I tried a PCIe e1000 card w/the .dts that's in my tree and that works 
> w/o any issue.

Strange enough. I'd say it's impossible with your current tree. Maybe you've
used some stale dtb? Because dts is seriously broken as now, and I can't
believe that it worked for you. ;-)

Thanks,

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
