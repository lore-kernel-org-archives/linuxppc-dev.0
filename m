Return-Path: <holindho@cs.helsinki.fi>
Received: from fep01-app.kolumbus.fi (fep01-0.kolumbus.fi [193.229.0.41])
	by ozlabs.org (Postfix) with ESMTP id 033B3679FB
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Feb 2006 00:23:39 +1100 (EST)
Message-ID: <43FF08D2.2050407@cs.helsinki.fi>
Date: Fri, 24 Feb 2006 15:23:30 +0200
From: Heikki Lindholm <holindho@cs.helsinki.fi>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: ibook1 hangs during boot, atyfb broken
References: <20060223232423.GA29454@suse.de>	
	<1140752928.8264.72.camel@localhost.localdomain>	
	<43FEB064.1@cs.helsinki.fi>
	<1140779302.8264.79.camel@localhost.localdomain>
In-Reply-To: <1140779302.8264.79.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olh@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt kirjoitti:
>>Using an older DVI TiBook, atyfb has been broken at least since 2.6.8 or 
>>so, and still is with 2.6.15, in that it can't seem to synchronize with 
>>the LCD and maybe 50% of the (re-)boots produce just more-or-less 
>>shimmering/flashing garbage on screen. Doesn't completely hang though...
> 
> 
> Except that no tibook ever used atyfb...

Damn straight! I stand corrected (confused with one PC laptop), it's the 
radeon thing then..

-- Heikki Lindholm
