Return-Path: <davem@davemloft.net>
Received: from picasso.davemloft.net (unknown [74.93.104.98])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2FE52DDE9A
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 17:12:39 +1000 (EST)
Date: Thu, 13 Sep 2007 00:11:45 -0700 (PDT)
Message-Id: <20070913.001145.78733806.davem@davemloft.net>
To: jdi@l4x.org
Subject: Re: Define termios_1 functions for powerpc, s390, avr32 and frv
From: David Miller <davem@davemloft.net>
In-Reply-To: <46E8DF49.7090402@l4x.org>
References: <18152.719.316280.579601@cargo.ozlabs.ibm.com>
	<46E8DF49.7090402@l4x.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: mikey@neuling.org, hskinnemoen@atmel.com, heiko.carstens@de.ibm.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, alan@redhat.com, akpm@linux-foundation.org,
	torvalds@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Jan Dittmer <jdi@l4x.org>
Date: Thu, 13 Sep 2007 08:57:13 +0200

> Paul Mackerras wrote:
> > Commit f629307c857c030d5a3dd777fee37c8bb395e171 introduced uses of
> > kernel_termios_to_user_termios_1 and user_termios_to_kernel_termios_1
> > on all architectures.  However, powerpc, s390, avr32 and frv don't
> > currently define those functions since their termios struct didn't
> > need to be changed when the arbitrary baud rate stuff was added, and
> > thus the kernel won't currently build on those architectures.
> 
> alpha, parisc, sh, sparc{64,}, xtensa are still broken with this error...

I sent Alan a patch last week that added the Sparc bits, it would
be nice if he or someone else could merge it as I'm travelling
today :-)
