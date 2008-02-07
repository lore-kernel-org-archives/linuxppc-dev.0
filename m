Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 39BD3DDD04
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Feb 2008 16:29:03 +1100 (EST)
Date: Thu, 7 Feb 2008 16:27:03 +1100
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Please pull powerpc.git for-2.6.25 branch
Message-ID: <20080207052703.GF6887@bakeyournoodle.com>
References: <18346.31072.982702.10064@cargo.ozlabs.ibm.com>
	<fa686aa40802062126w122ed215y5d7bb86b6b1927a2@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <fa686aa40802062126w122ed215y5d7bb86b6b1927a2@mail.gmail.com>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 06, 2008 at 10:26:06PM -0700, Grant Likely wrote:
> On 2/6/08, Paul Mackerras <paulus@samba.org> wrote:
> > Tony Breeds (1):
> >       [POWERPC] Use a sensible default for clock_getres() in the VDSO
> 
> Hmm, this commit breaks ppc32 (mpc5200) build with my cross compiler
> (ELDK 4.1; gcc 4.0; binutils 2.16.1).  Is this a bug in the code or
> the compiler?

both?

Newer compilers (gcc-4.1 and on) cope happily.  I'm working on a fix to
the fix ;P

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
