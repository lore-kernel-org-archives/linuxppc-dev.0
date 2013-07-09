Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E1BA62C02FE
 for <linuxppc-dev@ozlabs.org>; Tue,  9 Jul 2013 17:56:37 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 9 Jul 2013 17:41:15 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 451853578051
 for <linuxppc-dev@ozlabs.org>; Tue,  9 Jul 2013 17:56:18 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r697u87S65667240
 for <linuxppc-dev@ozlabs.org>; Tue, 9 Jul 2013 17:56:08 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r697uGM5009456
 for <linuxppc-dev@ozlabs.org>; Tue, 9 Jul 2013 17:56:17 +1000
Message-ID: <51DBC1F2.6070506@linux.vnet.ibm.com>
Date: Tue, 09 Jul 2013 13:25:30 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] powerpc, perf: Add generic cache reference and cache
 miss events for POWER8 PMU
References: <51D11DEF.8070302@linux.vnet.ibm.com>
 <20130708082844.GA18271@concordia>
In-Reply-To: <20130708082844.GA18271@concordia>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <ellerman@au1.ibm.com>,
 Michael Neuling <michael.neuling@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> Hi Anshuman,
> 
> Which system did you test this on and what results did you see?
> 

Tested this on a power8 system.
