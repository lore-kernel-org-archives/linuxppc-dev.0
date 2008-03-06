Return-Path: <haveblue@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 254E2DDF30
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Mar 2008 07:54:24 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m26KraxT031954
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Mar 2008 15:53:36 -0500
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m26KsLdu076752
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Mar 2008 13:54:21 -0700
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m26KsK1T022818
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Mar 2008 13:54:21 -0700
Subject: Re: [PATCH 1/5] generic __remove_pages() support
From: Dave Hansen <haveblue@us.ibm.com>
To: Badari Pulavarty <pbadari@us.ibm.com>
In-Reply-To: <1204829734.7939.61.camel@dyn9047017100.beaverton.ibm.com>
References: <1204829673.7939.59.camel@dyn9047017100.beaverton.ibm.com>
	<1204829734.7939.61.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 06 Mar 2008 12:54:19 -0800
Message-Id: <1204836859.4772.32.camel@nimitz.home.sr71.net>
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

On Thu, 2008-03-06 at 10:55 -0800, Badari Pulavarty wrote:
> +               if (memmap)
> +                       __kfree_section_memmap(memmap, PAGES_PER_SECTION);
> +               return;
> +       }
> +
> +       /*
> +        * Allocations came from bootmem - how do I free up ?
> +        */
> +

Shouldn't we figure this one out before merging?

I think we at least need a printk() there.

-- Dave
