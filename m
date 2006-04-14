Return-Path: <Becky.Bruce@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 3E6FE679F6
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Apr 2006 07:07:41 +1000 (EST)
In-Reply-To: <20060414202452.GD24769@pb15.lixom.net>
References: <Pine.LNX.4.44.0604071010290.18017-100000@zirkon.biophys.uni-duesseldorf.de>
	<1144408805.30891.42.camel@localhost.localdomain>
	<17463.9759.442768.685153@cargo.ozlabs.ibm.com>
	<1144923633.4935.11.camel@localhost.localdomain>
	<21F7D7D8-B9BC-44EB-B07B-F888D89DCF25@freescale.com>
	<17471.62187.774127.783000@cargo.ozlabs.ibm.com>
	<20060414195436.GC24769@pb15.lixom.net>
	<17472.984.760483.334447@cargo.ozlabs.ibm.com>
	<20060414202452.GD24769@pb15.lixom.net>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <EAC69420-A425-480D-BEDE-379945104409@freescale.com>
From: Becky Bruce <Becky.Bruce@freescale.com>
Subject: Re: 7447A strange problem with MSR:POW (WAS: can't boot 2.6.17-rc1)
Date: Fri, 14 Apr 2006 16:09:02 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	debian-powerpc@lists.debian.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-04-14 at 12:07 -0700, Paul Mackerras wrote:

> Becky Bruce writes:
>
>
>> Actually, I think the problem is that the code linux is using to turn
>> on nap mode is not guaranteed to put the processor in nap mode by the
>> time the blr in ppc6xx_idle occurs.
>>
>
> Thanks, Becky.
>
> This patch fixes it for me.  Comments, anyone?

Patch LGTM, as well.  I like the approach.

Thanks!
-Becky
