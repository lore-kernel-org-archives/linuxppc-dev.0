Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id B590867A62
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Mar 2006 05:58:57 +1100 (EST)
Date: Fri, 24 Mar 2006 12:58:12 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Kill machine numbers
Message-ID: <20060324185812.GE5538@pb15.lixom.net>
References: <1143178947.4257.78.camel@localhost.localdomain>
	<20060324062624.GA16815@pb15.lixom.net>
	<1143187298.3710.3.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1143187298.3710.3.camel@localhost.localdomain>
From: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Mar 24, 2006 at 07:01:38PM +1100, Benjamin Herrenschmidt wrote:
> 
> > It would be very useful to print the ppc_md.name of the found machine
> > here, even without debugging enabled.
> 
> Not sure ... without debugging enabled, it's likely that you won't see
> anything that early anyway :)

True, but it'd be in the dmesg, and get printed when the console comes up.

> > It's really weird that IBM chose to use "chrp" to describe a
> > PAPR-compliant platform. I guess it's for historical reasons, but it
> > sure isn't CHRP any more.
> 
> Yup, I'm trying to get that changed in the architecture but even if I'm
> successful, we'll have to deal with existing machines.

Right, it was mostly a side comment.

> > > +      is _not_ "chrp" as this will be matched by the kernel to be a
> > > +      CHRP machine on 32 bits kernel or a pSeries on 64 bits kernels
> > 
> > ...or a PAPR-compliant machine on 64-bit kernels.
> > 
> > (Also, "xx-bit kernels", not "xx bits kernels").
> 
> yeah yeah :) Thanks for the review anyway !

Hey, I couldn't find much technical issues, so I ended up reading your
comments and picking errors there instead. :-)


-Olof
