Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C6E8BDDDA2
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 07:27:27 +1100 (EST)
Message-ID: <49C1592A.7070607@freescale.com>
Date: Wed, 18 Mar 2009 15:27:22 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH v3 3/4] powerpc/85xx: Move gianfar mdio nodes under the
	ethernet nodes
References: <20090318195911.GA31525@oksana.dev.rtsoft.ru>
	<20090318200039.GC8182@oksana.dev.rtsoft.ru>
	<49C1541F.8040803@freescale.com>
	<20090318202344.GA9708@oksana.dev.rtsoft.ru>
In-Reply-To: <20090318202344.GA9708@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> On Wed, Mar 18, 2009 at 03:05:51PM -0500, Scott Wood wrote:
>> Hmm, would that imply that the mdio underneath it is disabled as well?
> 
> Technically, yes. In practice, MDIO and MAC drivers are probed
> separately.

Currently, yes, but that may not always be the case.

> I don't see any better solution, should I just leave the core1's
> mdio node intact?

Probably.  It's not as if core1 is going to be putting ethernet@24000 to 
sleep.

-Scott
