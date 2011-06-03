Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9E0F1B6FB0
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jun 2011 22:09:02 +1000 (EST)
Received: from d03relay01.boulder.ibm.com (d03relay01.boulder.ibm.com
	[9.17.195.226])
	by e33.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id p53ALevP021057
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Jun 2011 04:21:40 -0600
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
	by d03relay01.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP
	id p53ASsC4204408
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Jun 2011 04:28:56 -0600
Received: from d03av05.boulder.ibm.com (loopback [127.0.0.1])
	by d03av05.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id p53ASrc8007566
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Jun 2011 04:28:54 -0600
Date: Fri, 3 Jun 2011 06:30:11 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Greg KH <greg@kroah.com>
Subject: Re: [stable] [PATCH] 2.6.39 powerpc: Fix 32-bit SMP build
Message-ID: <20110603103011.GC2457@zod.rchland.ibm.com>
References: <20110530122621.GD2557@zod.rchland.ibm.com>
	<20110603055650.GB21323@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110603055650.GB21323@kroah.com>
Cc: linuxppc-dev@lists.ozlabs.org, stable@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 03, 2011 at 02:56:50PM +0900, Greg KH wrote:
>On Mon, May 30, 2011 at 08:26:21AM -0400, Josh Boyer wrote:
>> Backport upstream commit 6de06f313a65d0ec
>>     
>> Commit fa3f82c8bb7acb ("powerpc/smp: soft-replugged CPUs must go back to
>> start_secondary") introduced start_secondary_resume to head_32.S, however
>> it uses a 64-bit instruction which is not valid on 32-bit platforms.  Use
>> 'stw' instead.
>>     
>> CC: stable@kernel.org
>> Signed-off-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>
>
>This doesn't apply either:
>
>patching file arch/powerpc/kernel/head_32.S
>Hunk #1 FAILED at 896.
>1 out of 1 hunk FAILED -- saving rejects to file arch/powerpc/kernel/head_32.S.rej
>
>Please send something that at least applies, and hopefully builds...

Odd.  It was generated with git from 2.6.39 and it builds here.  I'll
try and figure out what went wrong.

josh
