Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A577AB6F76
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Jun 2011 08:33:07 +1000 (EST)
In-Reply-To: <A052DEF7-7DA0-4573-89EC-0A685ED4B498@pobox.com>
References: <20110511103443.GA2837@brick.ozlabs.ibm.com>
	<20110511104456.GK2837@brick.ozlabs.ibm.com>
	<BDD550B2-02CA-4B1A-A05B-6CB3EF89B7B3@suse.de>
	<20110516055809.GA3590@drongo>
	<D8CAE971-9A97-4C02-8908-2B199C81947A@suse.de>
	<20110527103334.GA4236@brick.ozlabs.ibm.com>
	<b833d9df4fc8e1e6a8b6a56311c6f344@kernel.crashing.org>
	<6A1CA2C8-8032-4D67-9C14-4ABD81ABCDD7@suse.de>
	<10cc079a31947ec4b6d39f30f2ac50f2@kernel.crashing.org>
	<A052DEF7-7DA0-4573-89EC-0A685ED4B498@pobox.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c71b71560e43813012b6f293230dc78e@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 10/13] kvm/powerpc: Add support for Book3S processors in
	hypervisor mode
Date: Wed, 1 Jun 2011 00:34:43 +0200
To: Jimi Xenidis <jimix@pobox.com>
Cc: kvm-ppc@vger.kernel.org, Linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Alexander Graf <agraf@suse.de>, KVM list <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>> Sure, but that shouldn't happen with HDEC during the odd 50 
>>> instructions that it takes to enter the guest :)
>>
>> It's more like 500 insns, including some ptesync, so lots of cycles 
>> too.
>
> I don't think its actually that bad.

There's a loop of 128 iterations of 3 insns.

I'm not saying it is actually bad, just that that 50 is slightly off ;-)


Segher
