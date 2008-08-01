Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 5D53CDDFC3
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Aug 2008 15:29:36 +1000 (EST)
Date: Fri, 1 Aug 2008 15:29:36 +1000
From: Tony Breeds <tony@bakeyournoodle.com>
To: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Subject: Re: [BUILD-FAILURE] 2.6.27-rc1-mm1 - allyesconfig build fails on
	powerpc
Message-ID: <20080801052936.GZ20457@bakeyournoodle.com>
References: <20080731000354.24b55d5b.akpm@linux-foundation.org>
	<4891B370.5040208@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <4891B370.5040208@linux.vnet.ibm.com>
Cc: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Kernel Testers List <kernel-testers@vger.kernel.org>,
	Sam Ravnborg <sam@ravnborg.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 31, 2008 at 06:13:28PM +0530, Kamalesh Babulal wrote:
> Hi Andrew,
> 
> make allyesconfig with 2.6.27-rc1-mm1 kernel on powerpc fails with build error

<snip>

Turning off GCOV "fixes" this.  Not really the best solution but at
least it narrows doen the search effort.

Peter,
	Can you have a look at how this can be fixed, if at all?

Yours Tony

  linux.conf.au    http://www.marchsouth.org/
  Jan 19 - 24 2009 The Australian Linux Technical Conference!
