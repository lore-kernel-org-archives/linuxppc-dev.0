Return-Path: <leigh@solinno.co.uk>
Received: from titan.server-plant.co.uk (titan.server-plant.co.uk [80.71.3.50])
	by ozlabs.org (Postfix) with ESMTP id 56CF82BDB5
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Jan 2005 06:43:00 +1100 (EST)
Message-ID: <33721.82.10.231.190.1104781370.squirrel@82.10.231.190>
In-Reply-To: <200501031932.j03JWC4E013520@arbas.nms.ulrich-teichert.org>
References: <33304.82.10.231.190.1104771000.squirrel@82.10.231.190> from
	"Leigh Brown" at Jan 03, 2005 04:50:00 PM
	<200501031932.j03JWC4E013520@arbas.nms.ulrich-teichert.org>
Date: Mon, 3 Jan 2005 19:42:50 -0000 (GMT)
From: "Leigh Brown" <leigh@solinno.co.uk>
To: "Ulrich Teichert" <krypton@ulrich-teichert.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, mikemartin@linux.ca,
	debian-powerpc@lists.debian.org
Subject: Re: 43p-140 install issues
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ulrich Teichert said:
[...]
> Linux/PPC load: console=ttyS0,9600 console=tty0 root=/dev/ram

Delete the "console=tty0", so you end up with:

 Linux/PPC load: console=ttyS0,9600 root=/dev/ram

and try again!

[...]
>>It should never ask the console question again unless you change the
>>config (plug in a mouse for example), unless your nvram battery is a
>>bit flat of course!
>
> This seems to be the case. But it really simplifies things, as I've never
> been able to warm-boot anything ;-) Only a cold boot helps. Maybe Daniel
> should remove the battery to reset things completely?
>
> Anyway, without your site, Leigh, I would still have a big doorstop only,
> thanks again,

No problem.  The amazing thing is, once you actually get them running,
RS/6000's run Linux really reliably.  It's getting them booting that's
the problem :-/
