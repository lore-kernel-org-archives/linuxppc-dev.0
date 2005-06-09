Return-Path: <markc@mail.com>
Received: from relay02.roc.ny.frontiernet.net (relay02.roc.ny.frontiernet.net
	[66.133.182.165]) by ozlabs.org (Postfix) with ESMTP id 7D8B667A5B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Jun 2005 01:27:46 +1000 (EST)
Received: from filter07.roc.ny.frontiernet.net
	(filter07.roc.ny.frontiernet.net [66.133.183.74])
	by relay02.roc.ny.frontiernet.net (Postfix) with ESMTP id 1FA48372A71
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Jun 2005 15:27:45 +0000 (UTC)
Received: from relay02.roc.ny.frontiernet.net ([66.133.182.165])
	by filter07.roc.ny.frontiernet.net (filter07.roc.ny.frontiernet.net
	[66.133.183.74]) (amavisd-new, port 10024)
	with LMTP id 21394-02-92 for <linuxppc-embedded@ozlabs.org>;
	Thu, 9 Jun 2005 15:27:45 +0000 (UTC)
Received: from chuck2 (170-215-146-234.br1.rmn.wv.frontiernet.net
	[170.215.146.234])
	by relay02.roc.ny.frontiernet.net (Postfix) with ESMTP id B87A8372A3E
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  9 Jun 2005 15:27:43 +0000 (UTC)
Message-ID: <00b701c56d07$e3b166a0$0301a8c0@chuck2>
From: "Mark Chambers" <markc@mail.com>
Cc: <linuxppc-embedded@ozlabs.org>
References: <20050609135509.AD5C2C1512@atlas.denx.de>
Date: Thu, 9 Jun 2005 11:28:28 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: Re: MPC52xx: sysfs failure on adding new device driver 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sylvain:
> btw, if not yet integrated you should send your patch to Wolfang, he's 
> the one maintaining that tree.

Wolfgang:
> I've seen the patch, but did not decide yet what to do with it.  Many
> drivers  don't  support  devfs  anyway, and in my opinion devfs makes
> little sense in embedded systems anyway. Not to mention that it  will
> officially  be removed from the kernel tree in less than 4 weeks from
> now (see Documentation/feature-removal-schedule.txt).

This is nonsense.  You know, when I made this patch I said 
to myself, "Self, you're wasting your time, these guys won't take patches 
from somebody they don't know"  But I thought it was enough of a 
no-brainer that it might go through.

Seems I was wrong.

Mark Chambers
