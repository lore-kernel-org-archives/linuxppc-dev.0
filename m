Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id A4A8267A33
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Apr 2005 11:40:11 +1000 (EST)
In-Reply-To: <4252B50C.2080700@xiphos.ca>
References: <4252B50C.2080700@xiphos.ca>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <bab21adad4b23b380b8a207187e6bb84@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Tue, 5 Apr 2005 20:40:07 -0500
To: "Joshua Lamorie" <jpl@xiphos.ca>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Recommendations: Small Embedded PPC chip with FPU
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

While, I'm not sure about the industrial temp & package sizes, the 824x=20=

line from Freescale might be what you are looking for.  Possibly, the=20
newer 834x line.

- kumar

On Apr 5, 2005, at 10:55 AM, Joshua Lamorie wrote:

> Gidday there,
>
> I am looking for a new PowerPC for some controls applications and I =
was
> wondering if anyone on this list might make some recommendations.=A0 I
> will be fabricating the board, so I'm just interested in the CPU.=A0
> Currently I'm doing everything on a Virtex-II Pro (PPC 405).
>
> I'm considering the MPC5200, but I would love to have something in a
>  smaller package.
>
> Requirements:
> =A0=A0=A0 - Linux support
>  =A0=A0=A0 - PowerPC w >=3D 16k D,I Cache
>  =A0=A0=A0 - FPU
>  =A0=A0=A0 - Onboard memory controller (SDRAM or DDR)
>  =A0=A0=A0 - >=3D 300 MHz
>  =A0=A0=A0 - Industrial temperature (-40 to +85)
>  =A0=A0=A0 - package size < 27mmx27mm
>  =A0=A0=A0 - everything else is icing
>
> Any suggestions welcome.
>
> I'm sorry if this is somewhat off topic.
>
> Joshua
>
> --=20
>
>  Xiphos Technologies
>  (514) 848-9640 x227
>  (514) 848-9644 fax
>
> www.xiplink.com
> _______________________________________________
> The information transmitted is intended only for the
>  person or entity to which it is addressed and may contain
>  confidential and/or privileged material.=A0 If you have
>  received this in error, please contact the sender and delete
>  this communication and any copy immediately. Thank you.
>
> _______________________________________________
> Linuxppc-embedded mailing list
>  Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
