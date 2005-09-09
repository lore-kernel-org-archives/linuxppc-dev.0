Return-Path: <dgibson@ozlabs.org>
Date: Fri, 9 Sep 2005 10:08:57 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Arnd Bergmann <arnd@arndb.de>
Message-ID: <20050909000857.GC31045@localhost.localdomain>
References: <f2ea45e1b2a9689c450811a61ed46183@embeddededge.com>
	<39A39EEE-E3B1-4D34-BC6E-854C3EF56C7D@freescale.com>
	<200509090036.39992.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200509090036.39992.arnd@arndb.de>
Cc: linuxppc64-dev@ozlabs.org, pantelis.antoniou@gmail.com,
	linuxppc-embedded@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: Re: cpu features testing 32 vs 64 bit
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 09, 2005 at 12:36:39AM +0200, Arnd Bergmann wrote:
> On Freedag 09 September 2005 00:02, Kumar Gala wrote:
> > 
> > On Sep 8, 2005, at 4:48 PM, Dan Malek wrote:
> > >
> > > If we #define CPU_FTR_xxx as a 0 or all 1's for processors that have
> > > or don't have these features, will the compiler be smart enough to
> > > recognize an always true or false condition and remove the
> > > test (or code as appropriate)?
> > 
> > The compiler is smart enough in this case since cpu_has_feature() is  
> > an inline function.
> 
> I actually wrote a patch that solves the problem in a very generic way,
> see http://patchwork.ozlabs.org/linuxppc/patch?id=1048 .
> I don't remember exactly if there were serious objections against
> the patch at that time, but it looks like a much cleaner solution to me
> than defining CPU_FTR_xxx to different values depending on the
> configuration.

And we already use a mechanism essentially identical to Arnd's for
fw_has_feature().

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/people/dgibson
