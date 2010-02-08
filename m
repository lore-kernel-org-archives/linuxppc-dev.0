Return-Path: <svaidy@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7D33DB7D1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  8 Feb 2010 23:56:29 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp07.au.ibm.com (8.14.3/8.13.1) with ESMTP id o18CuS3T006982
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Feb 2010 23:56:28 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o18CpJh91642508
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Feb 2010 23:51:19 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o18CuRPp007313
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 8 Feb 2010 23:56:28 +1100
Date: Mon, 8 Feb 2010 18:26:19 +0530
From: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
To: Balbir Singh <balbir@linux.vnet.ibm.com>
Subject: Re: [PATCH] powerpc: Quieten cede latency printk
Message-ID: <20100208125619.GA22194@dirshya.in.ibm.com>
References: <20100207235205.GI32246@kryten>
	<661de9471002080307p48e0ff69v6318790eaff1c64c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <661de9471002080307p48e0ff69v6318790eaff1c64c@mail.gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Anton Blanchard <anton@samba.org>,
	Gautham R Shenoy <ego@in.ibm.com>
Reply-To: svaidy@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Balbir Singh <balbir@linux.vnet.ibm.com> [2010-02-08 16:37:37]:

> On Mon, Feb 8, 2010 at 5:22 AM, Anton Blanchard <anton@samba.org> wrote:
> >
> > The cede latency stuff is relatively new and we don't need to complain about
> > it not working on older firmware.
> >
> > Signed-off-by: Anton Blanchard <anton@samba.org>
> 
> Acked-by: Balbir Singh <balbir@linux.vnet.ibm.com>
> 
> Seems like a reasonable change. CC'ing Vaidy and Gautham to look even
> more closely at the patch.

Hi Anton,

Removing the printk is reasonable.  The failure case is noise in older
firmware while the success case may not be very informative.

Thanks,
Vaidy
