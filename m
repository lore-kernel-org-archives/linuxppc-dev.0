Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 358C3B7D59
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 25 May 2010 21:01:10 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id o4PArnjb002341
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 May 2010 04:53:49 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	o4PB11Ae247474
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 May 2010 05:01:03 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id o4PB0p8D031912
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 May 2010 05:00:51 -0600
Date: Tue, 25 May 2010 07:00:50 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: mmio_nvram.c users ?
Message-ID: <20100525110050.GH24511@zod.rchland.ibm.com>
References: <1274773439.1931.238.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1274773439.1931.238.camel@pasglop>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 25, 2010 at 05:43:59PM +1000, Benjamin Herrenschmidt wrote:
>Hi folks !
>
>Anybody aware of anything other than Cell using that driver ?
>
>I'd like to make it a platform driver instead of having something that
>pokes at anything that has a "device_type" set to "nvram" (which is
>gross and bogus). But I need to know what platforms to fixup...

Why bother?  You could just use either drivers/mtd/devices/{phram.c or slram.c}
and get the same functionality at that point, couldn't you?

josh
