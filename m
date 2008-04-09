Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E77A6DE022
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Apr 2008 01:27:16 +1000 (EST)
Message-Id: <9258E8EF-27DF-44C4-BF73-335D9EB5DD7A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Wood Scott <scottwood@freescale.com>
In-Reply-To: <fa686aa40804090826j1cd5c9c2t3bd95eeb9e356a48@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] 83xx/85xx: Reorganize defconfigs
Date: Wed, 9 Apr 2008 10:27:04 -0500
References: <Pine.LNX.4.64.0804091017440.18753@blarg.am.freescale.net>
	<fa686aa40804090826j1cd5c9c2t3bd95eeb9e356a48@mail.gmail.com>
Cc: ppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 9, 2008, at 10:26 AM, Grant Likely wrote:
> On Wed, Apr 9, 2008 at 9:18 AM, Kumar Gala  
> <galak@kernel.crashing.org> wrote:
>> Board specific defconfigs are useful, however with the ability to do
>> multi-board defconfigs they aren't needed in the top level configs  
>> directory
>>
>> Move the 83xx/85xx board specific defconfigs to individual  
>> directories under
>> arch/powerpc/configs.
>>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> Acked-by: Grant Likely <grant.likely@secretlab.ca>

Scott is 8xx capable of having a generic defconfig such that we can  
build a single kernel image that will run on the various boards?

- k
