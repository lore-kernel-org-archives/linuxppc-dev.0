Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 780EFDDE20
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 06:39:59 +1000 (EST)
Date: Wed, 11 Jul 2007 15:51:40 -0500
From: Olof Johansson <olof@lixom.net>
To: Maynard Johnson <maynardj@us.ibm.com>
Subject: Re: Resend: [PATCH] oprofile support for Power 5++
Message-ID: <20070711205140.GA7298@lixom.net>
References: <4693CC5B.4020207@linux.vnet.ibm.com>
	<14287.1184096639@neuling.org>
	<4693E7EF.4020708@linux.vnet.ibm.com> <911.1184099498@neuling.org>
	<1184101660.22547.104.camel@farscape.rchland.ibm.com>
	<4693FB3C.4060305@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4693FB3C.4060305@us.ibm.com>
Cc: willschm@linux.vnet.ibm.com, linuxppc-dev@ozlabs.org,
	Michael Neuling <mikey@neuling.org>, mjw@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 10, 2007 at 04:33:48PM -0500, Maynard Johnson wrote:
> Will Schmidt wrote:
> 
> > On Tue, 2007-07-10 at 15:31 -0500, Michael Neuling wrote:
> > 
> >>>>Does it make more sense to call this "ppc64/power5+rev3"?  
> >>>>  
> >>>
> >>>This is a change to support new counter setup for oprofile.  It may be the
> >>>same if there is a revision 4 or 5 etc.  So since the internal name was ++
> I have no idea if there will be a revision 4, etc, but I'm assuming the 
> behavior would be the same as rev 3.  So I'm not in favor of changing 

The way the cputable patch is now, the rev 4 would match the base revision
anyway.  Maybe it makes more sense to make PVR xxxx01xx and xxxx02xx
explicitly match the old power5+, and make everything else match power5++?

I guess it all depends on the chance of IBM doing another major rev of
power5. Given it's current phase of product maturity I suppose it's not
all that likely. Doing it this way saves yet another cputable entry as
well, since it would otherwise mean two added entries instead of one.


-Olof
