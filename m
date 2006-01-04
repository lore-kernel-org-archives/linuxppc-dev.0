Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 88A846899F
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  5 Jan 2006 02:00:54 +1100 (EST)
In-Reply-To: <20060104110440.13a4dc16.nathael.pajani@cpe.fr>
References: <20060104110440.13a4dc16.nathael.pajani@cpe.fr>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <521677D9-902C-4474-AF52-5474E7C35B05@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Wed, 4 Jan 2006 09:00:46 -0600
To: Nathael Pajani <nathael.pajani@cpe.fr>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: question about arch_initcall()
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Its like any other init call.

As for order look at include/linux/init.h

core_initcall() first and late_initcall() last.

There is no guarntee of the order in which functions are called =20
inside one group.

- kumar

On Jan 4, 2006, at 4:04 AM, Nathael Pajani wrote:

> Hi all
>
> I would like to know how this macro is used, and when is called the =20=

> function registered with it.
>
> thanks for all.
>
>
> ----
> Nathael PAJANI
> Ing=E9nieur CPE Lyon
> nathael.pajani@cpe.fr
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
