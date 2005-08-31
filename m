Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id 22A556822A
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Sep 2005 03:06:44 +1000 (EST)
Date: Wed, 31 Aug 2005 10:07:19 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Sven Luther <sven.luther@wanadoo.fr>
Message-ID: <20050831170719.GA14197@mag.az.mvista.com>
References: <20050830233205.GB24345@xyzzy.farnsworth.org>
	<20050831055934.871E41C00097@mwinf1107.wanadoo.fr>
	<20050831160417.GA3848@mag.az.mvista.com>
	<20050831163313.GA25391@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050831163313.GA25391@localhost.localdomain>
Cc: Nicolas DET <det.nicolas@free.fr>, linuxppc-dev@ozlabs.org
Subject: Re: Marvell MV6436xx ethernet driver patch
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 31, 2005 at 06:33:13PM +0200, Sven Luther wrote:

> Which is not used in the pegasos code path, as we are chrp though.

I wondered that after I sent the email.  So, yep, chrp_pegasos_eth.c
seem reasonable to me.

Mark
