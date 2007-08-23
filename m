Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from over.ny.us.ibm.com (over.ny.us.ibm.com [32.97.182.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8DAB5DDED1
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 23:53:47 +1000 (EST)
Received: from e6.ny.us.ibm.com ([192.168.1.106])
	by pokfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	l7OBmB4H022242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 07:48:11 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7OBjwwp006245
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 07:45:58 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7OBiaei523570
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 07:44:36 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7OBia9V012269
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 07:44:36 -0400
Subject: Re: [PATCH] Remove barriers from the SLB shadow buffer update
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Michael Neuling <mikey@neuling.org>
In-Reply-To: <3992.1187938717@neuling.org>
References: <3992.1187938717@neuling.org>
Content-Type: text/plain
Date: Thu, 23 Aug 2007 15:36:20 -0500
Message-Id: <1187901380.4767.17.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-08-24 at 16:58 +1000, Michael Neuling wrote:
> After talking to an IBM POWER hypervisor design and development (PHYP)
> guy, there seems to be no need for memory barriers when updating the SLB
> shadow buffer provided we only update it from the current CPU, which we
> do.
> 
> Also, these guys see no need in the future for these barriers.

Does this result in a significant performance gain?  I'm just curious.

josh
