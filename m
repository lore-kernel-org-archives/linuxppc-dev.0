Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 02DE4DDECE
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Mar 2008 13:08:16 +1100 (EST)
In-Reply-To: <20080304015329.GE1393@localhost.localdomain>
References: <1204588953.7921.13.camel@basalt>
	<20080304005922.GB1393@localhost.localdomain>
	<1204594967.21545.46.camel@pasglop>
	<20080304015329.GE1393@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <08b18695c383fb829ecf3ab6c2822bd1@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Bamboo PCI interrupt issues
Date: Tue, 4 Mar 2008 03:07:50 +0100
To: David Gibson <dwg@au1.ibm.com>
Cc: kvm-ppc-devel <kvm-ppc-devel@lists.sourceforge.net>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Hollis Blanchard <hollisb@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> Uh.. there's no binding written down, it's just encoded into uic.c.
>>> But UIC doesn't use OpenPIC sensitivity encoding.  Like FSL's IPIC, 
>>> it
>>> uses Linux IRQ_TYPE values from include/linux/irq.h which makes 8
>>> "level sensitive, active-low".
>>
>> On a related note: aren't we taking a risk here of seeing those values
>> change in linux ?
>
> We've discussed this before.  If that happens, the binding must remain
> on the old values.  It means the driver will then need a translation
> which it doesn't now, but we can deal with it.

It also means it should be written down in the binding _already_.
Come on, how much work is that?


Segher
