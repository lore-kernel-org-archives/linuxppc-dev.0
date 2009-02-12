Return-Path: <sachinp@in.ibm.com>
Received: from e23smtp04.au.ibm.com (unknown [202.81.31.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 432FEDDDE4
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 22:28:40 +1100 (EST)
Received: from d23relay02.au.ibm.com (d23relay02.au.ibm.com [202.81.31.244])
	by e23smtp04.au.ibm.com (8.13.1/8.13.1) with ESMTP id n1CBQrnq009074
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 22:26:53 +1100
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay02.au.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	n1CBSvi7974868
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 22:28:57 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n1CBSdlo022004
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 22:28:39 +1100
Message-ID: <499407E5.1070705@in.ibm.com>
Date: Thu, 12 Feb 2009 16:58:37 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Nick Piggin <npiggin@suse.de>
Subject: Re: next Feb 10: mm/slqb build break
References: <20090210194121.80256b72.sfr@canb.auug.org.au>
	<49914790.6050008@in.ibm.com> <49914EE7.7030205@in.ibm.com>
	<84144f020902100353x4074f342ne4d61483074a06b7@mail.gmail.com>
	<20090212014503.GD30043@wotan.suse.de>
In-Reply-To: <20090212014503.GD30043@wotan.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org,
	Pekka Enberg <penberg@cs.helsinki.fi>, linux-next@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Nick Piggin wrote:
>> Actually, that's not the root cause here. You seem to have CONFIG_SMP
>> disabled but CONFIG_NUMA enabled. That's not possible on x86 which
>> makes me think it's a ppc kconfig bug. Hmm?
>>     
>
> If it is really a valid config, then we should be able to make
> slqb build with it...
I am not sure if this is a valid config. According to arch/powerpc/Kconfig
NUMA depends on PPC64 and defaults to y if SMP & PPC_PSERIES is set.

If this is not a valid config then may be the make randconfig rules
need to be changed accordingly.

Ben should know. Ben ??

Thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
