Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1D1E4DDE1D
	for <linuxppc-dev@ozlabs.org>; Sat, 15 Sep 2007 02:02:50 +1000 (EST)
Message-ID: <46EAB10A.7070204@genesi-usa.com>
Date: Fri, 14 Sep 2007 17:04:26 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [NEWBIE] Interrupt-problem mpc5200
References: <20070906133050.GE11807@sfrouter>
	<20070911124154.GI11807@sfrouter>	
	<fa686aa40709110719j26a5bf30uc075253c6d1a6d97@mail.gmail.com>	
	<20070911182811.GA3582@sfrouter>	
	<fa686aa40709111205n5d9f9654m6f2b96d468dfd017@mail.gmail.com>	
	<46EA8CD7.2050304@genesi-usa.com>	
	<fa686aa40709140753sb3e0e9cv28fa5215f4db3a@mail.gmail.com>	
	<46EAA65E.5080006@genesi-usa.com>
	<fa686aa40709140849o400fc5d0oaaee540fa416fefe@mail.gmail.com>
In-Reply-To: <fa686aa40709140849o400fc5d0oaaee540fa416fefe@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, "S. Fricke" <silvio.fricke@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Grant Likely wrote:
> 
> No, they are explicitly numbered.  Are you looking at the 5200 or the
> 5200B user manual?

MPC5200B User's Manual, Rev. 1.3 (MPC5200BUM.pdf)

>  In my copy, on page 7-17, I see this:

Ah! 7-20 here. Do we have different revisions of the manual, perhaps? :)

   PSa0 in
> peripheral interrupt 0 (l2=0), PSa23 is peripheral interrupt #23
> (l2=23)
> 
>        Bits        Name
>          8       PSa23  BestCom

So, the numbering of the interrupts is not derived from anything but
the "Name" field in those tables? 0 1 3 would be Slice Timer 0, 1 0 3
would be Slice Timer 1 (main, interrupt 0, we always use 3 on Efika
for some reason) and 1 9 3 would be TMR0? PCI control and initiator
interrupts would be 2 (8,9,10) 3?

Well, this certainly makes a lot more sense, at least in terms of
deriving the numbers, however it looks like it's a fairly nonsensical
numbering system to be fair.

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
