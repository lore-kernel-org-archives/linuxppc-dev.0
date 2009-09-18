Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 8CCF4B7B73
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Sep 2009 11:50:28 +1000 (EST)
Date: Fri, 18 Sep 2009 05:22:13 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: drivers/mfd/ab3100-core.c
Message-ID: <20090918012213.GA31463@oksana.dev.rtsoft.ru>
References: <20090917172058.902474da.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20090917172058.902474da.akpm@linux-foundation.org>
Cc: Samuel Ortiz <sameo@linux.intel.com>, linuxppc-dev@ozlabs.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 17, 2009 at 05:20:58PM -0700, Andrew Morton wrote:
> This:
> 
> static const struct ab3100_init_setting __initdata
> ab3100_init_settings[] = {

Looks like it should be __initconst, otherwise it's ambiguous.

> causes this:
> 
> drivers/mfd/ab3100-core.c:651: error: ab3100_init_settings causes a section type conflict
> 
> on ppc64.
> 
> I keep forgetting why.  Did MFD do something wrong or is powerpc borked
> or did my compiler version expire?

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
