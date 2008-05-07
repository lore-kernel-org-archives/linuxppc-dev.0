Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	by ozlabs.org (Postfix) with ESMTP id 0EA51DDF72
	for <linuxppc-dev@ozlabs.org>; Thu,  8 May 2008 00:37:30 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Jtklp-0007z3-Q4
	for linuxppc-dev@ozlabs.org; Wed, 07 May 2008 14:37:25 +0000
Received: from p5497d58b.dip.t-dialin.net ([84.151.213.139])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Wed, 07 May 2008 14:37:25 +0000
Received: from dzu by p5497d58b.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Wed, 07 May 2008 14:37:25 +0000
To: linuxppc-dev@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: All your drivers are belong to us [was WARNING: mutexes are preferred
	for single holder semaphores]
Date: Wed, 07 May 2008 16:36:30 +0200
Message-ID: <m23aouuqoh.fsf_-_@ohwell.denx.de>
References: <20080504204104.7eea7618@lappy.seanm.ca>
	<1209958719.21644.32.camel@pasglop>
	<20080505004023.05603b93@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@ger.gmane.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Sean,

> The code is GPLed but not currently available on the net. It is
> basically a little driver that registers a character device and
> then passes out the minor numbers to the PIKA board drivers.
>
> It was written to isolate all the character/sysfs code to one place
> since we have five drivers, and many debug drivers, that use it.
>
> If anybody is really interested, I can post it here. I doubt it will
> ever be submitted to the mainline kernel however.

Just for the record and because it may be interesting to others, during
the Hannover Messe end of April, in the context of the OSADL Congress[1]
I attended a speech of Greg KH about driver development and citing from
memory he said:

"I am serious, please post all drivers that there are, even if you think
they are useless for other people.  We have a driver in mainline for a
device that I know only exists once in the whole world.

Having the drivers in the kernel gives the developers the chance to see
how the infrastructure is being used and to isolate good opportunities
for modularization benefiting the linux kernel.

[...]

It also happened that a driver once posted for what the customer
thought was a completely specific device of his own today supports lots
of different boards from at least four different manufacturers."

The wording is of course not exact but I hope I caught the spirit of
what Greg wanted to say.  So yes, please post the driver - maybe Greg KH
will tunnel it into mainline...

Cheers
  Detlev

[1] http://www.osadl.org/International-Congress-Open-Source-mee.hannover-2008-congress.0.html

PS: The OSADL pages should be updated in a few days to link to slides of
    the talks.

-- 
Ftpd never switches uid and euid, it uses setfsuid(2) instead. The
main reason is that uid switching has been exploited in several
breakins, but the sheer ugliness of uid switching counts too.
                                     -- pure-ftpd(8)
--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
