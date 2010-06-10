Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id F1E23B7D83
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jun 2010 08:01:34 +1000 (EST)
Date: Fri, 11 Jun 2010 00:01:40 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH V4] powerpc/mpc512x: Add gpio driver
Message-ID: <20100611000140.53f0e104@wker>
In-Reply-To: <AANLkTik7pTXHdY9_sjL9Lyz68gk2qRUs0NaGpj_7nL7K@mail.gmail.com>
References: <1276185950-28451-1-git-send-email-agust@denx.de>
	<1276186867-29094-1-git-send-email-agust@denx.de>
	<AANLkTik7pTXHdY9_sjL9Lyz68gk2qRUs0NaGpj_7nL7K@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Wolfgang Denk <wd@denx.de>,
	Detlev Zundel <dzu@denx.de>, Matthias Fuchs <matthias.fuchs@esd.eu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Grant,

On Thu, 10 Jun 2010 15:48:42 -0600
Grant Likely <grant.likely@secretlab.ca> wrote:

> On Thu, Jun 10, 2010 at 10:21 AM, Anatolij Gustschin <agust@denx.de> wrote:
> > From: Matthias Fuchs <matthias.fuchs@esd.eu>
> >
> > This patch adds a gpio driver for MPC512X PowerPCs.
> >
> > It has been tested on our CAN-CBX-CPU5201 module that
> > uses a MPC5121 CPU. This platform comes with a couple of
> > LEDs and configuration switches that have been used for testing.
> >
> > Signed-off-by: Matthias Fuchs <matthias.fuchs@esd.eu>
> > Signed-off-by: Anatolij Gustschin <agust@denx.de>
> 
> Hi Anatolij,
> 
> Can you please rework this one on top of my next-devicetree branch.
> Change have been made to the of-gpio apis.

Ok, I'll look at it.

Anatolij
