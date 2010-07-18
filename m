Return-Path: <dedekind1@gmail.com>
Received: from mail-fx0-f42.google.com (mail-fx0-f42.google.com
	[209.85.161.42]) by ozlabs.org (Postfix) with ESMTP id 2BC1BB6F01
	for <linuxppc-dev@ozlabs.org>; Mon, 19 Jul 2010 02:52:40 +1000 (EST)
Received: by fxm17 with SMTP id 17so1900201fxm.15
	for <linuxppc-dev@ozlabs.org>; Sun, 18 Jul 2010 09:52:38 -0700 (PDT)
Subject: Re: [PATCH 1/2] Remove REDWOOD_[456] config options and
	conditional code
From: Artem Bityutskiy <dedekind1@gmail.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20100716142055.GA11736@zod.rchland.ibm.com>
References: <4f07b3092cafbbba37d61d367cc7484e24d18d2a.1279116162.git.qy03fugy@stud.informatik.uni-erlangen.de>
	<redwood56-reply-1-miltonm@bga.com>
	<cover.1279282865.git.qy03fugy@stud.informatik.uni-erlangen.de>
	<ca1bb25d203618c3548748f5efb6f125a96c89e0.1279282865.git.qy03fugy@stud.informatik.uni-erlangen.de>
	<20100716142055.GA11736@zod.rchland.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Sun, 18 Jul 2010 19:52:31 +0300
Message-Id: <1279471951.16247.61.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Randy Dunlap <randy.dunlap@oracle.com>, linuxppc-dev@ozlabs.org,
	Alexander Kurz <linux@kbdbabel.org>, Paul Mackerras <paulus@samba.org>,
	John Linn <john.linn@xilinx.com>, David Brown <davidb@quicinc.com>,
	Ladislav Michl <ladis@linux-mips.org>,
	Solomon Peachy <solomon@linux-wlan.com>,
	vamos-dev@i4.informatik.uni-erlangen.de,
	Mike Frysinger <vapier@gentoo.org>, Florian Fainelli <florian@openwrt.org>,
	Artem Bityutskiy <Artem.Bityutskiy@nokia.com>,
	Christian Dietrich <qy03fugy@stud.informatik.uni-erlangen.de>,
	Nicolas Pitre <nico@fluxnic.net>, Jiri Kosina <jkosina@suse.cz>,
	linux-kernel@vger.kernel.org, Milton Miller <miltonm@bga.com>,
	netdev@vger.kernel.org, Joe Perches <joe@perches.com>,
	linux-mtd@lists.infradead.org, David Woodhouse <dwmw2@infradead.org>,
	"David S. Miller" <davem@davemloft.net>
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-07-16 at 10:20 -0400, Josh Boyer wrote:
> On Fri, Jul 16, 2010 at 02:29:02PM +0200, Christian Dietrich wrote:
> >The config options for REDWOOD_[456] were commented out in the powerpc
> >Kconfig. The ifdefs referencing this options therefore are dead and all
> >references to this can be removed (Also dependencies in other KConfig
> >files).
> >
> >Signed-off-by: Christian Dietrich <qy03fugy@stud.informatik.uni-erlangen.de>
> >Signed-off-by: Christoph Egger <siccegge@cs.fau.de>
> 
> This seems fine with me.
> 
> The only question is which tree it coms through.  I'm happy to take it
> in via mine if the netdev and MTD people are fine with that.  Otherwise,
> my ack is below.
> 
> Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

You know how slow MTD people may be sometimes, so I'd suggest you to
merge this via whatever tree. David is in CC, he'll complain if he is
unhappy, I think.

-- 
Best Regards,
Artem Bityutskiy (Артём Битюцкий)
