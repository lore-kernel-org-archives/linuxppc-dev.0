Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 5D062B7257
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Sep 2009 06:43:58 +1000 (EST)
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e37.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D466DDDD0B
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 06:43:57 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n8EKguNb001608
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 14:42:56 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8EKhqWj214218
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 14:43:52 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8EKhqIi018934
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Sep 2009 14:43:52 -0600
Date: Mon, 14 Sep 2009 16:43:48 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Maynard Johnson <maynardj@us.ibm.com>
Subject: Re: [PATCH] powerpc: Fix bug where perf_counters breaks oprofile
Message-ID: <20090914204348.GE12372@zod.rchland.ibm.com>
References: <19111.37067.783017.427206@cargo.ozlabs.ibm.com>
	<4AA7AE3B.30809@us.ibm.com> <4AAEA40A.6040701@us.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4AAEA40A.6040701@us.ibm.com>
Cc: Paul Mackerras <paulus@samba.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>,
	Maynard Johnson <mpjohn@us.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Sep 14, 2009 at 03:14:02PM -0500, Maynard Johnson wrote:
>Maynard Johnson wrote:
>> Paul Mackerras wrote:
>>> Currently there is a bug where if you use oprofile on a pSeries
>>> machine, then use perf_counters, then use oprofile again, oprofile
>>> will not work correctly; it will lose the PMU configuration the next
>>> time the hypervisor does a partition context switch, and thereafter
>>> won't count anything.
>Ben,
>Is there any way to get this bug fix into 2.6.31 or is the window closed?  Once the problem occurs, you can't get oprofile to work again without a reboot.  Really would be nice (for many reasons) to get this fixed in .31.

.31 is already released.  Could probably get it into a -stable .31 kernel
though.

josh
