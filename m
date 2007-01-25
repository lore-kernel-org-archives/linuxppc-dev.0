Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id 6DDF3DE1C8
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Jan 2007 12:00:18 +1100 (EST)
Date: Wed, 24 Jan 2007 19:00:11 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/2] rename pSeries nvram functions
Message-ID: <20070125010010.GM16486@localdomain>
References: <20070125001628.GH16486@localdomain>
	<1169686011.24996.18.camel@localhost.localdomain>
	<1169686046.24996.20.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1169686046.24996.20.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Thu, 2007-01-25 at 11:46 +1100, Benjamin Herrenschmidt wrote:
> > On Wed, 2007-01-24 at 18:16 -0600, Nathan Lynch wrote:
> > > The nvram support in the pSeries platform code is not really tied to
> > > the pSeries platform.  This code is useful on other platforms that
> > > have the necessary firmware support.
> > > 
> > > Change the "pSeries" prefixes on the nvram function names to "rtas" in
> > > preparation for moving this code to a platform-neutral location.
> > > 
> > > Signed-off-by: Nathan Lynch <ntl@pobox.com>
> > 
> > Please, move them out of platform/pseries while at it, so you can also
> > merge with chrp nvram.c which is pretty much the same.
> 
> Oh, missed that second patch of yours... good :-) Now we should see if
> we can fixup chrp too..

I'll look into it, though I might be hard-pressed to find a chrp
machine with which to test.
