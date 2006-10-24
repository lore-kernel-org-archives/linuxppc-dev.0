Return-Path: <linas@austin.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e35.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 61A5F67BD7
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Oct 2006 09:17:23 +1000 (EST)
Received: from westrelay02.boulder.ibm.com (westrelay02.boulder.ibm.com
	[9.17.195.11])
	by e35.co.us.ibm.com (8.13.8/8.12.11) with ESMTP id k9ONHKap023863
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Oct 2006 19:17:20 -0400
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by westrelay02.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k9ONHKj5533306
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Oct 2006 17:17:20 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k9ONHJEG028363
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Oct 2006 17:17:20 -0600
Date: Tue, 24 Oct 2006 18:17:19 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: map 4K iommu pages even on 64K largepage systems
Message-ID: <20061024231719.GE6360@austin.ibm.com>
References: <20061024002540.GA6360@austin.ibm.com>
	<1161665007.10524.572.camel@localhost.localdomain>
	<1161666868.10524.577.camel@localhost.localdomain>
	<20061024200803.GC6360@austin.ibm.com>
	<1161726084.10524.622.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1161726084.10524.622.camel@localhost.localdomain>
From: linas@austin.ibm.com (Linas Vepstas)
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Oct 25, 2006 at 07:41:23AM +1000, Benjamin Herrenschmidt wrote:
>
> My point is that we'll probably not change IOMMU_PAGE_SHIFT. The only
> thing we might do is to move the shift into the iommu_table structure to
> make it per-iommu (in which case the TCE backend will use 4k or 64k
> depending on actual HW/FW support for those sizes).

OK, right; I don't know why, I didn't see this right wawy.

--linas
