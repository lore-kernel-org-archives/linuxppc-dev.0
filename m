Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4F55F2C008A
 for <linuxppc-dev@ozlabs.org>; Tue, 14 May 2013 02:49:43 +1000 (EST)
In-Reply-To: <1368440850.24723.32.camel@i7.infradead.org>
References: <1368220707.3378.57.camel@shinybook.infradead.org>
 <20130513164819.1c9331b9@kryten>
 <20130513072013.GD5221@bubble.grove.modra.org>
 <1368440850.24723.32.camel@i7.infradead.org>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D300FBC9-E4C8-466E-8A06-29D9F9E4BC9B@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: provide __bswapdi2
Date: Mon, 13 May 2013 18:47:47 +0200
To: David Woodhouse <dwmw2@infradead.org>
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>,
 viro@zeniv.linux.org.uk, Alan Modra <amodra@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>> I did a little digging, and it looks like gcc-4.4 will emit  
>> __bswapdi2
>> calls.  Support in rs6000.md appeared 2009-06-25.
>
> That's where it was seen. I don't have anything that ancient any  
> more so
> it didn't show up in my testing, but Al saw it on a Debian system.

It should never happen on 32-bit -- it is broken into two bswapsi's --
although, old compiler, who knows.  Lack of testing makes some people
nervous though ;-)


Segher
