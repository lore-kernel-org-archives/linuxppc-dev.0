Return-Path: <richardcochran@gmail.com>
Received: from mail-fx0-f42.google.com (mail-fx0-f42.google.com
	[209.85.161.42]) by ozlabs.org (Postfix) with ESMTP id 4FB4D1007D1
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jun 2010 20:21:44 +1000 (EST)
Received: by fxm5 with SMTP id 5so2134125fxm.15
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Jun 2010 03:21:42 -0700 (PDT)
Date: Thu, 10 Jun 2010 12:22:26 +0200
From: Richard Cochran <richardcochran@gmail.com>
To: Anton Vorontsov <cbouatmailru@gmail.com>
Subject: Re: [PATCH] gianfar: Revive the driver for eTSEC devices (disable
	timestamping)
Message-ID: <20100610102226.GA10653@riccoc20.at.omicron.at>
References: <20100609193219.GA8629@oksana.dev.rtsoft.ru>
	<20100610062907.GA3390@riccoc20.at.omicron.at>
	<20100610093159.GA30822@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100610093159.GA30822@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	David Miller <davem@davemloft.net>,
	Manfred Rudigier <Manfred.Rudigier@omicron.at>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 10, 2010 at 01:31:59PM +0400, Anton Vorontsov wrote:
> > No, we did not set TMR_CTRL[TE].
> 
> So, you deliberately violate the spec and expect it to work
> everywhere? :-)

Sometimes one must read the manual with a grain of salt ;)

> > > Also, I recall that Freescale BSPs were explicitly disabling the
> > > timestamping because of a performance drop.
> > 
> > The BSPs that we have, for the MPC8313ERDB and the P2020RBD both
> > include a (hacky) PTP timestmaping driver. Can you be more specific
> > about where and when Freescale is disabling timestamping?
> 
> Well, bitshrine site no longer allows[1] to list patches at
> http://www.bitshrine.org/gpp/ , but there was a patch for sure.
> 
> I'll try to find it in a bunch of .iso files that I have on disk
> tho.

Thanks, that will help to track the problem down.

> U-Boot 1.1.6 (Oct  9 2007 - 20:42:39) MPC83XX
...
> CPU: MPC8313E, Rev: 10 at 333.333 MHz

We have a newer CPU revision:

   U-Boot 1.3.0 (Dec 23 2008 - 13:38:14) MPC83XX
   CPU:   e300c3, MPC8313E, Rev: 21 at 333.333 MHz, CSB:  166 MHz

Perhaps a bug was fixed between revision 10 and 21...

You mentioned having trouble on the MPC8568EMDS. Was it the same
problem?

Thanks,
Richard
