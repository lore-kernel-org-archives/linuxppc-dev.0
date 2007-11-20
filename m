Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5376EDDE1C
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 02:27:40 +1100 (EST)
Message-Id: <616F3860-D90A-4FCC-BC8B-7361B58C515D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <4742389E.5080700@pobox.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH 0/5] fixups for mpc8360 rev. 2.1 erratum #2 (RGMII Timing)
Date: Tue, 20 Nov 2007 09:27:06 -0600
References: <20071105121530.5c38fbb7.kim.phillips@freescale.com>
	<20071119173652.55e385b2.kim.phillips@freescale.com>
	<4742389E.5080700@pobox.com>
Cc: netdev@vger.kernel.org, paulus@samba.org, Li Yang <leoli@freescale.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 19, 2007, at 7:30 PM, Jeff Garzik wrote:

> Kim Phillips wrote:
>> On Mon, 5 Nov 2007 12:15:30 -0600
>> Kim Phillips <kim.phillips@freescale.com> wrote:
>>> Hello all,
>>>
>>> the following patches fix RGMII timing for rev. 2.1 of the mpc8360,
>>> according to erratum #2 (erratum text included below).  Basically  
>>> the
>>> most intrusive part is the addition of two new RGMII Internal Delay
>>> modes; one for TX delay only, and the other for RX delay only  
>>> (i.e, not
>>> both at the same time).
>>>
>>> Please review, and since this affects both netdev and powerpc trees,
>>> one maintainer should ack them for the other to push upstream (i.e,
>>> Kumar acks them, and Leo picks them up to go through netdev or the
>>> other way around; either way is fine with me).  I'm hoping they're
>>> trivial enough to go in 2.6.24.
>>>
>> Kumar, Leo, re-ping due to (a) it's been 2 weeks and (b) Anton  
>> Vorontsov has since
>> issued his Tested-by.
>> Might I suggest Kumar ack the powerpc patches, and Leo/Jeff apply 5/5
>> to go through netdev?
>
> FWIW I just got back from vacation...  I'm grabbing what DaveM has  
> collected into davem/netdev-2.6.git, and then going from there...

Jeff,

I've pulled and pushed the arch/powepc bits of these fixes.  I leave  
the PHYY and driver bits to you.

- k
