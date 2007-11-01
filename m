Return-Path: <kamezawa.hiroyu@jp.fujitsu.com>
Received: from fgwmail5.fujitsu.co.jp (fgwmail5.fujitsu.co.jp [192.51.44.35])
	by ozlabs.org (Postfix) with ESMTP id 0E7A6DDE22
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Nov 2007 11:44:32 +1100 (EST)
Date: Thu, 1 Nov 2007 09:46:29 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Dave Hansen <haveblue@us.ibm.com>
Subject: Re: [PATCH 1/3] Add remove_memory() for ppc64
Message-Id: <20071101094629.fac6077c.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <1193867703.6271.42.camel@localhost>
References: <1193849375.17412.34.camel@dyn9047017100.beaverton.ibm.com>
	<1193863502.6271.38.camel@localhost>
	<1193868715.17412.55.camel@dyn9047017100.beaverton.ibm.com>
	<1193867703.6271.42.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, anton@au1.ibm.com, linux-mm <linux-mm@kvack.org>,
	Paul Mackerras <paulus@samba.org>, GOTO <y-goto@jp.fujitsu.com>,
	Badari Pulavarty <pbadari@us.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 31 Oct 2007 14:55:03 -0700
Dave Hansen <haveblue@us.ibm.com> wrote:

> On Wed, 2007-10-31 at 14:11 -0800, Badari Pulavarty wrote:
> > 
> > Well, We don't need arch-specific remove_memory() for ia64 and ppc64.
> > x86_64, I don't know. We will know, only when some one does the
> > verification. I don't need arch_remove_memory() hook also at this
> > time.
> 
> I wasn't being very clear.  I say, add the arch hook only if you need
> it.  But, for now, just take the ia64 code and make it generic.  
> 

remove_memory() has been arch-specific since there was no piece of unplug
code. And I didn't merge it to be generic when I implemented ia64 ver.

Hmm...I have no objection to merge them. But let's see how memory hotremove
for ppc64 works for a while. We can merge them later.

I'm glad to have new testers :)

Thanks,
-Kame
