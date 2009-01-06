Return-Path: <sam@ravnborg.org>
Received: from pfepa.post.tele.dk (pfepa.post.tele.dk [195.41.46.235])
	by ozlabs.org (Postfix) with ESMTP id CAA57DE618
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Jan 2009 03:38:28 +1100 (EST)
Date: Tue, 6 Jan 2009 17:40:06 +0100
From: Sam Ravnborg <sam@ravnborg.org>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [PATCH] 2.6.28-git4 - powerpc - drivers build fails with
	!CONFIG_VIOPATH
Message-ID: <20090106164006.GA15934@uranus.ravnborg.org>
References: <5414eaef99b7392a95f6e3488b81dbf7@bga.com>
	<20090104182441.GA5086@linux.vnet.ibm.com>
	<98d6aef17cba9d835d7866745f811dc7@bga.com>
	<20090106072549.GA5066@linux.vnet.ibm.com>
	<20090106073149.GA12371@uranus.ravnborg.org>
	<20090106093847.GB5066@linux.vnet.ibm.com>
	<20090106104619.GA13789@uranus.ravnborg.org>
	<20090106155724.GA6747@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090106155724.GA6747@linux.vnet.ibm.com>
Cc: linux-ppc <linuxppc-dev@ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Milton Miller <miltonm@bga.com>, Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jan 06, 2009 at 09:27:24PM +0530, Kamalesh Babulal wrote:
> * Sam Ravnborg <sam@ravnborg.org> [2009-01-06 11:46:19]:
> 
> > Hi Kamalesh
> > 
> > Looks good, small nit below.
> > 
> > >  config VIOPATH
> > >  	bool
> > > -	depends on VIODASD || VIOCD || VIOTAPE || ISERIES_VETH
> > > -	default y
> > > +	default n
> > 
> > As 'n' is default anyway this line is not needed and I suggest you
> > spin a final version of the patch with this removed.
> > 
> > 	Sam
> 
> Hi Sam,
> 
> 	Thanks for the review comments. I am resending the patch with the changes
> you have recommended.
> 
> Impact: Fix the VIOPATH dependency in the iSeries dependent drivers.
> 
> iSeries depend drivers build fails, when CONFIG_VIOPATH is disabled.
> Removing the dependency of VIOPATH by selecting it, when the drivers
> dependent on iSeries code.
> 
> Signed-off-by: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
