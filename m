Return-Path: <rdreier@cisco.com>
Received: from sj-iport-4.cisco.com (sj-iport-4.cisco.com [171.68.10.86])
	by ozlabs.org (Postfix) with ESMTP id 6C94B67C46
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Nov 2006 03:51:58 +1100 (EST)
To: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
Subject: Re: [PATCH 2.6.19 1/4] ehca: assure 4k alignment for firmware control
	block in 64k page mode
References: <OF69697CF5.13DC8781-ONC125721E.0039CD42-C125721E.003A3D50@de.ibm.com>
From: Roland Dreier <rdreier@cisco.com>
Date: Mon, 06 Nov 2006 08:51:53 -0800
In-Reply-To: <OF69697CF5.13DC8781-ONC125721E.0039CD42-C125721E.003A3D50@de.ibm.com>
	(Hoang-Nam Nguyen's message of "Mon, 6 Nov 2006 11:39:09 +0100")
Message-ID: <adaodrko6vq.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

 > As Arnd stated I need to fix this ctor issue. Do you prefer me to resend
 > all patches in proper format (non-mangled inline) or just this one bug fix?

I have the rest of the patches, so you just need to resend a fixed
version of this one.  BTW see my previous response about
kmem_cache_zalloc() -- I think that's the best way to fix this.

In the future though if you can make a patch-sending script or
something that lets you avoid the attachments that would be great.
