Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 25D32DDE3C
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Aug 2007 05:02:06 +1000 (EST)
Date: Tue, 28 Aug 2007 14:01:58 -0500
From: Scott Wood <scottwood@freescale.com>
To: DI BACCO ANTONIO - technolabs <Antonio.DiBacco@technolabs.it>
Subject: Re: ppc_8xx-gcc from eldk strange behaviour
Message-ID: <20070828190158.GA21155@ld0162-tx32.am.freescale.net>
References: <F1F6EC0C8B75034F9E3A79FC85122E8E2649AF@aquib01a>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <F1F6EC0C8B75034F9E3A79FC85122E8E2649AF@aquib01a>
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

On Tue, Aug 28, 2007 at 08:56:10PM +0200, DI BACCO ANTONIO - technolabs wrote:
> If I compile it with host gcc, there is no warning and the message "x is negative" is printed.
> If I compile it with ppc_8xx-gcc there is a warning "main.c:11: warning: comparison is always false due to limited range of data type" and the program prints message "x is positive". 
> To correct the problem I have to put signed before char.

C does not specify the signedness of char.  If you care, you need to
explicitly specify.

-Scott
