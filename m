Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 568BEB6F62
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2012 15:26:20 +1000 (EST)
Message-ID: <1335763568.20866.37.camel@pasglop>
Subject: Re: [REGRESSION][PATCH V4 3/3] bpf jit: Let the powerpc jit handle
 negative offsets
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: kaffeemonster@googlemail.com
Date: Mon, 30 Apr 2012 15:26:08 +1000
In-Reply-To: <4F9E188E.80503@googlemail.com>
References: <4F75CA89.4010709@googlemail.com> <4F75D2A5.7060407@googlemail.com>
 <20120403.180302.342779808900865443.davem@davemloft.net>
 <1333491102.3040.12.camel@pasglop> <1335753820.20866.27.camel@pasglop>
 <1335759088.20866.32.camel@pasglop> <4F9E1496.9060603@googlemail.com>
 <1335760199.20866.33.camel@pasglop> <4F9E188E.80503@googlemail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: eric.dumazet@gmail.com, matt@ozlabs.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> No idea, i was going by the old saying:
> "Thou shall not include kernel header, or you will feel the wrath of angry
> kernel gurus."

Heh :-)

Well, googling around, it looks like there's a mix of both type of
programs out there. Those using a struct bpf_program and those using a
struct soft_fprog.

Only the latter will work on BE machines as far as I can tell.

David, what's the right way to fix that ?

Cheers,
Ben.
