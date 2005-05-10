Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id C78A3679F1
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 May 2005 21:09:16 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j4ABDqjm025243
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 May 2005 14:13:54 +0300 (EEST)
Message-ID: <4280927F.1020107@intracom.gr>
Date: Tue, 10 May 2005 13:52:47 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <427F4D38.70102@intracom.gr>
	<89f1e01d28e3fd391c2c636707a02be1@freescale.com>
In-Reply-To: <89f1e01d28e3fd391c2c636707a02be1@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH  01/04] Freescale Ethernet combined driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> Any reason we dont allow this driver on 85xx?  (should be same as 82xx)
> 
> - kumar
> 

I don't have a 85xx available, so I can't test.
You could try it if you have a board that can be supported.

Also there's the issue with >32bit physical addresses.

This might be more tricky.

Regards

Pantelis
