Return-Path: <davem@davemloft.net>
Received: from shards.monkeyblade.net (shards.monkeyblade.net [198.137.202.13])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 244E9B6FBE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 May 2012 12:48:03 +1000 (EST)
Date: Thu, 10 May 2012 22:43:52 -0400 (EDT)
Message-Id: <20120510.224352.2149006669429730060.davem@davemloft.net>
To: paul.gortmaker@windriver.com
Subject: Re: linux-next: Tree for May 10 (net/phy)
From: David Miller <davem@davemloft.net>
In-Reply-To: <CAP=VYLon7XRoh9s==wGYjUPNAYaTk8QQx7FGRnaDR97v+O-zXA@mail.gmail.com>
References: <20120510192635.c6f3a55196bbf65f13956e44@canb.auug.org.au>
 <4FAC35E2.4060900@xenotime.net>
 <CAP=VYLon7XRoh9s==wGYjUPNAYaTk8QQx7FGRnaDR97v+O-zXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: sfr@canb.auug.org.au, david.daney@cavium.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, rdunlap@xenotime.net, linux-next@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Paul Gortmaker <paul.gortmaker@windriver.com>
Date: Thu, 10 May 2012 22:36:55 -0400

> On Thu, May 10, 2012 at 5:40 PM, Randy Dunlap <rdunlap@xenotime.net> wrote:
>> On 05/10/2012 02:26 AM, Stephen Rothwell wrote:
>>
>>> Hi all,
>>>
>>> Changes since 20120508:
>>
>>
>>
>> ERROR: "of_mdio_find_bus" [drivers/net/phy/mdio-mux.ko] undefined!
> 
> Not just randconfig, but also powerpc allmodconfig:
> 
> http://kisskb.ellerman.id.au/kisskb/buildresult/6291463/
> 
> Adding ppc ML to cc.

Adding the guilty party to the CC:.  This really stinks, especially
after I did give the patch submitter a hard time about getting the
dependencies right. :-/
