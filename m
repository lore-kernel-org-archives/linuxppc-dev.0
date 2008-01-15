Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1436FDDE1E
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 05:25:41 +1100 (EST)
Message-ID: <478CFA96.90009@freescale.com>
Date: Tue, 15 Jan 2008 12:25:26 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 1/2] [POWERPC] 4xx: Add 405EXr to cputable
References: <1200380955-10217-1-git-send-email-sr@denx.de>
	<20080115181924.GA3848@loki.buserror.net>
	<20080115183240.GC25749@lixom.net>
In-Reply-To: <20080115183240.GC25749@lixom.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:
> On Tue, Jan 15, 2008 at 12:19:24PM -0600, Scott Wood wrote:
>> On Tue, Jan 15, 2008 at 08:09:15AM +0100, Stefan Roese wrote:
>>> This patch adds the 405EXr to the powerpc cuptable. Basically the 405EXr
>>> is a 405EX with only one EMAC and only one PCIe interface.
>> Sounds like they have the same core... why do they need separate cputable
>> entries?
> 
> AMCC has always indicated SoC products by new PVRs. This isn't news,
> even though it isn't exactly a clean solution. :)

But the old 405EX entry would have matched both chips.  Why add a new 
significant bit to pvr_mask?  For the name in /proc/cpuinfo?

-Scott
