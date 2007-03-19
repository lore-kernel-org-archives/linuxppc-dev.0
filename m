Return-Path: <b07421@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id A920DDDEF2
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 02:06:26 +1100 (EST)
Date: Mon, 19 Mar 2007 10:06:01 -0500
From: Scott Wood <scottwood@freescale.com>
To: "Mark A. Greer" <mgreer@mvista.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 8/15] zImage: Cleanup and improve zImage entry point
Message-ID: <20070319150601.GA20513@ld0162-tx32.am.freescale.net>
References: <20070305032307.GB31417@localhost.localdomain>
	<20070305032452.810C1DDF1B@ozlabs.org>
	<20070315230230.GB3342@mag.az.mvista.com>
	<20070316001819.GE6784@localhost.localdomain>
	<20070316004717.GB10786@mag.az.mvista.com>
	<20070316005016.GI6784@localhost.localdomain>
	<20070316162135.GA29231@ld0162-tx32.am.freescale.net>
	<20070317013859.GJ3969@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070317013859.GJ3969@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Mar 17, 2007 at 12:38:59PM +1100, David Gibson wrote:
> On Fri, Mar 16, 2007 at 11:21:35AM -0500, Scott Wood wrote:
> > One problem with that is that the wrapper currently only accepts one
> > platform .o file -- and presumably one isn't going to want to do all of
> > the platform code in assembly.
> 
> Um.. nobody does it yet, but I don't think there's actually any reason
> that $platformo can't be set to a list of multiple .o files.

Sorry, I was thinking about the default generation of a .o file from the
platform name.  Obviously, the wrapper script can add to platformo.

Still, I think it'd be better to only stick something other than crt0 at
the beginning if the platform explicitly asks for it.

-Scott
