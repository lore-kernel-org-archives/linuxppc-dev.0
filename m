Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 561F32C00D3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 May 2013 07:11:44 +1000 (EST)
Message-ID: <1367529089.4389.23.camel@pasglop>
Subject: Re: [PATCH net-next] af_unix: fix a fatal race with bit fields
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Date: Fri, 03 May 2013 07:11:29 +1000
In-Reply-To: <20130501081054.267a7851@nehalam.linuxnetplumber.net>
References: <1367370761.11020.22.camel@edumazet-glaptop>
 <20130501115103.58e40f37@kryten>
 <1367375060.11020.24.camel@edumazet-glaptop>
 <20130501035425.GD5221@bubble.grove.modra.org>
 <1367384672.11020.34.camel@edumazet-glaptop>
 <20130501081054.267a7851@nehalam.linuxnetplumber.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Eric Dumazet <eric.dumazet@gmail.com>, Alan Modra <amodra@gmail.com>,
 netdev <netdev@vger.kernel.org>, Ambrose Feinstein <ambrose@google.com>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2013-05-01 at 08:10 -0700, Stephen Hemminger wrote:
> > These kind of errors are pretty hard to find, its a pity to spend
> time
> > on them.
> 
> There is a checkbin target inside arch/powerpc/Makefile
> Shouldn't a check be added there to block building kernel with known
> bad GCC versions?

In this case that makes it all GCC versions except the *very
latest* .... not practical.

I suppose we should try to make sure that at least the next batch of
enterprise distro get that fix on gcc side.

Ben.
