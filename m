Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id C3D9DB7150
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Sep 2010 05:03:34 +1000 (EST)
Date: Wed, 01 Sep 2010 12:03:49 -0700 (PDT)
Message-Id: <20100901.120349.133893738.davem@davemloft.net>
To: grant.likely@secretlab.ca
Subject: Re: ERR_PTR pattern in phylib
From: David Miller <davem@davemloft.net>
In-Reply-To: <AANLkTimkh6ytDmiCQY-gZLHpLzeux1RwMFyr=HyfcDaJ@mail.gmail.com>
References: <AANLkTimjVZTNeLdm4qptU1MqREODLASdGGanUyxqxfub@mail.gmail.com>
	<20100901.082729.135524471.davem@davemloft.net>
	<AANLkTimkh6ytDmiCQY-gZLHpLzeux1RwMFyr=HyfcDaJ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: netdev@vger.kernel.org, afleming@freescale.com,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Grant Likely <grant.likely@secretlab.ca>
Date: Wed, 1 Sep 2010 12:56:29 -0600

> The error codes in phylib are almost arbitrary and don't really give
> enough information about where the a failure lies.  dev_err() is more
> useful for debugging.

If it's using bad error codes, that's only indicative of a bug in
phylib.

> How about this as a compromise:  I'll investigate all the users of
> phylib and if I find even one situation where the specific return code
> is actually important to a driver, then I'll back off.  phylib has
> been around for 5 years now which should be enough time for that use
> case to bubble to the surface.

Sorry, I'm not agreeable to this.

If there are bugs where drivers are not checking the return
pointers correctly, please just fix those bugs.  Otherwise
I see things fine as they are.
