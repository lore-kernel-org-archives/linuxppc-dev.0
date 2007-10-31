Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
	by ozlabs.org (Postfix) with ESMTP id 92C59DE239
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Oct 2007 16:32:19 +1100 (EST)
Date: Wed, 31 Oct 2007 14:34:23 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Subject: Re: [RFC] hotplug memory remove - walk_memory_resource for ppc64
Message-Id: <20071031143423.586498c3.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20071031142846.aef9c545.kamezawa.hiroyu@jp.fujitsu.com>
References: <1191346196.6106.20.camel@dyn9047017100.beaverton.ibm.com>
	<18178.52359.953289.638736@cargo.ozlabs.ibm.com>
	<1193771951.8904.22.camel@dyn9047017100.beaverton.ibm.com>
	<20071031142846.aef9c545.kamezawa.hiroyu@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>,
	anton@au1.ibm.com, Badari Pulavarty <pbadari@us.ibm.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 31 Oct 2007 14:28:46 +0900
KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:

> ioresource was good structure for remembering "which memory is conventional
> memory" and i386/x86_64/ia64 registered conventional memory as "System RAM",
> when I posted patch. (just say "System Ram" is not for memory hotplug.)
> 
If I remember correctly, System RAM is for kdump (to know which memory should
be dumped.) Then, memory-hotadd/remove has to modify it anyway.

Thanks,
-Kame
