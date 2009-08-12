Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 10E7AB7093
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 12 Aug 2009 23:42:24 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7D6F4DDD0C
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Aug 2009 23:42:23 +1000 (EST)
Message-Id: <4A90486C-8BF5-428C-9FD8-830D822C0D40@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20090812111954.GB31596@zod.rchland.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: ARM clock API to PowerPC
Date: Wed, 12 Aug 2009 08:40:35 -0500
References: <1250063825.15143.43.camel@pasglop>
	<20090812111954.GB31596@zod.rchland.ibm.com>
Cc: devicetree-discuss@lists.ozlabs.org, John Jacques <john.jacques@lsi.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Torez Smith <torez@us.ibm.com>, Russell King <rmk@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 12, 2009, at 6:19 AM, Josh Boyer wrote:

> On Wed, Aug 12, 2009 at 05:57:05PM +1000, Benjamin Herrenschmidt  
> wrote:
>> Hi folks !
>>
>> (Russell, let us know if you want to dropped from the CC list, but I
>> felt you may have some useful input to provide here).
>>
>> So I think it would be valuable to provide the ARM clock API  
>> exposed by
>> include/linux/clk.h on various PowerPC embedded hardware.
>
> I'm probably being particularly dense, and I haven't had my coffee  
> yet this
> morning, but you never actually said _why_ you think this is valuable?
>
> I'm a bit confused as to what problem you are trying to solve with  
> the API.

I'm in the same boat as you Josh.  I think there is value and utility  
here but not sure what problem Ben's trying to solve.

- k
