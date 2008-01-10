Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A1447DDFF3
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 11 Jan 2008 04:48:38 +1100 (EST)
Message-ID: <47865A80.7050205@freescale.com>
Date: Thu, 10 Jan 2008 11:48:48 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: raul.moreno@telvent.abengoa.com
Subject: Re: 2.6.22-ppc8xx fec.c bugs
References: <OF7BC7CA29.9B371169-ONC12573CC.00553A44-C12573CC.0057BA09@abengoa.com>
In-Reply-To: <OF7BC7CA29.9B371169-ONC12573CC.00553A44-C12573CC.0057BA09@abengoa.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

raul.moreno@telvent.abengoa.com wrote:
> Hello everyone,
> 
> I don't know who the maintainer of the FEC (Fast Ethernet Controller) in
> the ppc8xx achitecture is, so I am writing this email here.

arch/ppc is deprecated, and arch/ppc/8xx_io especially so.

Please use drivers/net/fs_enet (and also note that arch/ppc will be 
going away in a few months).

> I've seen that some bugs were fixed in the latest kernel but others haven't
> been addressed (possibly undetected yet). The following is a diff with
> corrections I made to the 2.6.22 'fec.c' file (currently seems to work
> fine).

Please post patches against the latest head-of-tree, and in unified diff 
format (diff -u).

-Scott
