Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 07148DE1EC
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Apr 2009 04:14:31 +1000 (EST)
Message-ID: <49F20181.10206@freescale.com>
Date: Fri, 24 Apr 2009 13:14:25 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Chris Friesen <cfriesen@nortel.com>
Subject: Re: help with inline assembly code?
References: <49F1F56C.8000708@nortel.com> <49F1F841.8080507@freescale.com>
	<49F1FF98.1000100@nortel.com>
In-Reply-To: <49F1FF98.1000100@nortel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Chris Friesen wrote:
> Scott Wood wrote:
>> Is the compiler assigning r0 to addr?  That will be treated as a 
>> literal zero instead.  Try changing "r" (addr) to "b" (addr), or use 
>> stwx.
> 
> Bingo!  Is there a constraint to tell the compiler to not use r0 for addr?

Yes, "b".

-Scott
