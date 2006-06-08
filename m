Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 657E667C2B
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jun 2006 06:36:14 +1000 (EST)
Message-ID: <44888A37.3090401@garzik.org>
Date: Thu, 08 Jun 2006 16:36:07 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH 9/10] Add Vitesse 8244 PHY for MPC8641 HPCN platform.
References: <1149720298.23938.207.camel@cashmere.sps.mot.com>	
	<44887BD3.7000009@garzik.org>
	<1149797603.23938.251.camel@cashmere.sps.mot.com>
In-Reply-To: <1149797603.23938.251.camel@cashmere.sps.mot.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Loeliger wrote:
> On Thu, 2006-06-08 at 14:34, Jeff Garzik wrote:
>> Jon Loeliger wrote:
>>> Signed-off-by: Kriston Carson <KristonCarson@freescale.com>
>>> Signed-off-by: Xianghua Xiao <x.xiao@freescale.com>
>>> Signed-off-by: Jon Loeliger <jdl@freescale.com>
>> ACK, but patch does not apply to netdev-2.6.git#upstream.
>>
>> 	Jeff
> 
> Thanks, Jeff.
> 
> Are you willing to take the netdev parts as-is, then?
> Or would you like me to reformat the netdev parts to
> apply against the netdev-2.6.git#upstream branch?
> The patch is currently for the Paul Mackerras powerpc.git
> tree as it stands now.  Should we apply it through that
> path now as you have ACK'ed it?

Is it dependent on other stuff in Paul's tree?

Normally this should come through netdev-2.6.git#upstream...

	Jeff
