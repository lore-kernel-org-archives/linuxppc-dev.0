Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 27F02DDE46
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jul 2007 09:20:45 +1000 (EST)
Date: Tue, 3 Jul 2007 09:20:44 +1000
To: Will Schmidt <will_schmidt@vnet.ibm.com>
Subject: Re: [PATCH v2.1 ] Fix VDSO gettimeofday() when called with NULL
	struct timeval.
Message-ID: <20070702232044.GT9768@bakeyournoodle.com>
References: <20070625105836.GE9768@bakeyournoodle.com>
	<20070625235032.GH9768@bakeyournoodle.com>
	<1183149584.22547.51.camel@farscape.rchland.ibm.com>
	<1183150190.22547.62.camel@farscape.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1183150190.22547.62.camel@farscape.rchland.ibm.com>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Jun 29, 2007 at 03:49:50PM -0500, Will Schmidt wrote:
> 
> The vdso64 portion of patch 74609f4536f2b8fd6a48381bbbe3cd37da20a527 for
> fixing problems with NULL gettimeofday input mistakenly checks for a
> null tz field twice, when it should be checking for null tz once, and
> null tv once; by way of a r10/r11 typo. 
> 
> Any application calling gettimeofday(&tv,NULL) will "fail".
> 
> This corrects that typo, and makes my G5 happy.

Ooops thanks Will!

The /really/ sad thing is I got it right in the first version of the
patch :(

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
