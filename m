Return-Path: <HNGUYEN@de.ibm.com>
Received: from mtagate3.de.ibm.com (mtagate3.de.ibm.com [195.212.29.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate3.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E458A67C70
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 04:42:10 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate3.de.ibm.com (8.13.8/8.13.8) with ESMTP id kA6Hg5sE235048
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Nov 2006 17:42:05 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id kA6Hj7Vl3170488
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Nov 2006 18:45:07 +0100
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id kA6Hg4l3026437
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Nov 2006 18:42:04 +0100
In-Reply-To: <adaodrko6vq.fsf@cisco.com>
Subject: Re: [PATCH 2.6.19 1/4] ehca: assure 4k alignment for firmware control
	block in 64k page mode
To: Roland Dreier <rdreier@cisco.com>
Message-ID: <OFB9DD8741.750AEF46-ONC125721E.00610BD7-C125721E.00613BC8@de.ibm.com>
From: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
Date: Mon, 6 Nov 2006 18:45:04 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
	openib-general@openib.org, linuxppc-dev@ozlabs.org,
	Christoph Raisch <raisch@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Roland!
>  > As Arnd stated I need to fix this ctor issue. Do you prefer me to
resend
>  > all patches in proper format (non-mangled inline) or just this one bug
fix?
> I have the rest of the patches, so you just need to resend a fixed
> version of this one.  BTW see my previous response about
> kmem_cache_zalloc() -- I think that's the best way to fix this.
Yes. This makes sense to me. Will send this one patch soon.
> In the future though if you can make a patch-sending script or
> something that lets you avoid the attachments that would be great.
Sure, will do. I just found out that I'm using an old version of
kmail and its editor (all fancy editing is turned off, just plain text)
just manngles leading and trailing tabs and spaces...
Thanks
Nam
