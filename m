Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id D3E4367A77
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  8 Mar 2005 08:41:14 +1100 (EST)
In-Reply-To: <004B1D7A5257174C9044A1B7BD0E60ED0178CBF5@ratatosk.combitechsystems.com>
References: <004B1D7A5257174C9044A1B7BD0E60ED0178CBF5@ratatosk.combitechsystems.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <bb55e4fee0c9d53e4a738e74bc91aa5b@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Mon, 7 Mar 2005 15:41:06 -0600
To: =?ISO-8859-1?Q?Bj=F6rn_=D6stby?= <Bjorn.Ostby@combitechsystems.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Read TCN-register in user space
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

There is a proper way to do this and hackish way.  The proper way is to=20=

eventually provide some interface via the work BenH has been doing with=20=

vDSO (while out).  The hackish way is to export it via some /proc or=20
sysfs attribute.  The hackish way will not make its way into a mainline=20=

tree.

- kumar

On Mar 7, 2005, at 5:02 AM, Bj=F6rn =D6stby wrote:

> I'm currently using ELDK 3.0 (kernel 2.4.25) and a mpc823e trying to=20=

> do some latency measurements for my final thesis project.
>
> I'm wondering if there is any possibility to read the Timer Counter=20
> Register (TCN1) in user space. I have initially used gettimeofday(),=20=

> which provides sufficient resolution (usec), but I suppose that=20
> solution probably adds on some kind of unknown context-switch latency.=20=

> Does anyone have a clue on how to access this in user space? Could=20
> inline assembler or perhaps mmap() do the trick (I'm using C as=20
> programming language)?.
>
>
>
> Regards,
>  Bjorn
>
>
>
>  <ATT07173.txt>=
