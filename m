Return-Path: <kumar.gala@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 95EF92BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 14 Jan 2005 08:25:32 +1100 (EST)
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8A6296CC-65A9-11D9-B612-000393DBC2E8@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 13 Jan 2005 15:24:42 -0600
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: Scott Hall <shall@mvista.com>,
	Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: mpc-i2c.c in 2.6
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Adrian,

I was wondering if you had any opinions on the timeout between 
transactions in drivers/i2c/busses/mpc-i2c.  Looking at it, we 
currently set the timeout between transactions to 1 second (HZ).  Any 
reason its this high?

on 85xx, I'm able to set it to HZ/100 w/o any really issue.

thanks

- kumar
