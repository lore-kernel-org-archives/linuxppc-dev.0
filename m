Return-Path: <miltonm@sullivan.realtime.net>
Received: from sullivan.realtime.net (sullivan.realtime.net [205.238.132.226])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 59A59DE007
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 08:16:23 +1100 (EST)
Date: Mon, 19 Mar 2007 15:16:16 -0600 (CST)
Message-Id: <200703192116.l2JLGGp5021149@sullivan.realtime.net>
From: Milton Miller <miltonm@bga.com>
Sender: Milton Miller <miltonm@realtime.net>
Subject: Re: [PATCH 8/15] zImage: Cleanup and improve zImage entry point
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20070317013859.GJ3969%40localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue Mar 20 02:06:01 EST 2007, Scott Wood wrote:
> On Sat, Mar 17, 2007 at 12:38:59PM +1100, David Gibson wrote:
> > On Fri, Mar 16, 2007 at 11:21:35AM -0500, Scott Wood wrote:
> > > One problem with that is that the wrapper currently only accepts one
> > > platform .o file -- and presumably one isn't going to want to do all of
> > > the platform code in assembly.
> > 
> > Um.. nobody does it yet, but I don't think there's actually any reason
> > that $platformo can't be set to a list of multiple .o files.
> 
> Sorry, I was thinking about the default generation of a .o file from the
> platform name.  Obviously, the wrapper script can add to platformo.
> 
> Still, I think it'd be better to only stick something other than crt0 at
> the beginning if the platform explicitly asks for it.

I tested setting platform.o to multiple files.   Another option
is to link multiple platform files together into one .o file, but
if there are potentially shared this becomes letss apealing from
a space perspective.

milton
