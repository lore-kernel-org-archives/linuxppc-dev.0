Return-Path: <sachinp@in.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp05.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 484E2B6EF5
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 17:41:57 +1100 (EST)
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
	by e28smtp05.in.ibm.com (8.14.3/8.13.1) with ESMTP id nBG6ftpA025843
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 12:11:55 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nBG6fsLf684032
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 12:11:55 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nBG6frC2021316
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Dec 2009 17:41:54 +1100
Message-ID: <4B288131.2050306@in.ibm.com>
Date: Wed, 16 Dec 2009 12:11:53 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Xiaotian Feng <xtfeng@gmail.com>
Subject: Re: [Next] CPU Hotplug test failures on powerpc
References: <4B2224C7.1020908@in.ibm.com>
	<7b6bb4a50912152225p4f5dde13re83c439407c16eaf@mail.gmail.com>
In-Reply-To: <7b6bb4a50912152225p4f5dde13re83c439407c16eaf@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: Peter Zijlstra <peterz@infradead.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	linux-next@vger.kernel.org, Ingo Molnar <mingo@elte.hu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Xiaotian Feng wrote:
> Does this testcase hotplug cpu 0 off?
>   
No, i don't think so. It skips cpu0 during online/offline
process.

thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
