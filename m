Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <1127006735.23095.4.camel@gaston>
References: <1127006735.23095.4.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <216D7B09-CC72-482D-9C06-3416D5E02DBE@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Sun, 18 Sep 2005 12:50:30 -0500
To: "Benjamin Herrenschmidt" <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: PATCH powerpc: 00/04 Remove __pmac, etc, sections,
	merge sections.h
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 17, 2005, at 8:25 PM, Benjamin Herrenschmidt wrote:

> On Sat, 2005-09-17 at 10:31 -0500, Jon Loeliger wrote:
>
>> Here is a new patch that removes all notion of the pmac, prep,
>> chrp and openfirmware initialization sections, and then unifies
>> the sections.h files without those __pmac, etc, sections identifiers
>> cluttering things up.
>>
>
> When did we decide to do that ? Some people are still using ppc  
> machines
> with rather small memory footprint (old ones), it's handy to get  
> rid of
> the code you don't need... It would make sense if we could compile
> CHRP/PMAC/PREP in/out (like we can do with platforms on ppc64) so that
> people who have tight memory requirements can build a PReP or CHRP
> kernel without all of the pmac code.

I think the discussion earlier in this week lead us to believe this  
was the way to go.  We can provide a simple patch to allow selecting  
CHRP/PMAC/PREP specifically in addition to MUTLIPLATFORM.

- kumar
