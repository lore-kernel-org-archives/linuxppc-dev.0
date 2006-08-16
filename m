Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 43CD867B56
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Aug 2006 10:50:05 +1000 (EST)
In-Reply-To: <1155679316.10054.129.camel@cashmere.sps.mot.com>
References: <1155679316.10054.129.camel@cashmere.sps.mot.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <28ED599F-8D9C-4518-B227-7E84C5A38857@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Outstanding Patches Ping
Date: Tue, 15 Aug 2006 19:50:01 -0500
To: Jon Loeliger <jdl@freescale.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 15, 2006, at 5:01 PM, Jon Loeliger wrote:

> Paul,
>
> Where do we stand on these two outstanding patches
> that I have sent to the list?
>
>     - 08/03 Convert to mac-address for ethernet MAC data

Ack on the mac-address patch, and I think we should push it for  
2.6.18, it deals with an interface issue that we really should get  
into 2.6.18.

>     - 08/09 Offer PCI as a CONFIG choice for PPC_86xx
>
> I think all the outstanding issues and commentary
> on them was resolved.
>
> Thanks,
> jdl
>
>
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
