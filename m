Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id 664DBDDEE7
	for <linuxppc-dev@ozlabs.org>; Mon,  2 Mar 2009 15:33:18 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so1200101yxb.39
	for <linuxppc-dev@ozlabs.org>; Sun, 01 Mar 2009 20:33:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <9e4733910903011819q105a856n163ccd8fee37d980@mail.gmail.com>
References: <1235575933-29691-1-git-send-email-w.sang@pengutronix.de>
	<20090301101815.GC23093@pengutronix.de>
	<fa686aa40903010648q238380acy34b58e04226d8014@mail.gmail.com>
	<9e4733910903010754q1b4d9fafy87668049653d5e21@mail.gmail.com>
	<fa686aa40903011447x1810f252m367d6c05cc567133@mail.gmail.com>
	<9e4733910903011637q246eb82al140e87242f695413@mail.gmail.com>
	<9e4733910903011646g43b151c2m7c6dfe80ac07e80a@mail.gmail.com>
	<fa686aa40903011707q3c142942w962c52abaf915629@mail.gmail.com>
	<9e4733910903011815q1a956be0x137bac80f2e21e72@mail.gmail.com>
	<9e4733910903011819q105a856n163ccd8fee37d980@mail.gmail.com>
Date: Sun, 1 Mar 2009 21:33:16 -0700
Message-ID: <fa686aa40903012033x6b6a76d6j7218d076f2c6ad3d@mail.gmail.com>
Subject: Re: [PATCH] powerpc/mpc52xx: add Phytec phyCORE-MPC5200B-IO board
	(pcm032)
From: Grant Likely <grant.likely@secretlab.ca>
To: Jon Smirl <jonsmirl@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Mar 1, 2009 at 7:19 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> Would it be easier to get Pengutronix to release a new u-boot for the
> pcm030? I'm using U-Boot 1.2.0-mpc5200b-tiny-2 (Apr 17 2007 -
> 11:49:20).

Only if it is a chip IO setup problem (like port_config or clock
setup).  Otherwise the kernel should be setting up the PCI controller
correctly.  Regardless, I don't think the kernel should be crashing
when PCI is in a funny state.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
