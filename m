Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id A727C1007D3
 for <linuxppc-dev@ozlabs.org>; Wed, 14 Dec 2011 14:00:28 +1100 (EST)
Message-ID: <1323831619.7671.9.camel@pasglop>
Subject: Re: [PATCH] powerpc: Fix swiotlb ops for ppc64
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Becky Bruce <beckyb@kernel.crashing.org>
Date: Wed, 14 Dec 2011 14:00:19 +1100
In-Reply-To: <C9D58E47-96F4-45ED-BE54-758D71B361FD@kernel.crashing.org>
References: <1323278391-21849-1-git-send-email-galak@kernel.crashing.org>
 <1323314600.12793.19.camel@pasglop>
 <F8F675D7-B3F9-45B8-92D3-A3D1F0BF7746@kernel.crashing.org>
 <4BCA9D4A-4284-4DE8-95B9-D5DBA9254CC1@kernel.crashing.org>
 <1323750427.19891.59.camel@pasglop>
 <C9D58E47-96F4-45ED-BE54-758D71B361FD@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-12-13 at 20:53 -0600, Becky Bruce wrote:
> The non-coherent "specialness" is in the dma sync stuff and no, I
> don't think the iotlb stuff deals with that properly.
> 
> Do you not have a problem with 1)?  If not then I think we can look at
> switching over; 2) was more of a secondary thing.

So let's switch over, avoid an #ifdef which is always a good thing...

Cheers,
Ben.
