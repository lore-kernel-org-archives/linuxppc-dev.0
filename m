Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id D74B0679F8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 May 2005 03:00:15 +1000 (EST)
In-Reply-To: <428A040D.40604@ybb.ne.jp>
References: <428A040D.40604@ybb.ne.jp>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <fb7df67f9dda2794b4af2dfa9b4754ca@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 17 May 2005 12:00:04 -0500
To: "Takeharu KATO" <takeharu1219@ybb.ne.jp>
Cc: Glenn Burkhardt <glenn@aoi-industries.com>,
	"Gala Kumar K.-galak" <galak@freescale.com>, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] BOOKE_WDT Part 1/2 (Re: PPC 44x Watchdog timer)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 17, 2005, at 9:47 AM, Takeharu KATO wrote:

> Hi Kumar:
>
> >> No problem, can you replace all the cmd line parsing with
> >> early_param() code in arch/ppc/kernel/setup.c.=A0 Take a look at
> >> arch/ppc64/kernel/setup.c for an example.=A0 We still need to add a=20=

> call
> >> to parse_early_param() in setup_arch().
>  >>
>  > Sorry, I can not figure out what you want.
> > As far as I look the source tree,arch/ppc/kernel/setup.c does not=20
> have
>  > the function called early_param.
>  > Would you give me a more precise explanation?
>  >
> On second thought, I make sense what you said.
> You asked me that I make some kind of cleanups, didn't you?
>  If it is true, I'll try to clean up these setups, but it may be
>  take the time.

Yes, I think with these changes to us early_param() for command line=20
parsing in a single place will make the first patch look good.

I'm still not sure what suggestions I have for the second patch, I was=20=

more just letting you know my thinking about the fact that it concerned=20=

me that the exception handler code was not in arch/ppc/kernel.  Not to=20=

say this is wrong, it just doesn't feel write.

- kumar
