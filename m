Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 687E7DE089
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Apr 2008 15:20:47 +1000 (EST)
Date: Fri, 11 Apr 2008 00:31:36 -0500
From: Olof Johansson <olof@lixom.net>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] [v5] Add idle wait support for 44x platforms
Message-ID: <20080411053136.GB31810@lixom.net>
References: <df0f79b7b4ab628887c2.1207673354@thinkpadL>
	<200804101544.44457.arnd@arndb.de>
	<1207858131.26428.4.camel@thinkpadL>
	<200804110218.23912.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200804110218.23912.arnd@arndb.de>
Cc: kvm-ppc-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 11, 2008 at 02:18:22AM +0200, Arnd Bergmann wrote:
> On Thursday 10 April 2008, Jerone Young wrote:
> > Well it could be this simple. But the current code leaves a lot more
> > room to add different type waits or spins if need be (if they are ever
> > needed ... though none off the top of my head at the moment)...but it
> > does allow you to create another wait state for whatever reason a lot
> > easier.
> > 
> > So I really don't think this needs to change. Unless everyone really
> > feels that it just has to be.
> 
> No, it doesn't need to change, the current patch is entirely correct,
> just a little bit more complicated than it needs to be, and I try
> not to have code in anticipation of something getting more complicated
> in the future, you can always add the complexity at the point where you
> need it.

That piece of code came across from the platforms/pasemi version,
where we for a while had more than two kinds of idle loops
(doze/nap/sleep/rvwinkle). Turns out doze does well enough that the
others weren't really needed so I never submitted support for the deeper
sleep modes.


-Olof
