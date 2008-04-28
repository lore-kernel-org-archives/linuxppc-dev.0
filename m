Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 59B51DDF17
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 09:06:34 +1000 (EST)
Date: Tue, 29 Apr 2008 09:06:33 +1000
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Change the default link address for pSeries zImage
	kernels.
Message-ID: <20080428230633.GA20457@bakeyournoodle.com>
References: <20080425053941.GT20457@bakeyournoodle.com>
	<1209103970.9060.226.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1209103970.9060.226.camel@pasglop>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 25, 2008 at 04:12:50PM +1000, Benjamin Herrenschmidt wrote:

> Considering how bad OF can be on some machines, I'd like this to be
> boot-tested on a wider range of machines. Also, it might depend on the
> OF real-base setting as well...
> 
> At least, we should be able to test at ozlabs on cell blades, POWER4
> bare metal (ie "SMP mode"), POWER5 and POWER5+.

Hmm okay it fails on POWER4, I'll see what can be done there.

Yours Tony

  linux.conf.au    http://www.marchsouth.org/
  Jan 19 - 24 2009 The Australian Linux Technical Conference!
