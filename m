Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4D2CEDDE02
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Dec 2007 01:49:26 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id lB3EnNgQ008669
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Dec 2007 09:49:23 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB3EnJNk128418
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Dec 2007 07:49:20 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB3EnJ3w007493
	for <linuxppc-dev@ozlabs.org>; Mon, 3 Dec 2007 07:49:19 -0700
Date: Mon, 3 Dec 2007 08:49:00 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: for-2.6.25 branch created in powerpc.git
Message-ID: <20071203084900.327d4abc@weaponx>
In-Reply-To: <18259.35326.516899.603549@cargo.ozlabs.ibm.com>
References: <18259.35326.516899.603549@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 3 Dec 2007 15:45:50 +1100
Paul Mackerras <paulus@samba.org> wrote:

> I have created a for-2.6.25 branch in my powerpc.git repository and
> added the patches listed below to it.  The master branch points to the
> same place as the for-2.6.25 branch.

Are we going to merge DTC into the kernel?  If so, can we get that in
this branch soon-ish, and with a version that supports dts-v1 files?

josh
