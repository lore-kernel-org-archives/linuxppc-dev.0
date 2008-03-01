Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 1F558DDEFE
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  2 Mar 2008 02:53:08 +1100 (EST)
Date: Sat, 1 Mar 2008 09:57:54 -0600
From: Olof Johansson <olof@lixom.net>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: Sequoia build with KDBG
Message-ID: <20080301155754.GA5303@lixom.net>
References: <20080222164210.48628DE0A9@ozlabs.org>
	<20080222145224.7349cf36@weaponx>
	<200802292133.m1TLXqv3012273@e36.co.us.ibm.com>
	<20080229153534.684aebf9@zod.rchland.ibm.com>
	<200802292230.m1TMUk4I005462@e31.co.us.ibm.com>
	<20080229165137.64acbebf@zod.rchland.ibm.com>
	<200803010023.m210NHwr011345@e2.ny.us.ibm.com>
	<20080229203015.0ada459e@zod.rchland.ibm.com>
	<20080301050249.GA23099@lixom.net>
	<20080301071315.3c7c05dc@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080301071315.3c7c05dc@zod.rchland.ibm.com>
Cc: Steve Heflin <sheflin@newagemicro.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Sat, Mar 01, 2008 at 07:13:15AM -0600, Josh Boyer wrote:
> On Fri, 29 Feb 2008 23:02:50 -0600
> Olof Johansson <olof@lixom.net> wrote:
> 
> > On Fri, Feb 29, 2008 at 08:30:15PM -0600, Josh Boyer wrote:
> > 
> > > > poor man's debugging works fine if a serial port is available, but my 
> > > > Sequoia platform doesn't get that far!  I use u-boot to download and 
> > > > boot my image, and I don't get any serial output after the boot completes:
> > > 
> > > By "poking characters out the serial port" I meant I literally coded up
> > > assembly functions to setup MMU translations and poke hex values at hard
> > > coded addresses.  That's why it's "poor man's".  If you had a working
> > > serial port out of the box, that would be a luxury ;).
> > 
> > Does 4xx have support for udbg and xmon? That would be a good first step
> > in getting an in-kernel debugger facility going.
> 
> Yes.  Or at least it did as of a few kernel releases ago when I last
> tested it.  It's helpful for a number of thing, but debugging extremely
> early stuff isn't possible with it.

Right, most in-kernel debuggers will be useless for that, so I doubt kgdb will
help in those cases either.


-Olof
