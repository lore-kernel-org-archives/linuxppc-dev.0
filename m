Return-Path: <lists@nerdbynature.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.183]) by ozlabs.org (Postfix) with ESMTP id 4C505DE0B1
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 07:54:19 +1000 (EST)
Date: Tue, 29 Apr 2008 23:54:13 +0200 (CEST)
From: Christian Kujau <lists@nerdbynature.de>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: filenames with spaces in /sys?
In-Reply-To: <20080428153127.GA9849@ld0162-tx32.am.freescale.net>
Message-ID: <alpine.DEB.1.10.0804292342290.11017@sheep.housecafe.de>
References: <alpine.DEB.1.10.0804272012000.11017@sheep.housecafe.de>
	<20080428153127.GA9849@ld0162-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 28 Apr 2008, Scott Wood wrote:
>> Wouldn't ../pmu-battery.0/power_supply/PMU_battery_0/power be feasible too?
>
> Feasible, yes, but uglier

I did not want to argue about "ugliness", as this is a matter of 
personal taste.

> If userspace tools make it awkward to deal with filenames with spaces,
> let's fix the userspace tools.

Usually I would agree. I was only puzzled that filenames in /sys have 
spaces at all - I was under the impression spaces should be omitted in 
/sys (and /proc, too) for ease of handling (userspace has to specialcase 
spaces). And looking at these directories only very few filenames contain 
spaces, so it looked like ../PMU battery 0/ somehow "slipped through", as 
there's no point in having spaces when almost everything else was using 
an unserscore.

> /sys is certainly not the only place they'll be found, and waging war 
> against them is a battle best left for a couple decades ago.

Hm, I guess the real solution would be a statement about special 
characters in special filesystems in CodingStyle ....and a travel back in 
time to have this rule applied of course :)

C.
-- 
BOFH excuse #190:

Proprietary Information.
