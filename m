Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 33BD5DDEE1
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Apr 2007 06:57:40 +1000 (EST)
In-Reply-To: <20070420151136.3fdb160f.kim.phillips@freescale.com>
References: <20070420151136.3fdb160f.kim.phillips@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <B0B16FB3-62D7-434B-9135-E87D2AFFFF07@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/4 v3] powerpc: document interface-type property
Date: Fri, 20 Apr 2007 15:57:36 -0500
To: Kim Phillips <kim.phillips@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 20, 2007, at 3:11 PM, Kim Phillips wrote:

> Since ucc_geth is being migrated to use the phylib, the existing
> (undocumented) 'interface' property is being deprecated in favour
> of a stringified version, 'interface-type'.
>
> interface-type is maintained one-to-one with definitions
> in include/linux/phy.h.  If not specified, "mii" is assumed.
>
> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
> ---
> removed max-speed property, since the name is apparently too generic
> (it's derived from the interface-type anyway)

Are you sure?  Is not possible to use a gmii phy on a 8323 and limit  
it to 10/100?

- k
