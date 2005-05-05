Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id ECD7367B15
	for <linuxppc-dev@ozlabs.org>; Fri,  6 May 2005 00:00:55 +1000 (EST)
In-Reply-To: <7de437cded3ef3b030898889bf65e8c9@embeddededge.com>
References: <7de437cded3ef3b030898889bf65e8c9@embeddededge.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <49ea49620ccd32ef3032da76db24ad5d@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Thu, 5 May 2005 09:00:50 -0500
To: "Dan Malek" <dan@embeddededge.com>
Cc: Tom Rini <trini@kernel.crashing.org>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Set cpu explicitly in kernel compiles
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 5, 2005, at 7:24 AM, Dan Malek wrote:

>
>
> On May 5, 2005, at 1:22 AM, Paul Mackerras wrote:
>  > If you think we should have -mcpu=3Dxxx on the command line for =
4xx,
>  > 44x, 8xx, etc., then that's fine, but that is a separate problem=20
> from
>  > what my patch was addressing (one which my patch might make it=20
> easier
>  > to fix, though).
>
> I think that is exactly what we want, although I don't know how that =
is
>  separate from the patch you sent.=A0 My original comment was the =
patch
>  fixes the problem for only one of the cpu cores, not all of them.=A0=20=

> Which
>  then led into the subsequent suggestion of making the biarch work
>  like the past compilers, and we must specific the flags for POWER4
>  instead of the other way around.=A0 Without explicit -mcpu flags, the
>  existing compiler behavior is just fine .....=A0 but, I guess I'd be
> standing
>  in the way of progress to want this :-)

I agree with Dan here.  I think we should go ahead and extend the patch=20=

to set -mcpu and -mtune flags for the list of processors we have in=20
"Processor Type".  If I'm building a kernel for e500 or 4xx I might as=20=

well get a kernel that is tuned a bit more for the subarch. =20
Additionally, there should be some expert override ability, so if I=20
really want to do -mcpu=3D7455 -mtune=3D7455 I can.

- kumar
