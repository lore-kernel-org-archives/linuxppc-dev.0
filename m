Return-Path: <jrigby@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id BD828679E9
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Feb 2006 05:20:07 +1100 (EST)
Message-ID: <43ECD9C8.3070003@freescale.com>
Date: Fri, 10 Feb 2006 11:22:00 -0700
From: John Rigby <jrigby@freescale.com>
MIME-Version: 1.0
To: Asier Llano Palacios <a.llano@ziv.es>
Subject: Re: Stability of MPC5200 FEC
References: <1139592010.14894.22.camel@localhost.localdomain>
In-Reply-To: <1139592010.14894.22.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: Sylvain Munaut <tnt@246tNt.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Do you have a lite5200 board that exhibits the same bad FEC behavior.  
If so you could try the new
version on it and see if things improve.


Asier Llano Palacios wrote:

>We are working with MPC5200 cpu. 
>We've been using it since early 2.6 kernel versions.
>We're currently quite stabilished with the version of the kernel Sylvain
>had before the Platform Device rework. But the problem is that we are
>experiencing that the FEC stops working after a long uptime.
>
>So, do you think that the current git version is more stable than the
>one we are using? Do you think that there is anything that could stop us
>upgrading to the latest version?
>
>The problem is that we have a custom board, with some custom devices, so
>it is not so easy to upgrade. We need to know that a new version, is
>more stable than the previous one, before we upgrade. As soon as we
>upgrade, we can help if we find any problem.
>
>Thank you,
>Asier Llano
>
>  
>
