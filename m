Return-Path: <olof@austin.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.111])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "over.ny.us.ibm.com",
	Issuer "Network Services" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E61652BE83
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Nov 2004 07:50:20 +1100 (EST)
Received: from e5.ny.us.ibm.com ([9.14.6.105])
	by pokfb.esmtp.ibm.com (8.12.10/8.12.9) with ESMTP id iALKdctE116390
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Nov 2004 15:39:38 -0500
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.12.10/8.12.9) with ESMTP id iALKdDHt387360
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Nov 2004 15:39:13 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.6) with ESMTP id
	iALKdCWk225074
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Nov 2004 15:39:13 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.12.11) with ESMTP id iALKdCCO005162
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Nov 2004 15:39:12 -0500
Date: Fri, 19 Nov 2004 13:02:22 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Message-ID: <20041119190222.GA7327@austin.ibm.com>
References: <1100847411.25521.42.camel@gaston>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1100847411.25521.42.camel@gaston>
From: olof@austin.ibm.com (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org
Subject: Re: TEST: Sleep suppport for iBook G4 & Aluminium PowerBooks (ATI
	based)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 19, 2004 at 05:56:50PM +1100, Benjamin Herrenschmidt wrote:

> So here's the new patch, it replaces the previous one for Aluminium
> PowerBooks, and is still against 2.6.9. I'll do something against 2.6.10
> when that one is out (it's a bit late to get that merged with Linus,
> 2.6.10 is in freeze mode now) and I hope to get all of that in 2.6.11.

Seems to work well on my 1.2GHz 12" iBook. First attempt caused a
failure while I had the WUSB12 adapter plugged in (after reboot when the
device was reinitialized the keyboard stopped working and the mouse went
crazy). If I unplug the adapter before sleep, it seems to wakeup without
problem.

No observed problems with backlight or anything else either, but I
haven't been stress testing anything.

Good work, Ben!  I owe you a beer next time you're in Austin! :)

-Olof
