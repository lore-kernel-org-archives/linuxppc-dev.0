Return-Path: <dgibson@ozlabs.org>
Date: Fri, 19 Oct 2007 17:10:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Merge dtc
Message-ID: <20071019071033.GB27017@localhost.localdomain>
References: <9a3f3582990ad94feb76770e82c50bdd@bga.com>
	<20071018195926.GA22887@uranus.ravnborg.org>
	<20071019014510.GD30283@localhost.localdomain>
	<1b5c57d93e45d94d007b543ea5e2de02@bga.com>
	<20071019065530.GA27017@localhost.localdomain>
	<20071019070718.GA28099@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071019070718.GA28099@uranus.ravnborg.org>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 19, 2007 at 09:07:18AM +0200, Sam Ravnborg wrote:
> > Compared to the behemoth that is Kbuild...
> > 
> > I'm happy to improve the Makefile integration, but you seem to be
> > rather vague on how, and the Kbuild documentation makes my brain hurt.
> 
> I can make an ALL UPPERCASE VERSION if that makes it easier for you
> to read ;-)

Hardy har har.  Since this is supposed to build both within the kernel
and standalone there will necessarily be a few style conflicts at the
boundary.  Kbuild is not in the majority here; in fact it's close to
unique.

> Give me a day or two then I shall give it a try and see what I can
> do about it.  I will use the previsous posted URL as basis if you do
> not tell me otherwise.

Thank you.  The previous URL should be fine, I've made no changes
since then.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
