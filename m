Return-Path: <domen.puncer@telargo.com>
Received: from kukmak.uni-mb.si (kukmak.uni-mb.si [164.8.100.3])
	by ozlabs.org (Postfix) with ESMTP id 450A4DDE32
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 Oct 2007 03:14:49 +1000 (EST)
Date: Sun, 21 Oct 2007 19:14:36 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] mpc5200: /dev/watchdog driver for GPT0
Message-ID: <20071021171436.GA1466@nd47.coderock.org>
References: <20070612085931.GG23294@moe.telargo.com>
	<ECDF5931-F264-4083-B4F0-C8CA1976195A@kernel.crashing.org>
	<fa686aa40710210955v14de2e78g88bf8c0d74482176@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <fa686aa40710210955v14de2e78g88bf8c0d74482176@mail.gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 21/10/07 10:55 -0600, Grant Likely wrote:
> On 6/13/07, Kumar Gala <galak@kernel.crashing.org> wrote:
> >
> > On Jun 12, 2007, at 3:59 AM, Domen Puncer wrote:
> >
> > > Driver for internal mpc5200 watchdog on general purpose timer 0.
> > > For IPB clock of 132 MHz the maximum timeout is about 32 seconds.
> > >
> > >
> > > Signed-off-by: Domen Puncer <domen.puncer@telargo.com>
> >
> > Should really be submitted to the watchdog maintainer if you want
> > this in the kernel
> 
> Domen, are you going to respin this patch and submit it to the
> watchdog maintainer?

Uhm... checked drivers/char/watchdog/ lately? ;-)


	Domen

> 
> Cheers,
> g.
> 
> -- 
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
> grant.likely@secretlab.ca
> (403) 399-0195

-- 
Domen Puncer | Research & Development
.............................................................................................
Telargo d.o.o. | Zagrebška cesta 20 | 2000 Maribor | Slovenia
.............................................................................................
www.telargo.com
