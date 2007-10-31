Return-Path: <dale@farnsworth.org>
Received: from farnsworth.org (xyzzy.farnsworth.org [65.39.95.219])
	by ozlabs.org (Postfix) with SMTP id E690CDDDF2
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Nov 2007 08:48:04 +1100 (EST)
Date: 31 Oct 2007 14:47:54 -0700
Message-ID: <20071031214754.32735.qmail@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
To: pbadari@us.ibm.com
Subject: Re: [PATCH 1/3] Add remove_memory() for ppc64
In-Reply-To: <1193867133.17412.49.camel@dyn9047017100.beaverton.ibm.com>
References: <1193849375.17412.34.camel@dyn9047017100.beaverton.ibm.com>
	<46434BBD-7656-41B1-BED0-3A3E212032B5@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Badari Pulavarty wrote:
> On Thu, 2007-11-01 at 01:26 -0500, Kumar Gala wrote:
> > On Oct 31, 2007, at 11:49 AM, Badari Pulavarty wrote:
> > 
> > > Supply arch specific remove_memory() for PPC64. There is nothing
> > > ppc specific code here and its exactly same as ia64 version.
> > > For now, lets keep it arch specific - so each arch can add
> > > its own special things if needed.
> > >
> > > Signed-off-by: Badari Pulavarty <pbadari@us.ibm.com>
> > > ---
> > 
> > What's ppc64 specific about these patches?
> 
> Like I mentioned, nothing. When KAME did the hotplug memory
> remove, he kept this remove_memory() arch-specific - so
> each arch can provide its own, if it needs to something
> special. So far, there is no need for arch-specific 
> remove_memory(). If other archs (x86-64 and others)
> agree we can merge this into arch neutral code.
> 
> I have to provide this for ppc64 to plug into general
> frame work.

You've added it to arch/powerpc for both PPC32 and PPC64, so your
commit description is misleading.

-Dale
