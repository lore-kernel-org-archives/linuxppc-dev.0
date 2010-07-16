Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 2E89A1007D8
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Jul 2010 06:45:44 +1000 (EST)
Date: Fri, 16 Jul 2010 13:45:58 -0700 (PDT)
Message-Id: <20100716.134558.235673512.davem@davemloft.net>
To: jwboyer@linux.vnet.ibm.com
Subject: Re: [PATCH 1/2] Remove REDWOOD_[456] config options and
	conditional code
From: David Miller <davem@davemloft.net>
In-Reply-To: <20100716142055.GA11736@zod.rchland.ibm.com>
References: <cover.1279282865.git.qy03fugy@stud.informatik.uni-erlangen.de>
	<ca1bb25d203618c3548748f5efb6f125a96c89e0.1279282865.git.qy03fugy@stud.informatik.uni-erlangen.de>
	<20100716142055.GA11736@zod.rchland.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: randy.dunlap@oracle.com, linuxppc-dev@ozlabs.org, linux@kbdbabel.org,
	paulus@samba.org, john.linn@xilinx.com, davidb@quicinc.com,
	ladis@linux-mips.org, solomon@linux-wlan.com,
	vamos-dev@i4.informatik.uni-erlangen.de, vapier@gentoo.org,
	florian@openwrt.org, Artem.Bityutskiy@nokia.com,
	qy03fugy@stud.informatik.uni-erlangen.de, nico@fluxnic.net,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	miltonm@bga.com, jkosina@suse.cz, joe@perches.com,
	linux-mtd@lists.infradead.org, dwmw2@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Date: Fri, 16 Jul 2010 10:20:55 -0400

> On Fri, Jul 16, 2010 at 02:29:02PM +0200, Christian Dietrich wrote:
>>The config options for REDWOOD_[456] were commented out in the powerpc
>>Kconfig. The ifdefs referencing this options therefore are dead and all
>>references to this can be removed (Also dependencies in other KConfig
>>files).
>>
>>Signed-off-by: Christian Dietrich <qy03fugy@stud.informatik.uni-erlangen.de>
>>Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
> 
> This seems fine with me.
> 
> The only question is which tree it coms through.  I'm happy to take it
> in via mine if the netdev and MTD people are fine with that.  Otherwise,
> my ack is below.
> 
> Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

Please take it:

Acked-by: David S. Miller <davem@davemloft.net>
