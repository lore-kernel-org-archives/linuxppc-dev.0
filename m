Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 152ABDDDCA
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 16:00:31 +1100 (EST)
Date: Tue, 27 Nov 2007 16:00:31 +1100
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: time accounting problem (powerpc only?)
Message-ID: <20071127050031.GC24243@bakeyournoodle.com>
References: <1195814816.4149.94.camel@johannes.berg>
	<1196094193.4149.287.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <1196094193.4149.287.camel@johannes.berg>
From: tony@bakeyournoodle.com (Tony Breeds)
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Nov 26, 2007 at 05:23:13PM +0100, Johannes Berg wrote:
> Contrary to what I claimed later in the thread, my 64-bit powerpc box
> (quad-core G5) doesn't suffer from this problem.
> 
> Does anybody have any idea? I don't even know how to debug it further.

I'll see if I can grab an appropriate machine tomorrow and have a look at
it.  I think it's just an accounting bug, which is probably my fault :)

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
