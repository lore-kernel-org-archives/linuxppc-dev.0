Message-ID: <1072F1A27E99D3119747005004B9A380BF28A6@MAIL>
From: Brett Carswell <BrettC@nulec.com.au>
To: "'Dan Malek'" <dan@mvista.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'"
	 <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: RPX Lite w MontaVista 1.2
Date: Mon, 18 Dec 2000 08:03:44 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I enabled the NVRAM in the config and everything works great now.
Thanks

> -----Original Message-----
> From: Dan Malek [mailto:dan@mvista.com]
> Sent: Friday, 15 December 2000 3:20 AM
> To: Brett Carswell
> Cc: 'linuxppc-embedded@lists.linuxppc.org'
> Subject: Re: RPX Lite w MontaVista 1.2
>
>
>
> Brett Carswell wrote:
>
> > I have downloaded the MontaVista CDK 1.2 and installed
> everything for the
> > RPX lite. I followed the documentation and I can load the s
> record image
> > into an RPX Lite board (850SR)
>
> Hmmm....I left some debug stuff in arch/ppc/mbxboot/embed_config.c....
> Edit that file, remove the:
>
> 	{
> 		int i;
> 		cp = (u_char *)0xfa000000;
>
> 		.....
> 	}
>
> piece of code that appears early in the function rpx_cfg().  If you
> don't have a board with NVRAM, this will certainly fail.
>
> Sorry about that, let me know how it goes.
>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
