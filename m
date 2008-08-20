Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DBFFEDEE89
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 04:23:23 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m7KINH5A011212
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 11:23:18 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m7KINGaZ025991
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 13:23:17 -0500 (CDT)
Date: Wed, 20 Aug 2008 13:23:16 -0500
From: Scott Wood <scottwood@freescale.com>
To: Felix Schmidt <felix_schmidt@web.de>
Subject: Re: cache model of ppc
Message-ID: <20080820182316.GA1165@ld0162-tx32.am.freescale.net>
References: <48AC388D.1090609@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48AC388D.1090609@web.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 20, 2008 at 05:30:21PM +0200, Felix Schmidt wrote:
> I some questions about the PowerPC cache model.
> 
> How many caches are there?
> How many caches are in multi-core systems? do you have a L1 cache per
> cpu and one shared L2? or is there a victim L3 cache?
> 
> can you tell me something about the path through the cache?
> for example I look up for data in L1, but this was a miss. Then i look
> up in L2 this was also a miss. but the date will be in another L1
> cache of another cpu. Is there a 1.5 or 2.5 hit?

This is all dependent on the particular CPU you're talking about, and
should be described in its manual.

-Scott
