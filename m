Return-Path: <dgibson@ozlabs.org>
Date: Wed, 31 Oct 2007 13:45:08 +1100
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: Merge dtc
Message-ID: <20071031024508.GB7772@localhost.localdomain>
References: <9a3f3582990ad94feb76770e82c50bdd@bga.com>
	<20071018195926.GA22887@uranus.ravnborg.org>
	<20071019014510.GD30283@localhost.localdomain>
	<1b5c57d93e45d94d007b543ea5e2de02@bga.com>
	<20071019065530.GA27017@localhost.localdomain>
	<20071019070718.GA28099@uranus.ravnborg.org>
	<20071019071033.GB27017@localhost.localdomain>
	<20071019184249.GA32015@uranus.ravnborg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071019184249.GA32015@uranus.ravnborg.org>
From: dgibson@ozlabs.org (David Gibson)
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

On Fri, Oct 19, 2007 at 08:42:49PM +0200, Sam Ravnborg wrote:
> Hi David.
> 
> > > Give me a day or two then I shall give it a try and see what I can
> > > do about it.  I will use the previsous posted URL as basis if you do
> > > not tell me otherwise.
> > 
> > Thank you.  The previous URL should be fine, I've made no changes
> > since then.
> 
> I decided to go for a kbuild specific version integrated
> in boot/Makefile.
> This is much more readable because this syntax is explicit.
> We do not favour 3 levels of variabls to avoid rewriting the same
> filename two times.

Well, yes, on consideration the substitutions in Makefile.dtc are a
bit over-involved.  Although I still find describing its dozen or so
lines as unreadable when set next to the intricate wonders of Kbuild a
little...  bemusing.

> I have tested the change only with a O=.. crosscompile build.
> 
> I have tested the patch with and without DTC_GENPARSER=1.
> It does not rebuild if not needed and is OK with -j10 builds.
> 
> Please consider this version in favour of your old version.

Ok.  I'll use this version in my next spin; except for adding one
dependency you missed, and removing one which should never have been
there (unneccessary #include, which I've already fixed in dtc
upstream).

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
