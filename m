Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao03.cox.net (fed1rmmtao03.cox.net [68.230.241.36])
	by ozlabs.org (Postfix) with ESMTP id 1FD592BD6A
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Sep 2004 23:58:03 +1000 (EST)
Date: Mon, 27 Sep 2004 06:57:58 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Piotr Perak <peri@aqua.aspd.pwr.wroc.pl>
Message-ID: <20040927065758.B25288@home.com>
References: <Pine.LNX.4.21.0409271244030.8658-100000@aqua.aspd.pwr.wroc.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.21.0409271244030.8658-100000@aqua.aspd.pwr.wroc.pl>;
	from peri@aqua.aspd.pwr.wroc.pl on Mon, Sep 27, 2004 at
	12:46:07PM +0200
Cc: linuxppc-dev@ozlabs.org
Subject: Re: 2.6.x on 405CR
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 27, 2004 at 12:46:07PM +0200, Piotr Perak wrote:
> Hi.
> 
> Anyone seen 2.6.x kernel working on 405CR?
> I can't make it boot.

I can't recall anybody around here having a 405CR.  That's probably
why you didn't get a reponse the first time you posted this.

Since you are failing in ocp_add_one_device() and you have a
processor which doesn't have a chip definition in 2.6, the
problem is probably somewhere there.  Doublecheck your
arch/ppc/platforms/4xx/ibm405cr.c (you do have one, right?)
against a known good one in arch/ppc/platforms/4xx/ibm405gp.c

I wish I could rent you my BDI2000 to speed up your debugging,
but we're too far away from each other. :)

-Matt
