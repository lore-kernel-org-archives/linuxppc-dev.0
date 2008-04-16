Return-Path: <jschopp@austin.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2229CDE149
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 05:42:45 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m3GJgfJh007599
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 15:42:41 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m3GJgfJp192396
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 13:42:41 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m3GJgeAo014728
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Apr 2008 13:42:40 -0600
Message-ID: <480656AB.2080009@austin.ibm.com>
Date: Wed, 16 Apr 2008 14:42:35 -0500
From: Joel Schopp <jschopp@austin.ibm.com>
MIME-Version: 1.0
To: Manish Ahuja <ahuja@austin.ibm.com>
Subject: Re: [PATCH] pseries: phyp dump: Variable size reserve space.
References: <47FAB221.7050406@austin.ibm.com>	<47FFF4E8.9010705@austin.ibm.com>	<18436.18955.450131.623072@cargo.ozlabs.ibm.com>
	<4805328E.2050709@austin.ibm.com>
In-Reply-To: <4805328E.2050709@austin.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, linasvepstas@gmail.com,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> The aim is to have more flex space for the kernel on machines with more resources. Although the dump will be collected pretty fast and the memory released really early on allowing the machine to have the full memory available, this alleviates any issues that can be caused by having way too little memory on very very large systems during those few minutes.
>
> -Manish
I think this would be an issue for distro kernels that have minimum 
requirements for memory above 256MB.  It seems like a reasonable attempt 
to have good defaults.  The user can always override it with boot args.  
I'm not sure where the exact numbers should be but the general statement 
that larger memory systems should have more memory to boot with seems 
like a good one.
