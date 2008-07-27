Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 0DA64DDEFF
	for <linuxppc-dev@ozlabs.org>; Sun, 27 Jul 2008 17:55:19 +1000 (EST)
Date: Sun, 27 Jul 2008 00:55:18 -0700 (PDT)
Message-Id: <20080727.005518.08712012.davem@davemloft.net>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 0/5] powerpc tracehook
From: David Miller <davem@davemloft.net>
In-Reply-To: <1217145165.11188.132.camel@pasglop>
References: <20080727064859.69692154280@magilla.localdomain>
	<1217145165.11188.132.camel@pasglop>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org,
	roland@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sun, 27 Jul 2008 17:52:45 +1000

> On Sat, 2008-07-26 at 23:48 -0700, Roland McGrath wrote:
> > These patches are posted for review, but you can just pull the GIT branch
> > if you prefer.  Patch 1/5 corrects a long-standing (minor) error in ptrace
> > behavior.  The others change no existing behavior, just enable new and
> > future features to work on the arch.
> 
> Hi Roland !
> 
> Thanks for this. I haven't followed the story of tracehook so far, are
> those patches dependent on something else or it's all already upstream
> and do you think that's still 2.6.27 material ?

The infrastructure is in Linus's tree.
