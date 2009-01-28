Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BDDFFDDF9B
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Jan 2009 02:06:17 +1100 (EST)
Message-Id: <9FE267F5-A95D-475D-A4EE-DD9174E6AC9E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: =?ISO-8859-1?Q?R=E9gis_Odey=E9?= <regis.odeye@kontron.com>
In-Reply-To: <49806DE7.6090101@kontron.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: MPIC Timers as clocksource
Date: Wed, 28 Jan 2009 09:05:45 -0600
References: <49806DE7.6090101@kontron.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 28, 2009, at 8:38 AM, R=E9gis Odey=E9 wrote:

> Hi everybody,
> Is there anyone who implemented a clocksource driver (drivers/=20
> clocksource) to deal with the MPIC timers especially with 86xx and =20
> 85xx soc's ?
> Regards.
>
> --=20

We have some code for using the timers but not as a clocksource.. Out =20=

of interest why do want this?

- k=
