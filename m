Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6A80DDDF1E
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Apr 2008 16:37:21 +1000 (EST)
Message-ID: <4816C214.60806@pobox.com>
Date: Tue, 29 Apr 2008 02:37:08 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Tejun Heo <htejun@gmail.com>
Subject: Re: [PATCH] devres: support addresses greater than an unsigned long
	via dev_ioremap
References: <Pine.LNX.4.64.0804290122210.10928@blarg.am.freescale.net>
	<4816C094.6030601@gmail.com>
In-Reply-To: <4816C094.6030601@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Andrew Morton <akpm@osdl.org>, Greg KH <greg@kroah.com>,
	Jesse Barnes <jbarnes@virtuousgeek.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tejun Heo wrote:
> Kumar Gala wrote:
>> Use a resource_size_t instead of unsigned long since some arch's are
>> capable of having ioremap deal with addresses greater than the size of a
>> unsigned long.
>>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> 
> Acked-by: Tejun Heo <htejun@gmail.com>

Fine with me, too.

I think devres changes should go via GregKH (device core) or Jesse (PCI) 
rather than my libata tree, unless there are obvious dependencies...

	Jeff
