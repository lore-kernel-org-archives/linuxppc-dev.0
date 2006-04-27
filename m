Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3F48367A0E
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 05:42:41 +1000 (EST)
In-Reply-To: <44511C88.1010107@smiths-aerospace.com>
References: <20060427190547.1DD90353DAC@atlas.denx.de>
	<D358E665-60E4-48C0-82FD-7A1C16DAF00C@kernel.crashing.org>
	<44511C88.1010107@smiths-aerospace.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <7E753264-98AF-4B07-844E-7D0840E2269A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [U-Boot-Users] Re: FT u-boot shim
Date: Thu, 27 Apr 2006 14:42:34 -0500
To: Jerry Van Baren <gerald.vanbaren@smiths-aerospace.com>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	U-Boot Users <u-boot-users@lists.sourceforge.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[snip]

> A thought that keeps recurring (but I've suppressed because I don't  
> have time to play...) is that it would be Really Cool[tm] to store  
> the u-boot env variables in a flat tree and then pass the env/tree  
> to linux.  It also sounds like a major change & disruption to u- 
> boot :-(.  I haven't looked at what it would do to code size either.

I believe this is already supported in u-boot as a config option.   
You can also pass the bd_t to the kernel via the flat dev tree if you  
want.

- kumar
