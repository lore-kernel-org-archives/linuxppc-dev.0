Return-Path: <dvhltc@us.ibm.com>
Received: from e8.ny.us.ibm.com (e8.ny.us.ibm.com [32.97.182.138])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e8.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E661CB70E5
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Jul 2010 04:36:53 +1000 (EST)
Received: from d01relay07.pok.ibm.com (d01relay07.pok.ibm.com [9.56.227.147])
	by e8.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6MIYiY7026921
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 14:34:44 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay07.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6MIaPYv1581128
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 14:36:25 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o6MIaNjG028081
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 15:36:25 -0300
Message-ID: <4C488FA4.6050009@us.ibm.com>
Date: Thu, 22 Jul 2010 11:36:20 -0700
From: Darren Hart <dvhltc@us.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH][RFC] preempt_count corruption across H_CEDE call with
	CONFIG_PREEMPT on pseries
References: <4C488CCD.60004@us.ibm.com>
In-Reply-To: <4C488CCD.60004@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Gautham R Shenoy <ego@in.ibm.com>,
	Steven Rostedt <rostedt@goodmis.org>, Will Schmidt <willschm@us.ibm.com>,
	Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/22/2010 11:24 AM, Darren Hart wrote:

> The following patch is most certainly not correct, but it does eliminate
> the situation on mainline 100% of the time (there is still a 25%
> reproduction rate on PREEMPT_RT). Can someone comment on:

Apologies. This particular issue is also 100% eliminated on PREEMPT_RT. 
We hit another issue possibly unrelated to this 25% of time. Please 
disregard the comment regarding 25% failure on PREEMPT_RT.

-- 
Darren Hart
IBM Linux Technology Center
Real-Time Linux Team
