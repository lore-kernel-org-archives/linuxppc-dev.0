Return-Path: <sachinp@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 1EB6AB6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  6 Aug 2009 01:33:55 +1000 (EST)
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [59.145.155.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp08.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 398D6DDD04
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Aug 2009 01:33:52 +1000 (EST)
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
	by e28smtp08.in.ibm.com (8.14.3/8.13.1) with ESMTP id n75FT69i007869
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Aug 2009 20:59:06 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n75FXk0o1151046
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Aug 2009 21:03:46 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	n75FXj7Z013270
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Aug 2009 01:33:46 +1000
Message-ID: <4A79A658.8000105@in.ibm.com>
Date: Wed, 05 Aug 2009 21:03:44 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Next July 29 : Hugetlb test failure (OOPS free_hugepte_range)
References: <20090729173611.b82478cd.sfr@canb.auug.org.au>
	<4A706504.6040704@in.ibm.com>
	<E0A64FA0-C835-4361-A203-E9CB5377599C@kernel.crashing.org>
In-Reply-To: <E0A64FA0-C835-4361-A203-E9CB5377599C@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Kumar Gala wrote:
>
> On Jul 29, 2009, at 10:04 AM, Sachin Sant wrote:
>
>> While executing hugetlb tests against today's Next tree on
>> a Power 6 box came across following OOPS.
>
> out of interest what tests are you running for hugetlb?
The one maintained at : http://libhugetlbfs.ozlabs.org/ which points
to the sourceforge libhugetlbfs project.

Latest release can be downloaded from sourceforge using
http://sourceforge.net/projects/libhugetlbfs/files/

I am using version 2.5

Thanks
-Sachin



-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
