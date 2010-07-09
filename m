Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 97DD1B6F19
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  9 Jul 2010 23:02:39 +1000 (EST)
In-Reply-To: <1278619791.1801.4@antares>
References: <1278614421.1801.0@antares>
	<DC489835-1F97-49DA-A00C-7D73D0EC0900@kernel.crashing.org>
	<1278619791.1801.4@antares>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A2355F49-521A-4902-8FB4-D661234FA759@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] arch/powerpc/lib/copy_32.S: Use alternate memcpy for
	MPC512x and MPC52xx
Date: Fri, 9 Jul 2010 15:03:27 +0200
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Cc: David Woodhouse <dwmw2@infradead.org>,
	Steve Deiters <SteveDeiters@basler.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Hmm, unfortunately, it's usage is not clearly documented in mtd- 
> physmap.txt,

It's pretty clear I think.  Patches for making it better are welcome  
of course.

> so I never thought of this parameter.  And IMHO the problem goes  
> further - basically *any* chip which is attached to the LPB can be  
> affected by this problem, so it might be better to have a more  
> general approach like a "chip select property".

You cannot treat devices on the LPB as random access, that's all.   
Drivers
that assume they can, cannot be used for devices on the LPB.


Segher
