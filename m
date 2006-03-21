Return-Path: <haveblue@us.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4602867A41
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Mar 2006 06:27:58 +1100 (EST)
Received: from e4.ny.us.ibm.com ([192.168.1.104])
	by pokfb.esmtp.ibm.com (8.12.11/8.12.11) with ESMTP id k2LIT5FA025559
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Mar 2006 13:29:05 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id k2LISmfA015416
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Mar 2006 13:28:48 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2LIScJ3226782
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Mar 2006 13:28:38 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k2LISbGB008325
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Mar 2006 13:28:37 -0500
Subject: Re: [PATCH 2/7] powerpc numa: Minor debugging code changes
From: Dave Hansen <haveblue@us.ibm.com>
To: Nathan Lynch <nathanl@austin.ibm.com>
In-Reply-To: <11429012851755-git-send-email-nathanl@austin.ibm.com>
References: <11429012851755-git-send-email-nathanl@austin.ibm.com>
Content-Type: text/plain
Date: Tue, 21 Mar 2006 10:27:11 -0800
Message-Id: <1142965632.10906.163.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-03-20 at 18:34 -0600, Nathan Lynch wrote:
> Don't print a meaningless associativity depth (-1) on non-numa systems.
...
> -	dbg("NUMA associativity depth for CPU/Memory: %d\n", min_common_depth);
>  	if (min_common_depth < 0)
>  		return min_common_depth;
>  
> +	dbg("NUMA associativity depth for CPU/Memory: %d\n", min_common_depth);

This is debugging code anyway, right?

I thought this might be useful when you're booting on a machine which
you _think_ should be NUMA, but doesn't come up that way.  Did you boot
a non-NUMA kernel, or is something in the reporting wrong?  It makes it
pretty obvious when you see this printout.  

-- Dave
