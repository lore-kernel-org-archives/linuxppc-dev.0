Return-Path: <bcook@bpointsys.com>
Received: from bpointsys.com (70-253-197-251.ded.swbell.net [70.253.197.251])
	by ozlabs.org (Postfix) with ESMTP id D76E367CC8
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 03:59:58 +1100 (EST)
From: Brent Cook <bcook@bpointsys.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: Perl
Date: Tue, 14 Nov 2006 10:48:12 -0600
References: <1163458589.5313.71.camel@mindpipe>
	<20061114102843.4c81b599.kim.phillips@freescale.com>
	<1163522395.14674.6.camel@mindpipe>
In-Reply-To: <1163522395.14674.6.camel@mindpipe>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200611141048.12363.bcook@bpointsys.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 14 November 2006 10:39, Lee Revell wrote:
> On Tue, 2006-11-14 at 10:28 -0600, Kim Phillips wrote:
> > On Mon, 13 Nov 2006 17:56:28 -0500
> >
> > Lee Revell <rlrevell@joe-job.com> wrote:
> > > I've been trying to cross compile Perl for a PPC440 board and it just
> >
> > <snip>
> >
> > > Is there any easy solution?  Can someone send me a binary?
> >
> > ltib works for me:
> >
> > http://savannah.nongnu.org/projects/ltib/
>
> How do I build a perl binary with it?  I'm not looking to replace my
> toolchain or create a full BSP or anything.  I just need a /usr/bin/perl
> that will run on PPC440.
>
> Lee

buildroot, another rootfs framework, doesn't even try to cross-compile all of 
perl. It does build something called 'miniperl', which is just the perl 
binary without all of the supporting libraries and features. It may be enough 
for you. You can look at the makefile here:

http://buildroot.uclibc.org/cgi-bin/viewcvs.cgi/trunk/buildroot/package/microperl/microperl.mk?rev=11418&view=markup
