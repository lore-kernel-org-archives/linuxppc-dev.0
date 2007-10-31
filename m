Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail7.fujitsu.co.jp (fgwmail7.fujitsu.co.jp [192.51.44.37])
	by ozlabs.org (Postfix) with ESMTP id 180BCDDE00
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Nov 2007 02:46:35 +1100 (EST)
Date: Thu, 1 Nov 2007 00:46:13 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [RFC] hotplug memory remove - walk_memory_resource for ppc64
Message-Id: <20071101004613.37fee22f.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <1193846560.17412.3.camel@dyn9047017100.beaverton.ibm.com>
References: <1191346196.6106.20.camel@dyn9047017100.beaverton.ibm.com>
	<18178.52359.953289.638736@cargo.ozlabs.ibm.com>
	<1193771951.8904.22.camel@dyn9047017100.beaverton.ibm.com>
	<20071031142846.aef9c545.kamezawa.hiroyu@jp.fujitsu.com>
	<20071031143423.586498c3.kamezawa.hiroyu@jp.fujitsu.com>
	<1193846560.17412.3.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, anton@au1.ibm.com, paulus@samba.org,
	linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 31 Oct 2007 08:02:40 -0800
Badari Pulavarty <pbadari@us.ibm.com> wrote:
> Paul's concern is, since we didn't need it so far - why we need this
> for hotplug memory remove to work ? It might break API for *unknown*
> applications. Its unfortunate that, hotplug memory add updates 
> /proc/iomem. We can deal with it later, as a separate patch.
> 
I have no objection to skip /proc/iomem related routine when arch
doesn't need it. 

My advice is just "please take care both of hot-add and hot-remove".

If ppc64 people agreed to use arch-specific routine for detect
conventional memory, there is no problem, I think.

Thanks,
-Kame
