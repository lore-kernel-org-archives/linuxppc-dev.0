Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E004068077
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Aug 2005 08:54:52 +1000 (EST)
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B859440@ismail.innsys.innovsys.com>
References: <DCEAAC0833DD314AB0B58112AD99B93B859440@ismail.innsys.innovsys.com>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <8a51e41268831934719db8de5dc28500@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Fri, 26 Aug 2005 18:54:41 -0400
To: "Rune Torgersen" <runet@innovsys.com>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Kumar Gala <galak@freescale.com>, Tom Rini <trini@kernel.crashing.org>
Subject: Re: [PATCH] ppc32: add CONFIG_HZ
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 26, 2005, at 6:48 PM, Rune Torgersen wrote:

> I thought the default value for HZ in 2.6 was 1000?
> At least this is what it is set at for the 82xx (and bigger embedded)
> boards

Oh geeze, no wonder we can't get any performance
out of 2.6 on these boards.   Between that and the TLB
thrashing going on there's nothing left for the applications :-)


	-- Dan
