Return-Path: <suzuki@in.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com",
	Issuer "GeoTrust SSL CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 95F2B1007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  5 Jul 2011 16:19:04 +1000 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp04.au.ibm.com (8.14.4/8.13.1) with ESMTP id p656CovL009164
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jul 2011 16:12:50 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	p656Ha6w1003556
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jul 2011 16:17:36 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	p656J2dH019561
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 5 Jul 2011 16:19:02 +1000
Message-ID: <4E12ACD2.9050305@in.ibm.com>
Date: Tue, 05 Jul 2011 11:48:58 +0530
From: Suzuki Poulose <suzuki@in.ibm.com>
MIME-Version: 1.0
To: LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>,
	Josh Boyer <jwboyer@linux.vnet.ibm.com>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/3] powerpc/47x: allow kernel to be loaded in higher
	physical memory
References: <20110705043657.GF13483@ozlabs.org>
In-Reply-To: <20110705043657.GF13483@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/05/11 10:06, Tony Breeds wrote:
> From: Dave Kleikamp<shaggy@linux.vnet.ibm.com>
>
> The 44x code (which is shared by 47x) assumes the available physical memory
> begins at 0x00000000.  This is not necessarily the case in an AMP
> environment.
>
> Support CONFIG_RELOCATABLE for 476 in order to allow the kernel to be
> loaded into a higher memory range.

I think the code assumes, the kernel is loaded in 256M aligned page. You may
want to mention that in the description here.

Thanks
Suzuki
