Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id 8549B680AD
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Aug 2005 08:50:23 +1000 (EST)
In-Reply-To: <1124836787.5189.107.camel@gaston>
References: <20050823202708.GE13157@dmt.cnet>
	<1124836787.5189.107.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <29D5FC3D-C2AD-440E-B929-9AA29F7300CF@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Date: Tue, 23 Aug 2005 17:50:15 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Kumar Gala <galak@freescale.com>
Subject: Re: [PATCH] ppc32: make perfmon.o CONFIG_E500 specific
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I've got some untested code for 74xx (probably only 7450 for now),  
but it's several rungs down my priority list right now.  : 
(  Hopefully I will have time for it soon...

Andy

On Aug 23, 2005, at 17:39, Benjamin Herrenschmidt wrote:

> On Tue, 2005-08-23 at 17:27 -0300, Marcelo Tosatti wrote:
>
>> Subject says it all, there is no need to link perfmon.o on
>> sub-architectures other than CONFIG_E500.
>>
>
> Hrm... Nobody has an implementation for 74xx ?
>
> Ben.
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>
