Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9F2FCDE030
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 05:20:37 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	m3UJKV4J029060
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 12:20:32 -0700 (MST)
Received: from ld0162-tx32.am.freescale.net (ld0162-tx32.am.freescale.net
	[10.82.19.112])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id m3UJKVDg002734
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 14:20:31 -0500 (CDT)
Date: Wed, 30 Apr 2008 14:20:30 -0500
From: Scott Wood <scottwood@freescale.com>
To: Becky Bruce <becky.bruce@freescale.com>
Subject: Re: drivers/net/fec_8xx config problem
Message-ID: <20080430192030.GA9084@ld0162-tx32.am.freescale.net>
References: <6E2EBEAF-DF1E-4439-91EF-B15EE39CAF61@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6E2EBEAF-DF1E-4439-91EF-B15EE39CAF61@freescale.com>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	jengelh@linux01.gwdg.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 30, 2008 at 02:19:21PM -0500, Becky Bruce wrote:
> I just noticed that the fec_8xx driver is not currently reachable via  
> menuconfig because it depends on 8XX instead of 8xx.
[snip]
> Since nobody has noticed this problem, I'm wondering if this driver  
> is still in (infrequent) use, or if it's been superseded and should  
> be removed, or if I'm just completely missing something with respect  
> to the use of "8XX" instead of "8xx".

It's been superseded by drivers/net/fs_enet.

-Scott
