Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rWlGw4WtpzDqhm
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Jun 2016 14:57:28 +1000 (AEST)
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Subject: Re: [PATCH 0/6] eBPF JIT for PPC64
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Date: Sat, 18 Jun 2016 14:57:28 +1000
From: mpe <mpe@ellerman.id.au>
Cc: David Miller <davem@davemloft.net>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org, matt@ozlabs.org,
 kda@linux-powerpc.org, paulus@samba.org, ast@fb.com, daniel@iogearbox.net,
 ananth@in.ibm.com
In-Reply-To: <20160613054055.GV18654@naverao1-tp.localdomain>
References: <cover.1465304785.git.naveen.n.rao@linux.vnet.ibm.com>
 <20160610.224755.1614979708956751311.davem@davemloft.net>
 <20160613054055.GV18654@naverao1-tp.localdomain>
Message-ID: <be3047c2d5e669d3e070f69b28566609@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 2016-06-13 15:40, Naveen N. Rao wrote:
> On 2016/06/10 10:47PM, David Miller wrote:
>> From: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
>> Date: Tue,  7 Jun 2016 19:02:17 +0530
>> 
>> > Please note that patch [2] is a pre-requisite for this patchset, and is
>> > not yet upstream.
>>  ...
>> > [1] http://thread.gmane.org/gmane.linux.kernel/2188694
>> > [2] http://thread.gmane.org/gmane.linux.ports.ppc.embedded/96514
>> 
>> Because of #2 I don't think I can take this directly into the 
>> networking
>> tree, right?
>> 
>> Therefore, how would you like this to be merged?
> 
> Hi David,
> Thanks for asking. Yes, I think it is better to take this through the
> powerpc tree as all the changes are contained within arch/powerpc,
> unless Michael Ellerman feels differently.
> 
> Michael?

Yeah I was planning to take it.

I put it in my test tree last night but it broke the build for some 
configs.
Once that is fixed I'll take it via powerpc#next.

cheers
