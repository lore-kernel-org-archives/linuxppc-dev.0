Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 497EFB7D40
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  7 Jun 2010 21:58:07 +1000 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e36.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o57BslJh027251
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Jun 2010 05:54:47 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o57Bw3pX102620
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Jun 2010 05:58:03 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o57Bw2tn025806
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 7 Jun 2010 05:58:03 -0600
Date: Mon, 7 Jun 2010 07:58:01 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: Disable CONFIG_SYSFS_DEPRECATED
Message-ID: <20100607115801.GE7801@zod.rchland.ibm.com>
References: <20100506033041.GA12203@kryten>
	<20100506113816.GP2671@hansolo.jdub.homelinux.org>
	<20100607004657.GJ28295@kryten>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100607004657.GJ28295@kryten>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 07, 2010 at 10:46:57AM +1000, Anton Blanchard wrote:
>
>Hi Josh,
>
>> I'd like to run a few tests with this disabled on the 4xx boards first please.
>> I can't say that all the boards I have will have any sort of "distro" to begin
>> with, and if they did they might not be running something from the last 3 or
>> 4 years.  I do run -git kernels on them frequently though.
>
>Any luck with this? I can submit a patch to fix the 64bit platforms and ignore
>all 32bit if there is going to be a problem.

Yes actually.  I've tested on a few boards and it seems to be working well
enough.  My apologies for not replying sooner.

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

josh
