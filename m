Return-Path: <sachinp@in.ibm.com>
Received: from e28esmtp05.in.ibm.com (e28smtp05.in.ibm.com [59.145.155.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e28smtp05.in.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B78BCDDEE2
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jul 2008 16:32:57 +1000 (EST)
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
	by e28esmtp05.in.ibm.com (8.13.1/8.13.1) with ESMTP id m636Vu57007934
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Jul 2008 12:01:56 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
	by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m636VZwY1376498
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Jul 2008 12:01:35 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
	by d28av04.in.ibm.com (8.13.1/8.13.3) with ESMTP id m636VthA014644
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Jul 2008 12:01:55 +0530
Message-ID: <486C726A.9080606@in.ibm.com>
Date: Thu, 03 Jul 2008 12:02:10 +0530
From: "Sachin P. Sant" <sachinp@in.ibm.com>
MIME-Version: 1.0
To: michael@ellerman.id.au
Subject: Re: [PATCH] powerpc: Fix /dev/oldmem for kdump
References: <48637594.5040709@in.ibm.com> <1215065710.17950.12.camel@localhost>
In-Reply-To: <1215065710.17950.12.camel@localhost>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Ellerman wrote:
> Even though I wrote this, it was so long ago I can't really vouch for
> it. If you've tested it and it works Sachin then we should merge it. Is
> this fix in distros or does it not apply?
>   
Yes, i have tested this on couple of power boxes and the patch
works fine. [ i can copy dump using both /proc/vmcore and /dev/oldmem
interface ]

No this fix is not part of distro ATM. But yes it applies to distros
also. Once it is merged upstream, distros will eventually pick this up.

Thanks
-Sachin
