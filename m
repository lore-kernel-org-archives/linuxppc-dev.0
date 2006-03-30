Return-Path: <rsa@us.ibm.com>
Received: from over.co.us.ibm.com (over.co.us.ibm.com [32.97.110.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 45563679EF
	for <linuxppc-dev@ozlabs.org>; Fri, 31 Mar 2006 07:07:01 +1100 (EST)
Received: from e3.ny.us.ibm.com ([9.56.232.143])
	by bldfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k2UFgEPg020083
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 10:42:14 -0500
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k2UFfxTa026994
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 10:41:59 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VER6.8) with ESMTP id
	k2UFfno9227260
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 10:41:49 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11/8.13.3) with ESMTP id k2UFfmLH019106
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2006 10:41:48 -0500
Subject: Re: [PATCH] Change H_StudlyCaps to H_SHOUTING_CAPS
From: Ryan Arnold <rsa@us.ibm.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <20060330115817.ADB99211AE9@Schermpje.local>
References: <20060330115817.ADB99211AE9@Schermpje.local>
Content-Type: text/plain
Date: Thu, 30 Mar 2006 09:36:39 -0600
Message-Id: <1143733000.14254.14.camel@localhost.localdomain>
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

On Thu, 2006-03-30 at 13:58 +0200, Segher Boessenkool wrote:
> [I hope I got my mailer script to work okay, don't kill me please.]
> 
> Also cleans up some nearby whitespace problems.
> 
> Signed-of-by: Segher Boessenkool <segher@kernel.crashing.org>

> -	else if (rc == H_Parameter)
> +		       "plpar-hcall (%s) failed; not authorized to this"
> +		       " function\n", tag);
> +	else if (rc == H_PARAMETER)
>  		printk(KERN_INFO "plpar-hcall (%s) failed; Bad parameter(s)\n",
>  		       tag);

I believe the studly caps were used over shouting caps because the RPA
specification, from which these ret codes were taken, uses Studly Caps.
That probably isn't sufficient justification, just an historical
perspective.

-- 
Ryan S. Arnold <rsa@us.ibm.com>
IBM Linux Technology Center
Linux on Power Toolchain
