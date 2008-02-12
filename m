Return-Path: <ahuja@austin.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B7E47DE07B
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Feb 2008 08:18:19 +1100 (EST)
Received: from e2.ny.us.ibm.com ([192.168.1.102])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	m1CGbbHY022101
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 11:37:37 -0500
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m1CGWaWm021540
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 11:32:36 -0500
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m1CGWapM112466
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 11:32:36 -0500
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m1CGWZbk005747
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 11:32:36 -0500
Message-ID: <47B1CA22.1040409@austin.ibm.com>
Date: Tue, 12 Feb 2008 10:32:34 -0600
From: Manish Ahuja <ahuja@austin.ibm.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 6/8] pseries: phyp dump: Invalidate and print dump areas.
References: <4782B985.2090508@austin.ibm.com>	<47B13D2E.1070001@austin.ibm.com>	<47B1483E.8040303@austin.ibm.com>
	<20080212211820.439dad00.sfr@canb.auug.org.au>
In-Reply-To: <20080212211820.439dad00.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: mahuja@us.ibm.com, linuxppc-dev@ozlabs.org, linasvepstas@gmail.com,
	paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
> Hi Manish,
> 
> On Tue, 12 Feb 2008 01:18:22 -0600 Manish Ahuja <ahuja@austin.ibm.com> wrote:
>> -static void
>> -release_memory_range(unsigned long start_pfn, unsigned long nr_pages)
>> +static
>> +void release_memory_range(unsigned long start_pfn, unsigned long nr_pages)
> 
> Cosmetic changes like this should normally be put in separate patch as
> they just distract from a real review (which this isn't :-))
> 

Okay, will do from future.
