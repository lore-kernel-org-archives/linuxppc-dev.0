Return-Path: <randy.dunlap@oracle.com>
Received: from agminet02.oracle.com (agminet02.oracle.com [141.146.126.229])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B520BDDE16
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Jul 2008 16:21:06 +1000 (EST)
Received: from agminet01.oracle.com (agminet01.oracle.com [141.146.126.228])
	by agminet02.oracle.com (Switch-3.2.4/Switch-3.1.7) with ESMTP id
	m665Pe8Z009332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Sun, 6 Jul 2008 00:25:45 -0500
Date: Sat, 5 Jul 2008 22:17:19 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: the printk problem
Message-Id: <20080705221719.949998e5.randy.dunlap@oracle.com>
In-Reply-To: <84144f020807051702q1fc6275cv358c5e33dc2677fc@mail.gmail.com>
References: <20080705125230.GA20166@damson.getinternet.no>
	<alpine.LFD.1.10.0807051045520.2815@woody.linux-foundation.org>
	<19f34abd0807051141h4ccfd0ar28660199f2bbf81f@mail.gmail.com>
	<20080705185253.GQ14894@parisc-linux.org>
	<84144f020807051702q1fc6275cv358c5e33dc2677fc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-ia64@vger.kernel.org, Matthew Wilcox <matthew@wil.cx>,
	Vegard Nossum <vegard.nossum@gmail.com>, linux-kernel@vger.kernel.org,
	Jan Engelhardt <jengelh@medozas.de>, linuxppc-dev@ozlabs.org,
	Peter Anvin <hpa@zytor.com>, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 6 Jul 2008 03:02:59 +0300 Pekka Enberg wrote:

> On Sat, Jul 05, 2008 at 08:41:39PM +0200, Vegard Nossum wrote:
> >> Single letters are bad because it hurts readability and limits the
> >> usefulness of the extension.</MHO>
> 
> On Sat, Jul 5, 2008 at 9:52 PM, Matthew Wilcox <matthew@wil.cx> wrote:
> > I think you need a little warning noise that goes off in your head that
> > means "I might be overdesigning this".  Linus' code is elegant and
> > solves a problem nicely.
> 
> Am I the only one who missed Linus' patch? Did it make it to the list?

No, you are not the only one.  It was on linuxppc-dev for some reason.
http://ozlabs.org/pipermail/linuxppc-dev/2008-July/059257.html

---
~Randy
Linux Plumbers Conference, 17-19 September 2008, Portland, Oregon USA
http://linuxplumbersconf.org/
