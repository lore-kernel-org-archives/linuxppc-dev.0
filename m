Return-Path: <greg@kroah.com>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 08BE0DE1A4
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 01:26:34 +1000 (EST)
Date: Tue, 29 Apr 2008 08:23:31 -0700
From: Greg KH <greg@kroah.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] devres: support addresses greater than an unsigned
	long via dev_ioremap
Message-ID: <20080429152331.GC11329@kroah.com>
References: <Pine.LNX.4.64.0804290122210.10928@blarg.am.freescale.net>
	<4816C094.6030601@gmail.com> <4816C214.60806@pobox.com>
	<C415A4D5-CE5A-4E48-B5D5-0B9A6C7A5CA6@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <C415A4D5-CE5A-4E48-B5D5-0B9A6C7A5CA6@kernel.crashing.org>
Cc: Andrew Morton <akpm@osdl.org>, Tejun Heo <htejun@gmail.com>,
	lkml Mailing List <linux-kernel@vger.kernel.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	"linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Jeff Garzik <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 29, 2008 at 09:08:14AM -0500, Kumar Gala wrote:
>
> On Apr 29, 2008, at 1:37 AM, Jeff Garzik wrote:
>> Tejun Heo wrote:
>>> Kumar Gala wrote:
>>>> Use a resource_size_t instead of unsigned long since some arch's are
>>>> capable of having ioremap deal with addresses greater than the size of a
>>>> unsigned long.
>>>>
>>>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>>> Acked-by: Tejun Heo <htejun@gmail.com>
>>
>> Fine with me, too.
>>
>> I think devres changes should go via GregKH (device core) or Jesse (PCI) 
>> rather than my libata tree, unless there are obvious dependencies...
>
> GregKH will you handle pushing this to Linus.  Its a pretty trivial patch 
> and would be nice to go into 2.6.26.  I would also consider it a bug fix of 
> shorts for any driver using devres and resource_size_t being typedef'd to 
> u64 on a 32-bit processor.

Sure, I'd be glad to.  But I don't see the patch, care to resend it to
me?

thanks,

greg k-h
