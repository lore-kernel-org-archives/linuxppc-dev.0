Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id F22F5DDFD2
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Apr 2008 16:08:38 +1000 (EST)
Date: Wed, 23 Apr 2008 16:08:36 +1000
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 1/3 v3] Raise the upper limit of NR_CPUS.
Message-ID: <20080423060836.GM20457@bakeyournoodle.com>
References: <d54206d25b690c9160401f65a583f586004dcd5d.1208923391.git.tony@bakeyournoodle.com>
	<1208929299.9212.4.camel@concordia.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1208929299.9212.4.camel@concordia.ozlabs.ibm.com>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 23, 2008 at 03:41:39PM +1000, Michael Ellerman wrote:
 
> You add about 30 lines of code in this patch, which you remove in patch
> 3, is there a better way to do it?
> 
> Is there any harm dynamically initialising the statically initialised
> pacas, I think that would allow you to basically skip the
> NR_STATIC_PACAS business.

Yes, I could make patch 2 the first in the series, and then roll batches
1 and 3 together.  As iSeries will barf I do all the PACAs dynamically
without that extra wait.

/me is too linear.

new version comming.

Yours Tony

  linux.conf.au    http://www.marchsouth.org/
  Jan 19 - 24 2009 The Australian Linux Technical Conference!
