Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 821D1DDDD8
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 01:50:05 +1100 (EST)
Message-Id: <6A645055-3599-49DC-871C-2BC42199926F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20081021144110.GA7249@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: Please pull from 'for-2.6.28' branch
Date: Tue, 21 Oct 2008 09:49:58 -0500
References: <Pine.LNX.4.64.0810201304160.17086@blarg.am.freescale.net>
	<20081020191731.GA26789@oksana.dev.rtsoft.ru>
	<76F4ACB5-204A-46F7-BE4F-069CA58114B3@kernel.crashing.org>
	<20081020204737.GA13189@oksana.dev.rtsoft.ru>
	<20081021144110.GA7249@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 21, 2008, at 9:41 AM, Anton Vorontsov wrote:

>
> Maybe I was unclear... The OF interface change was accepted,
> so the QE pinmux patch doesn't depend on anything.. Thus, can we
> please merge the patch? It is needed for the FHCI USB driver,
> which I still hope could get in into the 2.6.28-rc2, since it
> is self-sufficient new feature that can't break anything.
>
> Thanks and sorry for the annoyance,

I understood, just haven't had time to look at these patches.  I don't  
know if this is likely to make it into 2.6.28.

- k
