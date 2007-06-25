Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 3CB0FDDE09
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jun 2007 09:37:46 +1000 (EST)
Date: Tue, 26 Jun 2007 09:37:45 +1000
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Fix VDSO gettimeofday() when called with NULL struct
	timeval.
Message-ID: <20070625233745.GF9768@bakeyournoodle.com>
References: <20070625105836.GE9768@bakeyournoodle.com>
	<1182775182.5521.62.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1182775182.5521.62.camel@localhost.localdomain>
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

On Mon, Jun 25, 2007 at 10:39:42PM +1000, Benjamin Herrenschmidt wrote:
 
> Please use cmplwi here.

Will do.
 
> And fix that one while at it :-) It's the same thing, but at least one
> is explicit on the size of the comparison. Also, I don't think you need
> to renumber the labels, or did I miss something ?

No I did.

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
