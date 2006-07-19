Return-Path: <mkravetz@us.ibm.com>
Received: from over.co.us.ibm.com (over.co.us.ibm.com [32.97.110.157])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "over.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id BB98067B6F
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jul 2006 16:27:24 +1000 (EST)
Received: from e4.ny.us.ibm.com (e4.pok.ibm.com [9.56.232.144])
	by bldfb.esmtp.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6J3oS6T028872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK)
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jul 2006 23:50:29 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k6J3oOPh014669
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jul 2006 23:50:24 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k6J3oNJo228358
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jul 2006 23:50:24 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k6J3oN7k030606
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Jul 2006 23:50:23 -0400
Date: Tue, 18 Jul 2006 20:50:41 -0700
From: Mike Kravetz <kravetz@us.ibm.com>
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 2/3] powerpc: Instrument Hypervisor Calls: add wrappers
Message-ID: <20060719035040.GB3944@monkey.ibm.com>
References: <20060718204723.GA6104@w-mikek2.ibm.com>
	<20060718204946.GC6104@w-mikek2.ibm.com>
	<20060718223425.GB5238@pb15.lixom.net>
	<20060718231815.GC3091@w-mikek2.ibm.com>
	<20060719033300.GA9451@pb15.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060719033300.GA9451@pb15.lixom.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 18, 2006 at 10:33:00PM -0500, Olof Johansson wrote:
> If you use the FTR_SECTION stuff then it'll be taken care of
> automatically at boot time. Doing that from C is messy, I don't think
> anyone has had reason to do it before.

Ok, sounds like a good reason for assembly.  I'll dust off the books. :)

-- 
Mike
