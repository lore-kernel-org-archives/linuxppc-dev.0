Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8C88CDE014
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 05:08:26 +1000 (EST)
In-Reply-To: <20071015184743.GA4474@loki.buserror.net>
References: <20071015153525.GA28761@localhost.localdomain>
	<47138A54.8030307@ru.mvista.com>
	<20071015155730.GA30008@localhost.localdomain>
	<20071015184743.GA4474@loki.buserror.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3387D0D7-EBB8-4346-853D-75850159BCE4@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/2] [RFC][POWERPC] MPC8568E-MDS: create localbus node
Date: Mon, 15 Oct 2007 14:08:43 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 15, 2007, at 1:47 PM, Scott Wood wrote:

> On Mon, Oct 15, 2007 at 07:57:30PM +0400, Anton Vorontsov wrote:
>> On Mon, Oct 15, 2007 at 07:42:12PM +0400, Sergei Shtylyov wrote:
>>>    Is the entity described as "localbus" indeed so *board* specific?
>>
>> That's what booting-without-of.txt gives as an example.
>
> The board should have been left out of that.  Your compatible  
> should be
> something like "fsl,mpc8568-localbus", possibly with some canonical  
> mpc85xx
> chip as well, chosen to represent 85xx localbus in general.

Lets be careful, there are at least two forms of localbus on 85xx.

- k
