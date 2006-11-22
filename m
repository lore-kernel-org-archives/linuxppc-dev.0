Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-03.arcor-online.net (mail-in-03.arcor-online.net
	[151.189.21.43])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D2D5067BC4
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Nov 2006 11:47:11 +1100 (EST)
In-Reply-To: <1164141715.9752.5.camel@localhost>
References: <1164141715.9752.5.camel@localhost>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <AB369BAC-D5B9-45A1-B402-6657FB22FEC2@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Make 970MP detectable by oprofile
Date: Wed, 22 Nov 2006 01:47:03 +0100
To: Mike Wolf <mjw@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Oprofile
> needs to distinquish the MP from other 970 processors so it can add  
> some
> new counters specific to the 970MP

Just out of curiosity, what are those?  I never saw any,
but I'd love to know :-)


Segher
