Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 682FEB6EF7
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  9 Jul 2010 05:47:55 +1000 (EST)
In-Reply-To: <1278614421.1801.0@antares>
References: <1278614421.1801.0@antares>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <DC489835-1F97-49DA-A00C-7D73D0EC0900@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] arch/powerpc/lib/copy_32.S: Use alternate memcpy for
	MPC512x and MPC52xx
Date: Thu, 8 Jul 2010 21:30:33 +0200
To: =?ISO-8859-1?Q?Albrecht_Dre=DF?= <albrecht.dress@arcor.de>
Cc: linuxppc-dev@lists.ozlabs.org, Steve Deiters <SteveDeiters@basler.com>,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Actually, this is something which might need closer attention - and  
> maybe some support in the device tree indicating which read or  
> write width a device can accept?

There already is "device-width"; the drivers never should use any other
access width unless they *know* that will work.


Segher
