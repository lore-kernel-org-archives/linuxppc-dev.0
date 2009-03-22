Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id C5884DDE25
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Mar 2009 07:07:01 +1100 (EST)
Date: Sun, 22 Mar 2009 15:11:35 -0500
From: Olof Johansson <olof@lixom.net>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v2 09/13] net: Rework pasemi_mac driver to use of_mdio
	infrastructure
Message-ID: <20090322201135.GA9592@lixom.net>
References: <20090321222047.20493.87335.stgit@localhost.localdomain>
	<20090321222901.20493.67103.stgit@localhost.localdomain>
	<20090322154710.GA6473@lixom.net>
	<fa686aa40903221136k5a926381u69fe6e57b927d1d2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40903221136k5a926381u69fe6e57b927d1d2@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, davem@davemloft.net, afleming@freescale.com,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Mar 22, 2009 at 12:36:44PM -0600, Grant Likely wrote:
> On Sun, Mar 22, 2009 at 9:47 AM, Olof Johansson <olof@lixom.net> wrote:
> > Did you ever try building it? pasemi_defconfig gives me:
> 
> No.  I mentioned it in the series header email, but not in the patch
> description.  My 64bit build environment is broken at the moment so I
> couldn't build test the pasemi patch.  All the others are build
> tested.  I'll have it sorted out before I post v3.

Ah, my bad. I just glanced it over looking for the git URL. :)

> > The changes needed are trivial, include <linux/of_mdio.h> and remove the
> > variables, label and following code. I could send a patch but that's likely
> > more of a hassle than you fixing it up yourself?
> 
> Yeah, I'll fix it.  Thanks for the testing.
> 
> > Otherwise, with the above changes, seems to test out ok on my Electra.
> > When you checkin the changes, feel free to add:
> 
> Awesome.  Thanks for the testing.

NP! Thanks for doing this cleanup!


-Olof
