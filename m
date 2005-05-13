Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id AA7D1679FA
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 13 May 2005 23:47:10 +1000 (EST)
In-Reply-To: <005b01c557bd$c04e2770$0301a8c0@chuck2>
References: <005b01c557bd$c04e2770$0301a8c0@chuck2>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <ed43f07150d50a594be2bc2589e902a0@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 13 May 2005 08:46:53 -0500
To: "Mark Chambers" <markc@mail.com>
Cc: PPC_LINUX <linuxppc-embedded@ozlabs.org>
Subject: Re: insmod problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On May 13, 2005, at 8:14 AM, Mark Chambers wrote:

> >
>  >
>  > You're using floating arithmetic in the kernel.
>  >
>  > That's not supported.
>  >
>  > Regards
>  >
>  > Pantelis
>  >
>
> Just for my edification:=A0 Is floating point itself not supported=20
> (floating
>  point register
>  corruption or something like that) or just linking to user space=20
> libraries?

Use of floating point registers and instructions.  Its possible to use=20=

FP in rare cases inside the kernel buts its extremely discouraged.

- kumar
