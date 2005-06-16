Return-Path: <avolkov@varma-el.com>
Received: from amanaus.varma-el.com (unknown [195.144.244.147])
	by ozlabs.org (Postfix) with ESMTP id C7812679E7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Jun 2005 02:00:27 +1000 (EST)
Message-ID: <42B1A214.404@varma-el.com>
Date: Thu, 16 Jun 2005 20:00:20 +0400
From: Andrey Volkov <avolkov@varma-el.com>
MIME-Version: 1.0
To: Esben Nielsen <simlo@phys.au.dk>
References: <Pine.OSF.4.05.10506161721010.24601-100000@da410.phys.au.dk>
In-Reply-To: <Pine.OSF.4.05.10506161721010.24601-100000@da410.phys.au.dk>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Sylvain Munaut <tnt@246tNt.com>, linuxppc-embedded@ozlabs.org
Subject: Re: MPC5200/Lite5200 and ethernet
Reply-To: avolkov@varma-el.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>



Esben Nielsen wrote:
> On Thu, 16 Jun 2005, Andrey Volkov wrote:
> 
> 
>>Hi Esben
>>
>>Esben Nielsen wrote:
>>
>>>How do I turn on the in chip FEC ethernet controller in MPC5200 in the
>>>stock 2.6.12-rc6 kernel? Do I need an extra patch?
>>>
>>
>>take patch here:
>>http://ozlabs.org/pipermail/linuxppc-embedded/2005-April/017591.html
>>
>>But, since bestcomm still not converted to platform_bus/ppc_sys model,
>>it will not be included in vanilla 2.6.12 kernel.
>>
> 
> I managed to get something out of the bitkeeper tree referred to from
> http://www.246tnt.com/mpc52xx/
> It seems to be based on 2.6.10-rc2 right now - good enough for now.
> 
> Is that really the latest version now?
AFAIK almost all patches from http://www.246tnt.com/mpc52xx/ now in
vanilla kernel. Except, bestcomm, certainly :(.

> What happens when bitkeeper is gone (very soon now, right?)
> 
> To whom do I submit patches?
Quotation from linux/MAINTAINERS :) :

LINUX FOR POWERPC EMBEDDED MPC52XX
P:	Sylvain Munaut
M:	tnt@246tNt.com
W:	http://www.246tNt.com/mpc52xx/
W:	http://www.penguinppc.org/
L:	linuxppc-dev@ozlabs.org
L:	linuxppc-embedded@ozlabs.org
S:	Maintained

> 
> Esben
> 

-- 
Regards
Andrey Volkov

P.S. Sylvain, what did you planned do with bk/git problem?
