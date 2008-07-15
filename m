Return-Path: <khali@linux-fr.org>
Received: from services.gcu-squad.org (zone0.gcu-squad.org [212.85.147.21])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 78133DE638
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 01:39:13 +1000 (EST)
Date: Tue, 15 Jul 2008 17:39:00 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Jochen Friedrich <jochen@scram.de>
Subject: Re: [PATCH] of: i2c: improve last resort compatible entry selection
Message-ID: <20080715173900.724f92cb@hyperion.delvare>
In-Reply-To: <487CB991.9000301@scram.de>
References: <20080714175437.GA5230@polina.dev.rtsoft.ru>
	<487C7F9A.7030201@scram.de>
	<9e4733910807150640x52cca982jf4f1ccfe7fd506cf@mail.gmail.com>
	<20080715160510.0f57dd0e@hyperion.delvare>
	<487CB991.9000301@scram.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 15 Jul 2008 16:52:01 +0200, Jochen Friedrich wrote:
> Hi Jean,
> 
> > Eeeek. The patch you mention here is only the conversion of ONE driver.
> > It is absolutely not relevant as to what the general rule is.
> 
> Sorry, i must have misunderstood you then.
> 
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h=af294867a52bf718df835a688e8c786d550bee26#patch9
> is the same, my original patch listed all four supported chips in there
> (saa7126, saa7127, saa7128 and saa7129) while only one made it into the driver...

As I recall, your patch was done quickly and without knowledge of the
chips in question. I did mine in close collaboration with Hans Verkuil
who knows these chips very well, to make sure I wouldn't break
anything. With success, as far as I can tell.

Honestly, I can't remember why we decided to have a single chip name
for all 4 variants. It might have been a shortcut to complete the
conversion in time. Or, more likely, I didn't notice the other types
because the driver was originally using the same name "saa7127" for all
devices. If that is the case I'll update the driver to behave more in
compliance with the new i2c device/driver matching scheme. I'll discuss
this with Hans to make sure it's OK.

So, again, please don't take this (nor any other) media driver
conversion patch as an example of what should be done. The proper
conversion of all media drivers will take a lot of time because of the
history behind these drivers.

-- 
Jean Delvare
