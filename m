Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 42FC1DDF63
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 03:12:43 +1100 (EST)
Date: Thu, 24 Jan 2008 19:11:31 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/5] [POWERPC][NET] ucc_geth_mii and users: get rid of
	device_type
Message-ID: <20080124161131.GA29763@localhost.localdomain>
References: <20080124151850.GA15190@localhost.localdomain>
	<20080124154001.GB23246@localhost.localdomain>
	<53D750AF-AC04-47F6-8537-4F17206CC279@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <53D750AF-AC04-47F6-8537-4F17206CC279@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 24, 2008 at 09:52:14AM -0600, Kumar Gala wrote:
> 
> On Jan 24, 2008, at 9:40 AM, Anton Vorontsov wrote:
> 
> >device_type property is bogus, thus use proper compatible.
> >
> >Also change compatible property to "fsl,ucc-mdio".
> >
> >Per http://ozlabs.org/pipermail/linuxppc-dev/2007-December/048388.html
> >
> >Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> 
> can we look at using "fsl,gianfar-mdio" ?  Meaning my understanding  
> the programming model for the UCC mdio is identical to gianfar MDIO  
> programming.

I didn't look much into gianfar mii driver, so I can't tell.

Would "fsl,ucc-mdio", "fsl,gianfar-mdio" work for us? That way
we'll match on "fsl,ucc-mdio" today, and "fsl,gianfar-mdio" when/if
drivers are merged?

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
