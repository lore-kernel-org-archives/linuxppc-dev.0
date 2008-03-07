Return-Path: <y-goto@jp.fujitsu.com>
Received: from fgwmail8.fujitsu.co.jp (fgwmail8.fujitsu.co.jp [192.51.44.38])
	by ozlabs.org (Postfix) with ESMTP id C28A9DDFA3
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Mar 2008 13:00:10 +1100 (EST)
Received: from fgwmail6.fujitsu.co.jp (fgwmail6.fujitsu.co.jp [192.51.44.36])
	by fgwmail8.fujitsu.co.jp (Fujitsu Gateway) with ESMTP id
	m271ZTr5028499
	for <linuxppc-dev@ozlabs.org> (envelope-from y-goto@jp.fujitsu.com);
	Fri, 7 Mar 2008 10:35:29 +0900
Date: Fri, 07 Mar 2008 10:35:09 +0900
From: Yasunori Goto <y-goto@jp.fujitsu.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
Subject: Re: [PATCH 1/5] generic __remove_pages() support
In-Reply-To: <1204839763.6272.8.camel@dyn9047017100.beaverton.ibm.com>
References: <1204836859.4772.32.camel@nimitz.home.sr71.net>
	<1204839763.6272.8.camel@dyn9047017100.beaverton.ibm.com>
Message-Id: <20080307102032.A17D.E1E9C6FF@jp.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Dave Hansen <haveblue@us.ibm.com>,
	lkml <linux-kernel@vger.kernel.org>, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Badari-san.

> On Thu, 2008-03-06 at 12:54 -0800, Dave Hansen wrote:
> > On Thu, 2008-03-06 at 10:55 -0800, Badari Pulavarty wrote:
> > > +               if (memmap)
> > > +                       __kfree_section_memmap(memmap, PAGES_PER_SECTION);
> > > +               return;
> > > +       }
> > > +
> > > +       /*
> > > +        * Allocations came from bootmem - how do I free up ?
> > > +        */
> > > +
> > 
> > Shouldn't we figure this one out before merging?
> > 
> > I think we at least need a printk() there.
> 
> I can add a printk(). I am hoping Yasunori Goto has something to
> handle this, before we really merge into mainline.

Ah, yes. 
I'm making patches for around here. I'm sorry for your waiting.

BTW, do you hurry for merging your patch? 
To be honest, I would like to solve not only here
but also some other issues.
But, if you hurry, I'll concentrate to solve only this.

Bye.

-- 
Yasunori Goto 
