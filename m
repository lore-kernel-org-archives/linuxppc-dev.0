Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0C906DDEEA
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Sep 2007 05:36:56 +1000 (EST)
In-Reply-To: <20070906192025.GA22775@ld0162-tx32.am.freescale.net>
References: <20070905192820.GG32398@ld0162-tx32.am.freescale.net>
	<85281ec227e35a9e466e68e3fdc7e6ef@kernel.crashing.org>
	<20070906141620.GB16353@ld0162-tx32.am.freescale.net>
	<f26578467468e38345e795ea5f1f7c42@kernel.crashing.org>
	<20070906180922.GA18750@ld0162-tx32.am.freescale.net>
	<598e0baf0dc1ca63b91f2a80ec8abe19@kernel.crashing.org>
	<20070906191255.GA22663@ld0162-tx32.am.freescale.net>
	<20070906192025.GA22775@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <43ad9218d498e2d01922a57ebfee2327@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 8/9] 8xx: Adder 875 support
Date: Thu, 6 Sep 2007 21:36:07 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> BTW, IEEE1275 seems to disagree:

No it doesn't.

>   A manufacturer-dependent string that generally specifies the model 
> name
>   and number (including revision level) for this device. The format of
>   the text string is arbitrary, although in conventional usage the 
> string
>   begins with the name of the device's manufacturer as with the name
>   property.

That would be "0ABCDEF,Adder MPC875" or "VWXYZ,Adder MPC875" --
not "some random string without a comma Adder MPC875".

>   Although there is no standard interpretation for the value of the 
> model
>   property, a specific device driver might use it to learn, for 
> instance,
>   the revision level of its particular device.

i.e., it is machine readable.


Segher
