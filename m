Return-Path: <jlarrew@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e38.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 05612B70F2
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 23 Jul 2010 07:09:30 +1000 (EST)
Received: from d03relay03.boulder.ibm.com (d03relay03.boulder.ibm.com
	[9.17.195.228])
	by e38.co.us.ibm.com (8.14.4/8.13.1) with ESMTP id o6ML2LaF011468
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jul 2010 15:02:21 -0600
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d03relay03.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o6ML9DaH063690
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jul 2010 15:09:14 -0600
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id o6ML93ZD004665
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jul 2010 15:09:03 -0600
Received: from manic8ball.ltc.austin.ibm.com ([9.12.226.27])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVin) with ESMTP id
	o6ML93Zp004566
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jul 2010 15:09:03 -0600
Message-ID: <4C48B36E.6040505@linux.vnet.ibm.com>
Date: Thu, 22 Jul 2010 16:09:02 -0500
From: Jesse Larrew <jlarrew@linux.vnet.ibm.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc: print cores passed to firmware in decimal
References: <4553.1279775749@neuling.org>
In-Reply-To: <4553.1279775749@neuling.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/22/2010 12:15 AM, Michael Neuling wrote:
> @@ -869,12 +895,12 @@ static void __init prom_send_capabilities(void)
>   		cores = (u32 *)PTRRELOC(&ibm_architecture_vec[IBM_ARCH_VEC_NRCORES_OFFSET]);
>   		if (*cores != NR_CPUS) {
>   			prom_printf("WARNING ! "
> -				    "ibm_architecture_vec structure inconsistent: 0x%x !\n",
> +				    "ibm_architecture_vec structure inconsistent: 0x%i !\n",
>   				    *cores);
>    

Since we're changing from hex to decimal, we shouldn't print the "0x".

Sincerely,

-- 

Jesse Larrew
Software Engineer, Linux on Power Kernel Team
IBM Linux Technology Center
Phone: (512) 973-2052 (T/L: 363-2052)
jlarrew@linux.vnet.ibm.com
