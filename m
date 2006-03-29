Return-Path: <info@schihei.de>
Received: from schihei.org (schihei.net [81.169.184.117])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 21CAB67A44
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 03:56:05 +1100 (EST)
In-Reply-To: <2691DBEE-C7E2-46A3-8455-6F98806C3102@kernel.crashing.org>
References: <442AA34B.7050801@de.ibm.com>
	<2691DBEE-C7E2-46A3-8455-6F98806C3102@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v746.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FEF4C367-872B-416D-8166-E439D1F4F9A4@schihei.de>
From: Heiko J Schick <info@schihei.de>
Subject: Re: [PATCH] powerpc: Extends HCALL interface for InfiniBand usage
Date: Wed, 29 Mar 2006 18:55:58 +0200
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello,

On 29.03.2006, at 17:09, Segher Boessenkool wrote:

> All the other defines use StudlyCaps, yours use SHOUTING_CAPS, you
> might want to choose just one style (though I prefer the shouting  
> one).

if StudlyCaps are better (and more readable) than SHOUTING CAPS I can
change it. Not a big deal.

Regards,
	Heiko
