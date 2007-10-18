Return-Path: <sam@ravnborg.org>
Received: from pasmtpB.tele.dk (pasmtpb.tele.dk [80.160.77.98])
	by ozlabs.org (Postfix) with ESMTP id EBDFFDE036
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 05:58:31 +1000 (EST)
Date: Thu, 18 Oct 2007 21:59:26 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Milton Miller <miltonm@bga.com>, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Merge dtc
Message-ID: <20071018195926.GA22887@uranus.ravnborg.org>
References: <9a3f3582990ad94feb76770e82c50bdd@bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9a3f3582990ad94feb76770e82c50bdd@bga.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Oct 18, 2007 at 12:49:54PM -0500, Milton Miller wrote:
> On Tue Oct 16 15:02:17 EST 2007, David Gibson wrote:
> 
> >This very large patch incorporates a copy of dtc into the kernel
> >source, in arch/powerpc/boot/dtc-src.  This means that dtc is no
> >longer an external dependency to build kernels with configurations
> >which need a dtb file.
> >
> >Signed-off-by: David Gibson <david at gibson.dropbear.id.au>
> >
> >Too big for the list, full patch at
> >http://ozlabs.org/~dgibson/home/merge-dtc.patch+
> 
> So split it up.   The obvious one is "here is the unique content, then 
> copy these files from dtc git" would have been better.
One obvious split is a patch solely containing the _shipped files.
And next patch the rest.

As Milton already pointed out you should build dtc in the
dtc directory (why the -src prefix??).
And the dtc specific Makefile looks like something from
the late 80'. Please drop all these ALLUPPERCASE variables
and accept a little bit of redundancy.
Then mere humans may be able to read the Makefile.

When you have done the above I would be happy to review the
kbuild bits.

	Sam
