Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 58B9FDDE2D
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2007 09:39:46 +1000 (EST)
Date: Tue, 26 Jun 2007 09:39:46 +1000
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Fix VDSO gettimeofday() when called with NULL struct
	timeval.
Message-ID: <20070625233945.GG9768@bakeyournoodle.com>
References: <20070625105836.GE9768@bakeyournoodle.com>
	<757f020b834543583be36b73b932da3e@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <757f020b834543583be36b73b932da3e@kernel.crashing.org>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 25, 2007 at 03:35:51PM +0200, Segher Boessenkool wrote:

> Yeah.  Not really vital though, no sane program would call
> gettimeofday() with a NULL timeval (since that doesn't do
> anything).  Or did you find such a program (other than a
> testsuite)?

No real program just me testing things.  I wanted to see what the
kernel had in sys_tz ;P
 
> cmplwi r10,0

Will do.  BenH also suggested this change.
 
> No need to renumber the labels.  Either pick a higher
> number for your new label (nothing says they need to be
> in order); or reuse some other number (both your new and
> the original 1: can be 1: without any problem, these are
> local labels after all); or you can use 0: since that's
> a valid local label as well.

Thanks.

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
