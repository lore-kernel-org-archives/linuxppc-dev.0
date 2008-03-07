Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 88DC8DDF80
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Mar 2008 12:52:00 +1100 (EST)
Date: Thu, 6 Mar 2008 19:57:34 -0600
From: Olof Johansson <olof@lixom.net>
To: Alexandr Smirnov <asmirnov@ru.mvista.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 3/4] Emerson KSI8560 device tree
Message-ID: <20080307015734.GA6877@lixom.net>
References: <20080304162322.GA19634@ru.mvista.com>
	<20080306151451.GA25251@ru.mvista.com>
	<20080307002959.GC24142@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080307002959.GC24142@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 07, 2008 at 11:29:59AM +1100, David Gibson wrote:
> On Thu, Mar 06, 2008 at 06:14:51PM +0300, Alexandr Smirnov wrote:
> > Add device tree file for Emerson KSI8560 board.
> > 
> > Signed-off-by: Alexandr Smirnov <asmirnov@ru.mvista.com>
> 
> [snip]
> > +	soc@fdf00000 {
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		device_type = "soc";
> 
> Since this is a new board, is it feasible to require it to have a
> sufficient new u-boot version that we don't require this old
> device_type entry.

Here's a novel idea:

What if the device tree police spent a little more time on fixing up
existing DTS files and booting-without-of.txt, and a little less time
making it as hard as possible for people to get new board ports in?

That way, at least they would be demanding of new submissions what is
documented and already accepted.

Current booting-without-of.txt still claims that /soc should have
device_type "soc".


-Olof
