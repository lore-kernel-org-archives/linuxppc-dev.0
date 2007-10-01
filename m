Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E30B7DDE09
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 02:10:28 +1000 (EST)
Message-ID: <47011BED.8020206@freescale.com>
Date: Mon, 01 Oct 2007 11:10:21 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] cpm: Describe multi-user ram in its own device node.
References: <20070928190616.GB20213@loki.buserror.net>
	<20070929003005.59afc2a0@kernel.crashing.org>
	<08C0C9CB-C958-4B95-81B8-D0677CBA4399@kernel.crashing.org>
	<20070929104917.1585737e@kernel.crashing.org>
	<1B684498-FC47-4F01-A72E-DD27B259613A@kernel.crashing.org>
In-Reply-To: <1B684498-FC47-4F01-A72E-DD27B259613A@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Timur Tabi <timur@freescale.com>,
	PowerPC dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On Sep 29, 2007, at 1:49 AM, Vitaly Bordug wrote:
>> cpms have dpram, qe has muram. these two are the same stuff in fact. 
>> Or you are asking about have QE stuff utilize such a binding at the 
>> same pass?
> 
> I was asking about both these things.

As stated in the commit message, QE can use this; it just needs a 
compatible entry in the data node.

-Scott
