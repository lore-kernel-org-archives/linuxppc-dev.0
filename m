Return-Path: <glppd-linuxppc-dev-3@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2F5DB67C64
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jul 2005 10:30:47 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1Dv2Tq-0001er-DL
	for linuxppc-dev@ozlabs.org; Wed, 20 Jul 2005 02:30:34 +0200
Received: from 213-140-19-123.fastres.net ([213.140.19.123])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jul 2005 02:30:34 +0200
Received: from dev by 213-140-19-123.fastres.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Jul 2005 02:30:34 +0200
To: linuxppc-dev@ozlabs.org
From: Gioele Barabucci <dev@gioelebarabucci.com>
Date: Wed, 20 Jul 2005 02:30:08 +0200
Message-ID: <dbk5ul$l5m$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@sea.gmane.org>
Subject: Little glitches in sleep with a G3 iBook
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Today I compiled Linux 2.6.12-gentoo-r6 and I tried to put my G3 crystal
iBook to sleep.

I started pmud and this is what happened when I closed the lid:
 (I am in X, backlight level is set to half and sound is playing)
 * I closed the lid
 * after about 1 second the sound has been stopped and the monitor backlight
level has been set to max (what causes this delay? why is the backlight
level set to max?)
 * after another second the backlight has been switched off
 * the led blinks
 * I opened the lid
 * I see some logs on the console that tell me that the system is recovering
from sleep (are these lines needed?)
 * the backlight level has been set to max (again...)
 * after half a second and the backlight has been set back to its original
value (half)
 * another second, probably more, and the sound is back (why this long
delay?)


Anyway everything is working fine, and I'm very happy to see sleep working
again. And even sound restarting without all the noise I had in the past.
Thanks to Ben and all the others that worked to make this all!

-- 
Gioele <dev@gioelebarabucci.com>
