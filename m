Return-Path: <adrian@humboldt.co.uk>
Received: from mail.humboldt.co.uk (mail.humboldt.co.uk [81.2.65.18])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EE4C62BDF2
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 15 Jan 2005 05:53:04 +1100 (EST)
From: Adrian Cox <adrian@humboldt.co.uk>
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <8A6296CC-65A9-11D9-B612-000393DBC2E8@freescale.com>
References: <8A6296CC-65A9-11D9-B612-000393DBC2E8@freescale.com>
Content-Type: text/plain
Date: Fri, 14 Jan 2005 18:06:02 +0000
Message-Id: <1105725962.28030.75.camel@localhost>
Mime-Version: 1.0
Cc: Scott Hall <shall@mvista.com>,
	Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: mpc-i2c.c in 2.6
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2005-01-13 at 15:24 -0600, Kumar Gala wrote:
> I was wondering if you had any opinions on the timeout between 
> transactions in drivers/i2c/busses/mpc-i2c.  Looking at it, we 
> currently set the timeout between transactions to 1 second (HZ).  Any 
> reason its this high?

It only exists because when I started the driver I hadn't spotted the
timeout field in i2c_adapter. Your patch is fine.


-- 
Adrian Cox <adrian@humboldt.co.uk>
