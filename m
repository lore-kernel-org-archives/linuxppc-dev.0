Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 4F4A4DE38F
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 07:01:30 +1000 (EST)
Received: from az33smr02.freescale.net (az33smr02.freescale.net [10.64.34.200])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m3GL1O1N023507
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 14:01:24 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id m3GL1NI3006592
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 16:01:24 -0500 (CDT)
Date: Wed, 16 Apr 2008 16:01:23 -0500
From: Scott Wood <scottwood@freescale.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: lseek() on entries in /proc/device-tree returns EINVAL
Message-ID: <20080416210123.GA14874@ld0162-tx32.am.freescale.net>
References: <48066857.4030109@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <48066857.4030109@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 16, 2008 at 03:57:59PM -0500, Timur Tabi wrote:
> Is there a limitation for the implementation of /proc/device-tree that prevents
> lseek() from working?  If so, how do I determine the size of a property?

Try fstat().

-Scott
