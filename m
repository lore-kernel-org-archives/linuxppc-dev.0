Return-Path: <kumar.gala@freescale.com>
Received: from motgate4.mot.com (motgate4.mot.com [144.189.100.102])
	by ozlabs.org (Postfix) with ESMTP id 8146E2BDA0
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 16 Oct 2004 07:05:33 +1000 (EST)
In-Reply-To: <20041015205903.1653.qmail@web53804.mail.yahoo.com>
References: <20041015205903.1653.qmail@web53804.mail.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Message-Id: <F1131EDD-1EED-11D9-BAB6-000393DBC2E8@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 15 Oct 2004 16:05:28 -0500
To: "annamaya" <annamaya@yahoo.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Floating point error on a MPC8280 based board
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

One guess with be some possible memory corruption.

- kumar

On Oct 15, 2004, at 3:59 PM, annamaya wrote:

>
>
> When I try to reboot my system on a MPC8280 eval
> board, I see the floating point error. Does anyone
>  know why is this happening?
>
> bash-2.05b# reboot -f
>  Restarting system
>  floating point used in kernel (task=3Dcf458000,
> pc=3Dff000104)
>
> Thank you.
>  -Navin.
>
> __________________________________________________
> Do You Yahoo!?
>  Tired of spam?=A0 Yahoo! Mail has the best spam protection around
> http://mail.yahoo.com
> _______________________________________________
> Linuxppc-embedded mailing list
>  Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
