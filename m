Return-Path: <CFRIESEN@nortel.com>
Received: from zcars04e.nortel.com (zcars04e.nortel.com [47.129.242.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 6494CDDF57
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jul 2008 15:30:32 +1000 (EST)
Message-ID: <487ED8EC.60507@nortel.com>
Date: Wed, 16 Jul 2008 23:30:20 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH] powerpc: fix support for latencytop
References: <48755237.9070701@nortel.com>
	<200807101608.18643.arnd@arndb.de>	<20080716202236.GZ9594@localdomain>
	<200807170012.25859.arnd@arndb.de>
	<20080716224208.GF9594@localdomain>
In-Reply-To: <20080716224208.GF9594@localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nathan Lynch wrote:
> Arnd Bergmann wrote:
> 
>>We need to pass the kernel stack pointer instead of the user space
>>stack pointer in save_stack_trace_tsk().
> 
> 
> Thanks, this fixes it, and latencytop even seems to work. :)

Sweet.  One week from mention to working in -next...not bad.

My thanks to Arnd and Nathan for implementing and testing it out.

Chris
