Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net
	[151.189.21.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id AA35EDDF1F
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 17:06:28 +1000 (EST)
In-Reply-To: <20070410165639.1b619c34.kim.phillips@freescale.com>
References: <20070410165639.1b619c34.kim.phillips@freescale.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <377816979b46808cd11a12640ceabb14@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/4] powerpc: document max-speed and interface-type
	properties
Date: Thu, 12 Apr 2007 09:06:23 +0200
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

> +   - max-speed : The maximum speed supported by the controller (in 
> Mbit/s)
> +   - interface-type : a string naming the controller/PHY interface 
> type,
> +     i.e., one of "mii", "gmii", "sgmii", "tbi", "rmii", "rgmii", or 
> "rtbi".

This information should be in the PHY node, instead.
Both property values would normally be implied by
"compatible" in that node (and this node, for the
max speed).


Segher
