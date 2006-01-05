Return-Path: <grant.likely@secretlab.ca>
Received: from outbound-mail-35.bluehost.com (outbound-mail-35.bluehost.com
	[70.96.188.155]) by ozlabs.org (Postfix) with SMTP id B7ABF689BB
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Jan 2006 03:06:05 +1100 (EST)
Message-ID: <43BD43A0.5060509@secretlab.ca>
Date: Thu, 05 Jan 2006 09:04:48 -0700
From: Grant Likely <grant.likely@secretlab.ca>
MIME-Version: 1.0
To: Sebastian Heutling <sheutlin@gmx.de>
References: <E1EtnU9-0008HI-I0@spohr.debian.org>	<20051230171705.32043.38767.reportbug@sengor.ath.cx>	<handler.345424.D345424.113629990832428.notifdone@bugs.debian.org>
	<43BCFA15.5070304@gmx.de>
In-Reply-To: <43BCFA15.5070304@gmx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
Subject: Re: How to build the zImage.prep was Re: Bug#345424 acknowledged
 by developer         (Bug#345424: fixed in linux-2.6 2.6.15-1)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sebastian Heutling wrote:
> Hi Sven,
> 
> Before trying to build a kernel myself I tried the debian linux binary
> image. An image for powerpc is not there yet so I used rc7. I netbooted
> "/boot/vmlinuz-2.6.15-rc7-powerpc" and the result was that I got a lot
> of output saying that there is something wrong. I assume the output was
> from the firmware because the kernel usually doesn't report an endless
> list of errors saying something about "stack exception" every now and
> then and mostly printing zeros followed by a new line character.
Have you tried 2.6.14?  I'm having a similar issue with PReP images
using QEMU.  2.6.14 works, but 2.6.15 is busted.  It *might* be the same
issue.

http://ozlabs.org/pipermail/linuxppc-dev/2005-December/020782.html

I was able to use git-bisect to narrow it down to 20 or so changes, but
I didn't get any farther.

Cheers,
g.


-- 
Grant Likely, B.Sc. P.Eng.
Secret Lab Technologies Ltd.
(403) 663-0761
