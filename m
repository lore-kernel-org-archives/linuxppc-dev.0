Return-Path: <holindho@cs.helsinki.fi>
Received: from fep34-app.kolumbus.fi (fep34-0.kolumbus.fi [193.229.0.43])
	by ozlabs.org (Postfix) with ESMTP id 218C8679A6
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Feb 2006 18:36:55 +1100 (EST)
Message-ID: <43FEB064.1@cs.helsinki.fi>
Date: Fri, 24 Feb 2006 09:06:12 +0200
From: Heikki Lindholm <holindho@cs.helsinki.fi>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ibook1 hangs during boot, atyfb broken
References: <20060223232423.GA29454@suse.de>
	<1140752928.8264.72.camel@localhost.localdomain>
In-Reply-To: <1140752928.8264.72.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt kirjoitti:
> On Fri, 2006-02-24 at 00:24 +0100, Olaf Hering wrote:
> 
>>My iBook1 did not work with recent kernels (2.6.15+), 2.6.13 was always ok.
>>Today I did some more testing, with 2.6.16-rc4-git3.
>>If I boot with 'quiet panic=1 root=/dev/blah', it will hang in 75% of the boots 
>>before displaying the penguin.
>>Adding video=atyfb:off did fix it, tried it a few times. Then I removed
>>the quiet and video= option, and it did boot again. Then I reverted the
>>atyfb to 2.6.15 status and did a reboot loop.
>>Unfortunately, after 13 reboots with just 'panic=1 root=/x' it was stuck, after 
>>time_init: processor frequency = 300MHz.
> 
> 
> It boots with video=atyfb:noaccel ?
> 
> I suggest you report that to the linux-fbdev mailing list. That problem
> seems to happen with some wallstreet powerbooks too, there is definitely
> something broken there...

Using an older DVI TiBook, atyfb has been broken at least since 2.6.8 or 
so, and still is with 2.6.15, in that it can't seem to synchronize with 
the LCD and maybe 50% of the (re-)boots produce just more-or-less 
shimmering/flashing garbage on screen. Doesn't completely hang though...

-- Heikki Lindholm
