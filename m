Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1CD5B68077
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Aug 2005 09:07:19 +1000 (EST)
In-Reply-To: <20050826225509.GF5541@smtp.west.cox.net>
References: <DCEAAC0833DD314AB0B58112AD99B93B859440@ismail.innsys.innovsys.com>
	<20050826225509.GF5541@smtp.west.cox.net>
Mime-Version: 1.0 (Apple Message framework v622)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <da1e14409c0face6cee5b4d5fa750c00@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Fri, 26 Aug 2005 19:07:01 -0400
To: Tom Rini <trini@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Kumar Gala <galak@freescale.com>
Subject: Re: [PATCH] ppc32: add CONFIG_HZ
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 26, 2005, at 6:55 PM, Tom Rini wrote:

> Yes, it was.  With 2.6.13 and on i386 (and other arches that actually
> make use of the question) it can be any of 100, 250 or 1000.

Well, 250 just seems wrong as I mentioned in a previous message.
It will function, but an application is going to see lots of clock 
jitter
unless you work in multiples of 100.  My choices would be 100, 200,
500, or 1000.

Thanks.

	-- Dan
