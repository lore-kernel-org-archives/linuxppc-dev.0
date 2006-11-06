Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 34D7267C39
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Nov 2006 15:46:59 +1100 (EST)
Subject: Re: fixup_bigphys_addr and ioremap64 question
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <1162786580.19697.9.camel@crusty.rchland.ibm.com>
References: <1162783045.28571.283.camel@localhost.localdomain>
	<1162784661.19697.4.camel@crusty.rchland.ibm.com>
	<1162786162.28571.286.camel@localhost.localdomain>
	<1162786580.19697.9.camel@crusty.rchland.ibm.com>
Content-Type: text/plain
Date: Mon, 06 Nov 2006 15:46:04 +1100
Message-Id: <1162788364.28571.288.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Hm.. that might be ok.  I'm hoping to get back to working on something
> soon so I'll be able to tell more later.  Maybe Matt knows for sure.
> 
> It'll probably break out-of-tree drivers though once the merge happens
> for 4xx.  Could we leave ioremap64 around for a bit with a deprecation
> warning?

I'd rather not... I don't really care about out of tree drivers anyway.

Ben.
