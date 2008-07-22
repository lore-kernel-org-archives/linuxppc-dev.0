Return-Path: <davem@davemloft.net>
Date: Tue, 22 Jul 2008 14:11:51 -0700 (PDT)
Message-Id: <20080722.141151.145185759.davem@davemloft.net>
To: jonsmirl@gmail.com
Subject: Re: netif_schedule and mpc5200_fec
From: David Miller <davem@davemloft.net>
In-Reply-To: <9e4733910807221403g512f6e37s6722c7950f881224@mail.gmail.com>
References: <9e4733910807221247r38509c76uf625195b712a1145@mail.gmail.com>
	<9e4733910807221403g512f6e37s6722c7950f881224@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: davem@redhat.com, Linuxppc-dev@ozlabs.org, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: "Jon Smirl" <jonsmirl@gmail.com>
Date: Tue, 22 Jul 2008 17:03:32 -0400

> On 7/22/08, Jon Smirl <jonsmirl@gmail.com> wrote:
> > I just updated to linus/master and mpc5200_fec won't boot.
> 
> It does boot, but this badness looks like it is coming from this
> patch. I don't know enough about networking to debug it.

The driver is doing a netif_wake_queue() when it should not.
I'll have a more detailed look at this and try to fix it
later.
