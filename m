Return-Path: <slightlyunconventional@gmail.com>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.191])
	by ozlabs.org (Postfix) with ESMTP id 56569DDE06
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Oct 2008 02:21:12 +1100 (EST)
Received: by rn-out-0910.google.com with SMTP id j40so1197244rnf.16
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Oct 2008 08:21:10 -0700 (PDT)
Message-ID: <fb412d760810220821m3b27dfeas83fd732406747568@mail.gmail.com>
Date: Wed, 22 Oct 2008 10:21:09 -0500
From: "Hollis Blanchard" <hollis@alumni.cmu.edu>
Sender: slightlyunconventional@gmail.com
To: "Paul Mackerras" <paulus@samba.org>
Subject: Re: build failure on powerpc with current -git
In-Reply-To: <18686.42209.47915.184451@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <48F8E86B.702@nortel.com>
	<18685.27030.529655.761257@cargo.ozlabs.ibm.com>
	<20081021191324.d4810d40.sfr@canb.auug.org.au>
	<18686.42209.47915.184451@cargo.ozlabs.ibm.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Linux kernel <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org
Reply-To: hollis@alumni.cmu.edu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(Oops, resending in plain text...)

On Tue, Oct 21, 2008 at 10:58 PM, Paul Mackerras <paulus@samba.org> wrote:
>
> Stephen Rothwell writes:
>
> > On Tue, 21 Oct 2008 16:33:10 +1100 Paul Mackerras <paulus@samba.org> wrote:
> > >
> > > It's a bug in older versions of ld (including 2.16.1) that's fixed in
> > > the current version (2.18).  However, this patch appears to work
> > > around the problem - at least, it let me build a 32-bit kernel with a
> > > cross-toolchain including a 2.16.1 ld.  Let me know if this gets it
> > > working for you.
> >
> > With that patch applied I got these errors for a powerpc ppc64_defconfig
> > build (linux-next).
> >
> > /usr/bin/objcopy: Warning: '/dev/null' is not an ordinary file
>
> Hmmm, so do I, and in fact the arch/powerpc/boot/wrapper change now
> seems to be unnecessary with my cross-compile setup (which has ld
> 2.16.1), whereas yesterday I'm sure it got errors.  Weird.
>
> Chris, could you try just the following change (my previous patch
> without the arch/powerpc/boot/wrapper change) and let me know if it
> fixes things with the ld you use?

Works for me.

binutils 2.16.1 is the most recent binutils that will build with
crosstool, so IMHO it's worth supporting. :)

-Hollis
