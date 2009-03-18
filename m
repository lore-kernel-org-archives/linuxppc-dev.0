Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3FE4ADDDEE
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 07:46:54 +1100 (EST)
Message-ID: <49C15DB9.1050005@freescale.com>
Date: Wed, 18 Mar 2009 15:46:49 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH v3 3/4] powerpc/85xx: Move gianfar mdio nodes under the
	ethernet nodes
References: <20090318195911.GA31525@oksana.dev.rtsoft.ru>
	<20090318200039.GC8182@oksana.dev.rtsoft.ru>
	<49C1541F.8040803@freescale.com>
	<20090318202344.GA9708@oksana.dev.rtsoft.ru>
	<20090318202947.GA14504@oksana.dev.rtsoft.ru>
	<49C15A21.3050002@freescale.com>
	<20090318203327.GA15378@oksana.dev.rtsoft.ru>
	<49C15AFF.3050708@freescale.com>
	<20090318203928.GA16381@oksana.dev.rtsoft.ru>
In-Reply-To: <20090318203928.GA16381@oksana.dev.rtsoft.ru>
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
> I mean do you see any problem with giving Linux knowledge of
> the -slave name?

I guess I don't really see the point, compared with just having a naked 
mdio node.  The power management issue in this case should be addressed 
by ensuring that core0 never puts ethernet@24000 to sleep.

-Scott
