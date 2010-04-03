Return-Path: <sachinp@in.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AF56AB6EFF
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Apr 2010 19:34:45 +1100 (EST)
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [202.81.31.247])
	by e23smtp06.au.ibm.com (8.14.3/8.13.1) with ESMTP id o338YW4x009045
	for <linuxppc-dev@ozlabs.org>; Sat, 3 Apr 2010 19:34:32 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o338SRUM737446
	for <linuxppc-dev@ozlabs.org>; Sat, 3 Apr 2010 19:28:28 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o338YiZa022911
	for <linuxppc-dev@ozlabs.org>; Sat, 3 Apr 2010 19:34:44 +1100
Message-ID: <4BB6FDA1.3070502@in.ibm.com>
Date: Sat, 03 Apr 2010 14:04:41 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: 2.6.34-rc3: Badness at kernel/lockdep.c:2706
References: <4BB588B5.1060309@in.ibm.com> <1270218533.5109.525.camel@twins>
	<m14ojtrjbv.fsf@fess.ebiederm.org>
In-Reply-To: <m14ojtrjbv.fsf@fess.ebiederm.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Peter Zijlstra <peterz@infradead.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Eric W. Biederman wrote:
> Could you try the fix Wolfram Sang sent to linux-kernel yesterday?
>   
Yes that fixed the issue for me. Thanks Eric.

Regards
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
