Message-ID: <3A39015B.A528DAED@mvista.com>
Date: Thu, 14 Dec 2000 12:20:27 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Brett Carswell <BrettC@nulec.com.au>
CC: "'linuxppc-embedded@lists.linuxppc.org'"
 <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: RPX Lite w MontaVista 1.2
References: <1072F1A27E99D3119747005004B9A380BF28A0@MAIL>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brett Carswell wrote:

> I have downloaded the MontaVista CDK 1.2 and installed everything for the
> RPX lite. I followed the documentation and I can load the s record image
> into an RPX Lite board (850SR)

Hmmm....I left some debug stuff in arch/ppc/mbxboot/embed_config.c....
Edit that file, remove the:

	{
		int i;
		cp = (u_char *)0xfa000000;

		.....
	}

piece of code that appears early in the function rpx_cfg().  If you
don't have a board with NVRAM, this will certainly fail.

Sorry about that, let me know how it goes.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
