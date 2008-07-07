Return-Path: <ntl@pobox.com>
Received: from sasl.smtp.pobox.com (a-sasl-fastnet.sasl.smtp.pobox.com
	[207.106.133.19]) by ozlabs.org (Postfix) with ESMTP id 5AB23DE7AF
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 02:16:45 +1000 (EST)
Date: Mon, 7 Jul 2008 11:16:13 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Roland McGrath <roland@redhat.com>
Subject: Re: [PATCH 1/2] elf loader support for auxvec base platform string
Message-ID: <20080707161613.GF9594@localdomain>
References: <20080703234140.GC9594@localdomain>
	<20080704021929.5E9EF1541F5@magilla.localdomain>
	<1215409693.8970.79.camel@pasglop>
	<20080707061811.19989154246@magilla.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080707061811.19989154246@magilla.localdomain>
Cc: Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Roland McGrath wrote:
> > Well, we use strings to represent the platforms already (ie, the actual
> > CPU microarchitecture). Fitting those into bits would be annoying, it
> 
> Then use dsocaps.
> 
> > makes sense to have AT_BASE_PLATFORM to be the "base" variant of
> > AT_PLATFORM.
> 
> I understand why you think so.  But let's not be too abstract.  The
> purpose of the addition is to drive ld.so's selection of libraries, yes?

That is one purpose.  But there are others (JVMs, performance tools).
dsocaps seems to be an ld.so-specific thing... or am I missing how a
"third-party" program would use it?
