Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9D3C3DDF2E
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Jun 2008 23:47:52 +1000 (EST)
Message-Id: <048926C3-B5B8-4E99-BCDD-B545CF8112B6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <4405563e1705f79e64477ec96f39abb4d57397dc.1214271072.git.michael@ellerman.id.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH 12/14] powerpc: Add logic to patch alternative feature
	sections
Date: Tue, 24 Jun 2008 08:47:38 -0500
References: <fd46b7fc5f4785affb58f1de2b85a63b154e0de8.1214271072.git.michael@ellerman.id.au>
	<4405563e1705f79e64477ec96f39abb4d57397dc.1214271072.git.michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 23, 2008, at 8:33 PM, Michael Ellerman wrote:

> This patch adds the logic to patch alternative sections. This is  
> fairly
> straight forward, except for branches. Relative branches that jump  
> from
> inside the else section to outside of it, need to be translated as  
> they're
> moved, otherwise they will jump to the wrong location.

this should really be part of the 'Introduce infrastructure for  
feature sections with alternatives' patch.  The two are really coupled  
(one doesn't make sense w/o the other).

- k
