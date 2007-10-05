Return-Path: <tony@bakeyournoodle.com>
Received: from pythia.bakeyournoodle.com (pythia.bakeyournoodle.com
	[203.82.209.197]) by ozlabs.org (Postfix) with ESMTP id 935ACDDE23
	for <linuxppc-dev@ozlabs.org>; Fri,  5 Oct 2007 17:05:21 +1000 (EST)
Date: Fri, 5 Oct 2007 17:05:21 +1000
To: Paul Mackerras <paulus@samba.org>, LinuxPPC-dev <linuxppc-dev@ozlabs.org>
Subject: Re: Fix regression.  Make hot unlplug of CPU0 work again.
Message-ID: <20071005070519.GQ9814@bakeyournoodle.com>
References: <20071005035241.GO9814@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20071005035241.GO9814@bakeyournoodle.com>
From: tony@bakeyournoodle.com (Tony Breeds)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Oct 05, 2007 at 01:52:41PM +1000, Tony Breeds wrote:
> Early in the 2.6.23 cycle we broke the ability to offline cpu0
> (7ccb4a662462616f6be5053e26b79580e02f1529).  This patch fixes that by
> ensuring that the (xics)  default irq server, will not be 0 when taking
> cpu0 offline.
> 
> Also catches a use of irq, when virq should be used (I think that the
> last one).

Hmm testing, this on a JS21 shows that it doesn't work.  I guess I'll go
back to the drawing board.

Yours Tony

  linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
  Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
