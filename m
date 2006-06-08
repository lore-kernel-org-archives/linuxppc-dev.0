Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 614D2679E2
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jun 2006 07:01:10 +1000 (EST)
Message-ID: <44889011.4010008@garzik.org>
Date: Thu, 08 Jun 2006 17:01:05 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH 9/10] Add Vitesse 8244 PHY for MPC8641 HPCN platform.
References: <1149720298.23938.207.camel@cashmere.sps.mot.com>	
	<44887BD3.7000009@garzik.org>	
	<1149797603.23938.251.camel@cashmere.sps.mot.com>	
	<44888A37.3090401@garzik.org>	
	<1149799209.23938.256.camel@cashmere.sps.mot.com>	
	<44888CB3.1060507@garzik.org>
	<1149799949.23938.264.camel@cashmere.sps.mot.com>
In-Reply-To: <1149799949.23938.264.camel@cashmere.sps.mot.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Loeliger wrote:
> On Thu, 2006-06-08 at 15:46, Jeff Garzik wrote:
> 
>> I leave it up to you and Paul to coordinate, then :)
>>
>> I'm fine with the patch, and if its better to merge via linuxppc.git, 
>> that's OK with me.  If you would prefer to send it via my tree, to go 
>> ahead and get it in, that's fine too.
> 
> OK, thanks.  I need to re-submit 5 of 10 parts for
> other cleanup issues anyway, so I think I will:
> 
> - Resubmit the entire patch set,
> - Resubmit netdev parts to Paul, and netdev with
>   an added ACK: by you line (OK?),

OK with me.  Since we use a specific header to indicate such, that would be:

Acked-by: Jeff Garzik <jeff@garzik.org>
