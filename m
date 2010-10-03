Return-Path: <avi@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 87B44B70CB
	for <linuxppc-dev@ozlabs.org>; Sun,  3 Oct 2010 18:53:09 +1100 (EST)
Message-ID: <4CA83651.1010502@redhat.com>
Date: Sun, 03 Oct 2010 09:52:49 +0200
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 0/8] v2 De-Couple sysfs memory directories from memory
	sections
References: <4CA0EBEB.1030204@austin.ibm.com> <4CA1E338.6070201@redhat.com>
	<20100928151218.GJ14068@sgi.com> <20100929025035.GA13096@kroah.com>
	<4CA2F9A2.3090202@redhat.com> <20100929123752.GA18865@kroah.com>
In-Reply-To: <20100929123752.GA18865@kroah.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	Dave Hansen <dave@linux.vnet.ibm.com>, linux-mm@kvack.org,
	Robin Holt <holt@sgi.com>,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

  On 09/29/2010 02:37 PM, Greg KH wrote:
> >>  >   Thankfully things like rpm, hald, and other miscellaneous commands scan
> >>  >   that information.
> >>
> >>  Really?  Why?  Why would rpm care about this?  hald is dead now so we
> >>  don't need to worry about that anymore,
> >
> >  That's not what compatiblity means.  We can't just support
> >  latest-and-greatest userspace on latest-and-greatest kernels.
>
> Oh, I know that, that's not what I was getting at at all here, sorry if
> it came across that way.
>
> I wanted to know so we could go fix programs that are mucking around in
> these files, as odds are, the shouldn't be doing that in the first
> place.
>
> Like rpm, why would it matter what the memory in the system looks like?
>

I see, thanks.

-- 
I have a truly marvellous patch that fixes the bug which this
signature is too narrow to contain.
