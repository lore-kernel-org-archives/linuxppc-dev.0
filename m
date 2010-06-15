Return-Path: <prasad@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 79493B7DA0
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jun 2010 16:09:47 +1000 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp06.au.ibm.com (8.14.4/8.13.1) with ESMTP id o5F69goo025944
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jun 2010 16:09:42 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o5F69laJ1761420
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jun 2010 16:09:47 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o5F69kna007015
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jun 2010 16:09:46 +1000
Date: Tue, 15 Jun 2010 11:39:42 +0530
From: "K.Prasad" <prasad@linux.vnet.ibm.com>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [Patch 0/5] PPC64-HWBKPT: Hardware Breakpoint interfaces - ver
	XXII
Message-ID: <20100615060942.GB2971@in.ibm.com>
References: <20100528063924.GA8679@in.ibm.com>
	<20100602113316.GA17061@brick.ozlabs.ibm.com>
	<20100604065145.GA2408@in.ibm.com> <20100615015459.GA30479@drongo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20100615015459.GA30479@drongo>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: prasad@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 15, 2010 at 11:54:59AM +1000, Paul Mackerras wrote:
> On Fri, Jun 04, 2010 at 12:21:45PM +0530, K.Prasad wrote:
> 
> > Meanwhile I tested the per-cpu breakpoints with the new emulate_step
> > patch (refer linuxppc-dev message-id:
> > 20100602112903.GB30149@brick.ozlabs.ibm.com) and they continue to fail
> > due to emulate_step() failure, in my case, on a "lwz r0,0(r28)"
> > instruction.
> 
> You need to pass the instruction word to emulate_step(), not the
> instruction address.  Also you need to have the full GPR set
> available.  The patch below fixes these problems.  I'll fold these
> changes into your patch 2/5.
> 
> Paul.

The breakpoints that used to fail before (due to emulate_step() failure)
are now working fine upon applying this patch.

Please include this patch along with my 2/5 as indicated by you.

Thanks,
K.Prasad
