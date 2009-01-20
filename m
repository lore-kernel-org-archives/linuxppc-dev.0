Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 784FEDDF00
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jan 2009 22:26:48 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e3.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id n0KBP1i9004300
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jan 2009 06:25:01 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n0KBQdkq195172
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jan 2009 06:26:39 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n0KBQdXg004384
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Jan 2009 06:26:39 -0500
Date: Tue, 20 Jan 2009 06:26:22 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] powerpc: Warp patches for the new ndfc driver
Message-ID: <20090120112622.GE3853@zod.rchland.ibm.com>
References: <20090109232011.19f6e780@lappy.seanm.ca>
	<20090119231205.2378e31f@lappy.seanm.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090119231205.2378e31f@lappy.seanm.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 19, 2009 at 11:12:05PM -0500, Sean MacLennan wrote:
>On Fri, 9 Jan 2009 23:20:11 -0500
>"Sean MacLennan" <sean.maclennan@ottawa.kanatek.ca> wrote:
>
>> Woo hoo! The ndfc driver finally got in the kernel! These patches
>> update the warp to use the new driver.
>
>Just a bump and a comment to see who is reading this ;) 
>
>2.6.29 is a very important release for the Warp because with the
>ndfc driver, and assuming this patch or something like it is accepted,
>you will be able to get a working kernel for the warp from kernel.org.
>It will be missing SD support and LED support, but everything else will
>work :)

I have it queued up for today.  I was waiting for Ben to bump his tree
to include -rc2 so that I can send him the defconfig updates at the same
time.

>But it seems to me that otherwise, 2.6.29 seems to be a very quiet
>release. Has anybody else noticed this?

Yes.


josh
