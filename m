Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 48DB8DDE2D
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Aug 2007 01:41:08 +1000 (EST)
Message-ID: <46B1FB09.4080100@freescale.com>
Date: Thu, 02 Aug 2007 10:40:57 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Yoni Levin <yoni.l@slyde-tech.com>
Subject: Re: GPIO interrupts on mpc8313e
References: <B6DEC8DD6C474CED998B80706BFC4BCC.MAI@mail.livedns.co.il>
In-Reply-To: <B6DEC8DD6C474CED998B80706BFC4BCC.MAI@mail.livedns.co.il>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Yoni Levin wrote:
> myirq=74

OK, that's obviously not the problem then, but you still shouldn't rely 
on them being equal.

Try dumping the PIC registers to see which interrupts (if any) are 
actually pending.

-Scott
