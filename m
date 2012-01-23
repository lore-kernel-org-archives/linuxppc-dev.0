Return-Path: <nvbolhuis@aimvalley.nl>
Received: from mika.eatserver.nl (mika.eatserver.nl [195.20.9.75])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 262D9B6FAB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jan 2012 21:30:34 +1100 (EST)
Message-ID: <9a7992e1b1d1c19efb0e2c8e4f35c28f.squirrel@intranet.aimsys.nl>
Date: Mon, 23 Jan 2012 10:34:06 +0100
Subject: Cannot wake-up from standby with MPC8313
From: nvbolhuis@aimvalley.nl
To: scottwood@freescale.com
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


>
> It is mentioned in the MPC8313E manual (4.2.2 step #10) that TRST must
> not be asserted except when PORESET is asserted.  The mpc8313erdb bug
> was that the board was not complying with this.
>

ok, I see.

The board did not comply to the spec and as a side-effect PMC
registers could not be accessed.

Thanks again for all help!

---
NvBolhuis
