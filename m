Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 34BC1DDDFF
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Dec 2007 07:36:47 +1100 (EST)
Date: Wed, 26 Dec 2007 23:38:08 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] [POWERPC] MPC8360E-RDK: Device tree and board file
Message-ID: <20071226203808.GA18128@localhost.localdomain>
References: <20071221202309.GA4557@localhost.localdomain>
	<476DD544.2050807@freescale.com>
	<20071224121546.GA7903@localhost.localdomain>
	<47716BBE.5090000@freescale.com>
	<20071226162943.GB11230@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20071226162943.GB11230@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 26, 2007 at 07:29:44PM +0300, Anton Vorontsov wrote:
> On Tue, Dec 25, 2007 at 02:44:46PM -0600, Timur Tabi wrote:
> > Anton Vorontsov wrote:
> > 
> > >Yup. I've seen it, thanks. I'm going to test it as well. ;-)
> > 
> > If they work for you, please let Kumar know.
> 
> Unfortunately they don't.
> 
> root@mpc8360erdk:~# echo abc > /dev/ttyQE0
> 
> And hang. No interrupts.

I've just tried to set CD and CTS to GPIO functions (for loopbacking),
as suggested in the ref manual.. and still it doesn't work. Hm..

-- 
Anton Vorontsov
email: cbou@mail.ru
backup email: ya-cbou@yandex.ru
irc://irc.freenode.net/bd2
