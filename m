Return-Path: <b07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B17ECDDEF8
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Sep 2007 04:43:16 +1000 (EST)
Date: Thu, 6 Sep 2007 13:43:08 -0500
From: Scott Wood <scottwood@freescale.com>
To: "Leisner, Martin" <Martin.Leisner@xerox.com>
Subject: Re: finding out the processor frequency
Message-ID: <20070906184308.GA22380@ld0162-tx32.am.freescale.net>
References: <556445368AFA1C438794ABDA8901891C06460054@USA0300MS03.na.xerox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <556445368AFA1C438794ABDA8901891C06460054@USA0300MS03.na.xerox.net>
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

On Thu, Sep 06, 2007 at 02:24:30PM -0400, Leisner, Martin wrote:
> What exactly do we mean by "timebase"?
> 
> There a symbol in arch/powerpc/time.c:ppc_proc_freq which looks like the
> processor frequency (derived from the dts).  But its not exported.
> 
> There's also ppc_tb_freq.

The timebase is the rate at which the timebase and decrementer registers
tick.  It is not the same as the CPU core frequency.

-Scott
