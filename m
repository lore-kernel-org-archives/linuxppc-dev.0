Return-Path: <pbadari@us.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e31.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 35378DE09E
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Mar 2008 08:39:27 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e31.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m26LdMkl020274
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Mar 2008 16:39:22 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m26LdMcP210364
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Mar 2008 14:39:22 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m26LdMwS026902
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Mar 2008 14:39:22 -0700
Subject: Re: [PATCH 1/5] generic __remove_pages() support
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Dave Hansen <haveblue@us.ibm.com>
In-Reply-To: <1204836859.4772.32.camel@nimitz.home.sr71.net>
References: <1204829673.7939.59.camel@dyn9047017100.beaverton.ibm.com>
	<1204829734.7939.61.camel@dyn9047017100.beaverton.ibm.com>
	<1204836859.4772.32.camel@nimitz.home.sr71.net>
Content-Type: text/plain
Date: Thu, 06 Mar 2008 13:42:43 -0800
Message-Id: <1204839763.6272.8.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	paulus@samba.org, lkml <linux-kernel@vger.kernel.org>,
	Yasunori Goto <y-goto@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-03-06 at 12:54 -0800, Dave Hansen wrote:
> On Thu, 2008-03-06 at 10:55 -0800, Badari Pulavarty wrote:
> > +               if (memmap)
> > +                       __kfree_section_memmap(memmap, PAGES_PER_SECTION);
> > +               return;
> > +       }
> > +
> > +       /*
> > +        * Allocations came from bootmem - how do I free up ?
> > +        */
> > +
> 
> Shouldn't we figure this one out before merging?
> 
> I think we at least need a printk() there.

I can add a printk(). I am hoping Yasunori Goto has something to
handle this, before we really merge into mainline.

Thanks,
Badari
