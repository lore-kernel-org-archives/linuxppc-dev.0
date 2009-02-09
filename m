Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id ACBC0474C1
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Feb 2009 08:12:15 +1100 (EST)
Date: Mon, 9 Feb 2009 13:12:00 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/1] edac: new ppc4xx driver module
Message-Id: <20090209131200.f2e5fb6f.akpm@linux-foundation.org>
In-Reply-To: <20090209210119.GF2297@yoda.jdub.homelinux.org>
References: <20090130140520.ca1b2b8e.akpm@linux-foundation.org>
	<C5B1D239.14743%gerickson@nuovations.com>
	<20090206114947.ea86ee58.akpm@linux-foundation.org>
	<20090209210119.GF2297@yoda.jdub.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, gerickson@nuovations.com,
	dougthompson@xmission.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 9 Feb 2009 16:01:19 -0500
Josh Boyer <jwboyer@linux.vnet.ibm.com> wrote:

> On Fri, Feb 06, 2009 at 11:49:47AM -0800, Andrew Morton wrote:
> >On Fri, 06 Feb 2009 11:40:41 -0800
> >Grant Erickson <gerickson@nuovations.com> wrote:
> >
> >> On 1/30/09 2:05 PM, Andrew Morton wrote:
> >> > On Fri, 30 Jan 2009 09:54:42 -0700 dougthompson@xmission.com wrote:
> >> >> From: Grant Erickson <gerickson@nuovations.com>
> >> > 
> >> > Perhaps a powerpc mailing list should have been cc'ed?
> >> 
> >> The first round patch went to Doug, the BlueSmoke (EDAC) mailing list and
> >> the Linux/PowerPC mailing list. However, because the original patch was
> >> split in two, subsequent revisions of just the EDAC piece went to Doug and
> >> BlueSmoke. Doug then forwarded it to linux-kernel.
> >> 
> >> What's the preferred sign-off, ACK chain for this subsystem? Through
> >> PowerPC/4xx or PowerPC GIT upstream or through you and -mm upstream?
> >
> >I don't trust those guys ;)
> 
> I might take offense to that, but it seems that there aren't too many people
> in general that you trust, so I guess that's fine. ;)
> 
> (And while you may or may not be joking, if there's something that I've done
> to be considered not trustworthy then please let me know.)

Every kernel cycle there are literally hundreds of patches which slip
through subsystem tree maintainers' fingers.  Patches which I unlose
for them.  Heaven knows how many patches get lost on mailing lists
which I don't read.

My mistrust is widespread and well-placed ;)

> >I'd merge it via -mm, while cc'ing various random powerpc personalities.
> 
> Erm, ok.  Since there doesn't appear to be an EDAC git tree for -next I
> guess that makes sense.  I'll try to review the most recent version in the
> next few days.

Thanks.
