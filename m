Return-Path: <tnt@246tNt.com>
Received: from outmx012.isp.belgacom.be (outmx012.isp.belgacom.be
	[195.238.5.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AA319679EA
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 29 Mar 2006 07:48:13 +1100 (EST)
Received: from outmx012.isp.belgacom.be (localhost [127.0.0.1])
	by outmx012.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id k2SKm6n7020833
	for <linuxppc-embedded@ozlabs.org>; Tue, 28 Mar 2006 22:48:07 +0200
	(envelope-from <tnt@246tNt.com>)
Message-ID: <4429A0E5.8010308@246tNt.com>
Date: Tue, 28 Mar 2006 22:47:33 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: John Rigby <jcrigby@gmail.com>
Subject: Re: Kernel for MPC Lite 5200 will not compile
References: <20060328000703.GA95672@server.idefix.loc>	<4b73d43f0603271701q24910d9rf4e61e5136c2b727@mail.gmail.com>	<20060328094939.GA43123@server.idefix.loc>
	<4b73d43f0603280815n3fc7bb5dq38b72f87f18b905f@mail.gmail.com>
In-Reply-To: <4b73d43f0603280815n3fc7bb5dq38b72f87f18b905f@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
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

Hi Matthias,

You might want to try the "quick start" section of
http://www.246tnt.com/mpc52xx/

The last compile I tried worked just fine ... You just needed to be sure
CONFIG_NET is
enabled (even if you don't use network ... the issue is known and being
taken care of,
I've seen some posts of Russel King and Andrew Morton about it).

If it still doesnt work, report it and I'll have a closer look. Maybe
something changed
recently and I didn't update my tree since a few days ...



Sylvain



John Rigby wrote:
> Sorry I'm not sure what the state of 5200 support in the eldk.  I know
> that Wolfgang
> has said that 2.6 is not supported though.  You may want to try out
> Sylvains
> kernel:  http://gitbits.246tnt.com/gitbits/linux-2.6-mpc52xx.git
>
> You can search in list for Syvains instructions on how to use it.
>
>
> On 3/28/06, *Matthias Fechner* <idefix@fechner.net
> <mailto:idefix@fechner.net>> wrote:
>
>     Hello John,
>
>     * John Rigby <jcrigby@gmail.com <mailto:jcrigby@gmail.com>>
>     [27-03-06 18:01]:
>     > try make lite5200_defconfig instead of copying it to .config
>     > or make oldconfig after copying ti to .config
>
>     I tried now several combinations with:
>     make ARCH=ppc CROSS_COMPILE=ppc_6xx- lite5200_defconfig
>     make ARCH=ppc CROSS_COMPILE=ppc_6xx- uImage
>
>     then coping the file to .config and
>     make ARCH=ppc CROSS_COMPILE=ppc_6xx- oldconfig
>     make ARCH=ppc CROSS_COMPILE=ppc_6xx- uImage
>
>     but it always leads to the same error message...
>
>     Best regards,
>     Matthias
>     _______________________________________________
>     Linuxppc-embedded mailing list
>     Linuxppc-embedded@ozlabs.org <mailto:Linuxppc-embedded@ozlabs.org>
>     https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
> ------------------------------------------------------------------------
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
