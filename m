Return-Path: <timur@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 07187DE183
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Apr 2008 02:49:10 +1000 (EST)
Message-ID: <47FF9665.7020403@freescale.com>
Date: Fri, 11 Apr 2008 11:48:37 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: [PATCH 2/2] [POWERPC] UCC nodes cleanup
References: <20080311171045.GB4684@localhost.localdomain>	<82E8E38A-C159-4C23-BDE8-086D4429F366@kernel.crashing.org>
	<20080411160654.GA25506@polina.dev.rtsoft.ru>
In-Reply-To: <20080411160654.GA25506@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Jeff Garzik <jgarzik@pobox.com>,
	linux-serial@vger.kernel.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> On Fri, Apr 11, 2008 at 09:13:36AM -0500, Kumar Gala wrote:
>> On Mar 11, 2008, at 12:10 PM, Anton Vorontsov wrote:
>>> - get rid of `model = "UCC"' in the ucc nodes
>>>  It isn't used anywhere, so remove it. If we'll ever need something
>>>  like this, we'll use compatible property instead.
>>> - replace cell-index and device-id properties by fsl,ucc.
>>>
>>> Drivers are modified for backward compatibility's sake.
>> I'd prefer we use cell-index and not introduce "fsl,ucc".  I'm ok with  
>> dropping device-id and model (its implied in the compatiable).
> 
> Ok. Here it is. netdev and linux-serial Cc'ed.

Do we want the first UCC to have a cell-index of 1?  Maybe we should fix this
off-by-one error once and for all, and number all UCCs from 0?

-- 
Timur Tabi
Linux kernel developer at Freescale
