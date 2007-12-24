Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 5821CDDE05
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Dec 2007 04:24:30 +1100 (EST)
Message-ID: <476FEB43.8050507@freescale.com>
Date: Mon, 24 Dec 2007 11:24:19 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH] Add information on enabling sound on the MPC8641 HPCN
References: <11983809443854-git-send-email-timur@freescale.com>
	<20071223152613.GA4817@lixom.net>
In-Reply-To: <20071223152613.GA4817@lixom.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:

> Sounds like a board rework document on your support site is the right
> place for this. 

Except that no one would know to look there.  I don't even know who to 
contact to get that kind of information on that site.

> We normally don't document board reworks required in
> the linux sources, do we?

I do, if I can find a discrete place for it.  The patch for my QE UART 
driver has a similar comment in the DTS for the 8323E MDS.
