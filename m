Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id E8B5ADDE08
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Dec 2008 14:37:42 +1100 (EST)
Date: Sun, 21 Dec 2008 06:37:41 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH 2/6] ucc_geth: Fix TX watchdog timeout handling
Message-ID: <20081221033741.GB3885@oksana.dev.rtsoft.ru>
References: <20081218182326.GB30682@oksana.dev.rtsoft.ru>
	<ed82fe3e0812201919o619fd7e7jb87bbec551caa4d@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <ed82fe3e0812201919o619fd7e7jb87bbec551caa4d@mail.gmail.com>
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andy Fleming <afleming@freescale.com>,
	Li Yang <leoli@freescale.com>, Jeff Garzik <jgarzik@pobox.com>,
	David Miller <davem@davemloft.net>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Dec 20, 2008 at 09:19:23PM -0600, Timur Tabi wrote:
> On Thu, Dec 18, 2008 at 12:23 PM, Anton Vorontsov
> <avorontsov@ru.mvista.com> wrote:
> > +static int ucc_geth_close(struct net_device *dev);
> > +static int ucc_geth_open(struct net_device *dev);
> 
> I would prefer that you reorder the functions to eliminate the need
> for forward references.

I'll post a cleanup patch (0/6 series is already in the netdev tree).

Thanks!

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
