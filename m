Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CDE091A1D64
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2015 03:21:12 +1000 (AEST)
Date: Wed, 5 Aug 2015 12:20:40 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/5] powerpc/pseries: extract of_helpers module
Message-ID: <20150805172040.GA18479@gate.crashing.org>
References: <1438699009-112794-1-git-send-email-andriy.shevchenko@linux.intel.com>
 <20150805052057.GB32178@gate.crashing.org>
 <1438767175.29746.161.camel@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1438767175.29746.161.camel@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 05, 2015 at 12:32:55PM +0300, Andy Shevchenko wrote:
> > If path doesn't contain any slash this will do interesting things;
> > you might want to fix that too while you're at it :-)
> 
> No problem, though it is in the original code. I would do as a separate
> patch on top of the series. Will be okay for you?

Of course -- you're fixing other problems here as well (memory leak
or what was it), that's why I asked.


Segher
