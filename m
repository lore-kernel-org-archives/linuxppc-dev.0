Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id CE0EDDDDF7
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Aug 2007 03:46:12 +1000 (EST)
Message-ID: <46C48D53.1050208@freescale.com>
Date: Thu, 16 Aug 2007 12:45:55 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc: add setmaskedbits macros
References: <11872134502476-git-send-email-timur@freescale.com>	
	<2DFE7EFC-6B9F-4149-83AE-5502DD25C14C@kernel.crashing.org>	
	<46C46AB7.6070903@freescale.com>	
	<9CE3D32E-B9C6-43B8-B944-45CE1DCCE8A2@kernel.crashing.org>	
	<46C46C9A.2000107@freescale.com>
	<1187282419.30809.35.camel@localhost.localdomain>
In-Reply-To: <1187282419.30809.35.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:

>> The second example is actually a trick that lets me set some bits and clear 
>> others in one shot, so for the gumr_h register, all of the above values are 
>> single bits.  I guess that's not a good example.
> 
> Such tricks deserve at least a comment.

Would it be better if the function were called setclrbits_xxx(), and advertise 
that it can be used to set multi-bit fields *and* set and clear bits at the 
same time?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
