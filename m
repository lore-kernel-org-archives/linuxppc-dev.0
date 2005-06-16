Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 16684679E7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Jun 2005 01:33:28 +1000 (EST)
In-Reply-To: <0fc7d3f2fe1266cdd0beaf44a71bc27c@embeddededge.com>
References: <0fc7d3f2fe1266cdd0beaf44a71bc27c@embeddededge.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <678305db5ee1488bb48a26a4a89c121a@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 16 Jun 2005 10:33:23 -0500
To: "Dan Malek" <dan@embeddededge.com>
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: RFC: cpm2_devices.c
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dan,

If I understand you correctly this is not any different than how we 
handle the TSEC (gianfar) on 85xx.  The platform device structure just 
gives us physical address (start & end) and IRQs and we use a structure 
in the driver that maps to the start address.

- kumar

> Having just converted an different SoC part from using offsets to data
> structures, I have to say that tables/defines of offsets are more of a
> mess
> than a data structure.  We don't have to define the whole of the IMMAP,
> but
> using the data structures for the individual device spaces is quite
> effective.
> The advantage of using the data structure is it also conveys the data
> type
> size, adding a level error checking.  I also dislike io accessor
> functions/macros,
> especially on these processor specific devices.
>
>
> Thanks.
>
> 	-- Dan
