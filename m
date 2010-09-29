Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 9254AB70B8
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Sep 2010 23:16:50 +1000 (EST)
Date: Wed, 29 Sep 2010 05:37:52 -0700
From: Greg KH <greg@kroah.com>
To: Avi Kivity <avi@redhat.com>
Subject: Re: [PATCH 0/8] v2 De-Couple sysfs memory directories from memory
	sections
Message-ID: <20100929123752.GA18865@kroah.com>
References: <4CA0EBEB.1030204@austin.ibm.com> <4CA1E338.6070201@redhat.com>
	<20100928151218.GJ14068@sgi.com> <20100929025035.GA13096@kroah.com>
	<4CA2F9A2.3090202@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4CA2F9A2.3090202@redhat.com>
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

On Wed, Sep 29, 2010 at 10:32:34AM +0200, Avi Kivity wrote:
>  On 09/29/2010 04:50 AM, Greg KH wrote:
>> >
>> >  Because the old ABI creates 129,000+ entries inside
>> >  /sys/devices/system/memory with their associated links from
>> >  /sys/devices/system/node/node*/ back to those directory entries.
>> >
>> >  Thankfully things like rpm, hald, and other miscellaneous commands scan
>> >  that information.
>>
>> Really?  Why?  Why would rpm care about this?  hald is dead now so we
>> don't need to worry about that anymore,
>
> That's not what compatiblity means.  We can't just support 
> latest-and-greatest userspace on latest-and-greatest kernels.

Oh, I know that, that's not what I was getting at at all here, sorry if
it came across that way.

I wanted to know so we could go fix programs that are mucking around in
these files, as odds are, the shouldn't be doing that in the first
place.

Like rpm, why would it matter what the memory in the system looks like?

thanks,

greg k-h
