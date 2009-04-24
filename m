Return-Path: <CFRIESEN@nortel.com>
Received: from zcars04e.nortel.com (zcars04e.nortel.com [47.129.242.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "", Issuer "NORTEL" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id A2A25DE114
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Apr 2009 04:27:42 +1000 (EST)
Message-ID: <49F203B1.6040508@nortel.com>
Date: Fri, 24 Apr 2009 12:23:45 -0600
From: "Chris Friesen" <cfriesen@nortel.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: help with inline assembly code?
References: <49F1F56C.8000708@nortel.com> <49F1F841.8080507@freescale.com>
	<49F1FF98.1000100@nortel.com> <49F20181.10206@freescale.com>
In-Reply-To: <49F20181.10206@freescale.com>
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

Scott Wood wrote:
> Chris Friesen wrote:
>> Scott Wood wrote:
>>> Is the compiler assigning r0 to addr?  That will be treated as a 
>>> literal zero instead.  Try changing "r" (addr) to "b" (addr), or use 
>>> stwx.
>> Bingo!  Is there a constraint to tell the compiler to not use r0 for addr?
> 
> Yes, "b".

Doh.  Sorry, apparently I can't read today.  Both of those fixes seem to 
work.

Much appreciated.

Chris
