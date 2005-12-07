Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 232E56884E
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  8 Dec 2005 03:39:07 +1100 (EST)
In-Reply-To: <03f747f66110e0d5976c2c03a76945aa@embeddededge.com>
References: <000a01c5fae0$98ae1150$0760120a@photon>
	<03f747f66110e0d5976c2c03a76945aa@embeddededge.com>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7EF185E6-FD8E-4310-81EB-2BED342CEAD8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Wed, 7 Dec 2005 10:39:02 -0600
To: Dan Malek <dan@embeddededge.com>
Cc: HappyPhot <happyphot@gmail.com>, linuxppc-embedded@ozlabs.org
Subject: Re: MPC8245 with its internal UART
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Dec 6, 2005, at 10:43 PM, Dan Malek wrote:

>
> On Dec 6, 2005, at 7:44 PM, HappyPhot wrote:
>
>> Who can tell me which flatform is similar to mine ? I've tried
>> "make sandpoint_defconfig", but seems not the right one.
>
> That's the one I would have recommended.  I don't think there
> is any Linux platform port that uses the 8245 internal DUART,
> at least not in the public source tree.  The DUART is actually
> pretty easy, just use the generic 8250 driver and point the address
> to the Embedded Utilities Block DUART.

The 2.6 kernel tree has support for the DUART on 8245 Sandpoint  
systems.  (We added it in the last few months).

- kumar
