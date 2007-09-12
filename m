Return-Path: <torvalds@linux-foundation.org>
Received: from smtp2.linux-foundation.org (smtp2.linux-foundation.org
	[207.189.120.14])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E22AFDDE28
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 02:09:36 +1000 (EST)
Date: Wed, 12 Sep 2007 09:09:10 -0700 (PDT)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Define termios_1 functions for powerpc, s390, avr32 and frv
In-Reply-To: <18152.719.316280.579601@cargo.ozlabs.ibm.com>
Message-ID: <alpine.LFD.0.999.0709120908090.16478@woody.linux-foundation.org>
References: <18152.719.316280.579601@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Michael Neuling <mikey@neuling.org>, hskinnemoen@atmel.com,
	heiko.carstens@de.ibm.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Alan Cox <alan@redhat.com>,
	akpm@linux-foundation.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Thu, 13 Sep 2007, Paul Mackerras wrote:
> 
> Linus, this seems a bit cleaner than putting ifdefs in
> drivers/char/tty_ioctl.c, and it fixes the compile error on powerpc.
> Your choice whether to use this patch or Tony's.

Yeah, I'll take this one. I just wanted to understand why it triggered at 
all.

Andrew - I'm dropping Tony's patch you forwarded, but since it will still 
apply cleanly, you should drop it manually from your queues.

		Linus
