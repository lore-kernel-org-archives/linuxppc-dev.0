Return-Path: <ahuja@austin.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 81D9CDDF30
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2008 03:37:02 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m2CGauhv028432
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 12:36:56 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m2CGauZv340640
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 12:36:56 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m2CGaulI023426
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Mar 2008 12:36:56 -0400
Message-ID: <47D806A7.6050504@austin.ibm.com>
Date: Wed, 12 Mar 2008 11:36:55 -0500
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH 8/8] pseries: phyp dump: config file
References: <47B90F55.2080606@austin.ibm.com>	<1203641584.15378.2.camel@concordia.ozlabs.ibm.com>	<47C74A66.1060105@austin.ibm.com>	<47C7533D.9040002@austin.ibm.com>
	<18390.9443.218176.274640@cargo.ozlabs.ibm.com>
In-Reply-To: <18390.9443.218176.274640@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linasvepstas@gmail.com, mahuja@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Thanks for the review. I will try and make the recommended changes and repost it soon.

Manish


Paul Mackerras wrote:
> Manish Ahuja writes:
> 
>> +config PHYP_DUMP
>> +	bool "Hypervisor-assisted dump (EXPERIMENTAL)"
>> +	depends on PPC_PSERIES && EXPERIMENTAL
>> +	default y
> 
> I think this should default to n for now (i.e. leave out the default
> line entirely).  We can make it default to y later.
> 
> Paul.
