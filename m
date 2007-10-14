Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.181])
	by ozlabs.org (Postfix) with ESMTP id A2971DDEDA
	for <linuxppc-dev@ozlabs.org>; Mon, 15 Oct 2007 07:23:23 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so1856673wag
	for <linuxppc-dev@ozlabs.org>; Sun, 14 Oct 2007 14:23:22 -0700 (PDT)
Message-ID: <fa686aa40710141423o69666b16pa7ce6851fa407d5e@mail.gmail.com>
Date: Sun, 14 Oct 2007 15:23:21 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Sven Luther" <sven@powerlinux.fr>
Subject: Re: [PATCH v2 4/7] bestcomm: core bestcomm support for Freescale
	MPC5200
In-Reply-To: <20071014202535.GA29218@powerlinux.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20071014044041.23438.14070.stgit@trillian.cg.shawcable.net>
	<20071014044205.23438.36036.stgit@trillian.cg.shawcable.net>
	<20071014113336.GA23286@powerlinux.fr>
	<fa686aa40710141322h308db79ey921fd9d4cea5d1d5@mail.gmail.com>
	<20071014202535.GA29218@powerlinux.fr>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, domen.puncer@telargo.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 10/14/07, Sven Luther <sven@powerlinux.fr> wrote:
> On Sun, Oct 14, 2007 at 02:22:16PM -0600, Grant Likely wrote:
> > On 10/14/07, Sven Luther <sven@powerlinux.fr> wrote:
> > > On Sat, Oct 13, 2007 at 10:42:05PM -0600, Grant Likely wrote:
> > > > From: Sylvain Munaut <tnt@246tNt.com>
> > > >
> > > > This patch adds support for the core of the BestComm API
> > > > for the Freescale MPC5200(b). The BestComm engine is a
> > > > microcode-controlled / tasks-based DMA used by several
> > > > of the onchip devices.
> > > >
> > > > Setting up the tasks / memory allocation and all common
> > > > low level functions are handled by this patch.
> > > > The specifics details of each tasks and their microcode
> > > > are split-out in separate patches.
> > > >
> > > > This is not the official API, but a much cleaner one.
> > > > (hopefully)
> > > >
> > > > Signed-off-by: Sylvain Munaut <tnt@246tNt.com>
> > > > Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> > >
> > > Hi Grant, ...
> > >
> > > I am unsure if this is a regression with regard to Sylvain's patch, or
> > > somethign else, but it is no more possible to build bestcomm modular :
> >
> > Hmmm, interesting.  I'll try that out here this afternoon.
>
> Notice that domen said it was working, so it could have been a
> mismanipulation on my part, or some problem with the debian patches.
>
> The older patchset with 2.6.23-rc6 worked fine though, and making the
> main bestcomm module builtin solved the error messages. I did not spot
> anything obvious when looking at the code.

Yes, it is a regression.  There had been a change to the Makefile.
I've reverted it and it works fine now.  I'll repost v3 shortly.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
