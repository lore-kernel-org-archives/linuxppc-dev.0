Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 127FFDDEF3
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 08:13:07 +1100 (EST)
Message-ID: <478295E6.7020703@freescale.com>
Date: Mon, 07 Jan 2008 15:13:10 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [RFC PATCH 2/3] Add initial iomega StorCenter board port.
References: <E1JBwBn-0006JC-Nn@jdl.com> <47828ECA.9000507@freescale.com>
	<E1JBzEZ-0007mL-Iy@jdl.com>
In-Reply-To: <E1JBzEZ-0007mL-Iy@jdl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, andy@protium.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Loeliger wrote:
>> Can we take out the dependencies and the default y, and just select them 
>> in the individual board configs?
> 
> Yeah.  That and, shouldn't those choices be mutually
> exclusive in a "choice" arrangement instead too?

No, "choice" sucks for multiplatform.

-Scott
