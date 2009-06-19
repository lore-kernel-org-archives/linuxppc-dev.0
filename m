Return-Path: <sachinp@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id AC378B724E
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Jun 2009 03:06:06 +1000 (EST)
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp08.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9048FDDD0C
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Jun 2009 03:06:06 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp08.au.ibm.com (8.13.1/8.13.1) with ESMTP id n5K331IU015580
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Jun 2009 13:03:01 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n5JH65DN356760
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Jun 2009 03:06:05 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n5JH64Cg018408
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Jun 2009 03:06:05 +1000
Message-ID: <4A3BC57B.8000408@in.ibm.com>
Date: Fri, 19 Jun 2009 22:36:03 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Re: [PowerPC] 2.6.30-git14 boot failure with SLAB
References: <4A3B615F.8090504@in.ibm.com>
In-Reply-To: <4A3B615F.8090504@in.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Pekka Enberg <penberg@cs.helsinki.fi>,
	linux-kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sachin Sant wrote:
> 2.6.30-git14 (0732f87761dbe417cb6e084b712d07e879e876ef) fails to boot
> on various PowerPC machines. Here are last few boot messages from a 
> Power6
> box.
<SNIP>

>
> I will go back and check what changes between git10 and git11
> could have caused this boot failure.
>
The offending commit seems to be c868d550115b9ccc0027c67265b9520790f05601.
mm: Move pgtable_cache_init() earlier

If i revert this commit, the machine boots fine.

Thanks
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
