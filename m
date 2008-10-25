Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 870DEDDDE3
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Oct 2008 21:11:01 +1100 (EST)
Date: Sat, 25 Oct 2008 14:10:58 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] [powerpc] GPIO: Adding new Xilinx driver
Message-ID: <20081025101058.GA11140@oksana.dev.rtsoft.ru>
References: <20081024195908.7D1A1142806C@mail74-wa4.bigfish.com>
	<20081024214159.GA15204@oksana.dev.rtsoft.ru>
	<fa686aa40810242307o31bdd128x4ea38627f504aa6e@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=windows-1251
In-Reply-To: <fa686aa40810242307o31bdd128x4ea38627f504aa6e@mail.gmail.com>
Cc: Kiran Sutariya <kirans@xilinx.com>, linuxppc-dev@ozlabs.org,
	John Linn <john.linn@xilinx.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Oct 25, 2008 at 12:07:06AM -0600, Grant Likely wrote:
> On Fri, Oct 24, 2008 at 3:41 PM, Anton Vorontsov
> <avorontsov@ru.mvista.com> wrote:
> > On Fri, Oct 24, 2008 at 12:59:00PM -0700, John Linn wrote:
> >> diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
> >> index 7f2ee27..f6b0da8 100644
> >> --- a/drivers/gpio/Kconfig
> >> +++ b/drivers/gpio/Kconfig
> >> @@ -65,6 +65,14 @@ config GPIO_SYSFS
> >>
> >>  # put expanders in the right section, in alphabetical order
> >>
> >> +comment "Memory mapped GPIO expanders:"
> >> +
> >> +config GPIO_XILINX
> >> +     bool "Xilinx GPIO support"
> >> +     depends on OF
> >
> > I persume that the driver wasn't build-tested on SPARC, so I'd recommend
> > to change the depends to PPC_OF. Plus, the driver should also select
> > GENERIC_GPIO and ARCH_REQUIRE_GPIOLIB. (Later we'll switch to
> > ARCH_WANT_OPTIONAL_GPIOLIB for whole PPC.)
> 
> ARCH_WANT_OPTIONAL_GPIOLIB seems to already be set for all of powerpc
> (arch/powerpc/Kconfig, line 113).

Ah yes, I see it now. Thanks.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
