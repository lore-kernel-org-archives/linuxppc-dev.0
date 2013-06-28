Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 773AE2C0374
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Jun 2013 15:11:00 +1000 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 28 Jun 2013 14:56:20 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 68ECE2BB0052
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Jun 2013 15:10:55 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5S4tq1t65667174
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Jun 2013 14:55:53 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5S5ArMi008715
 for <linuxppc-dev@ozlabs.org>; Fri, 28 Jun 2013 15:10:54 +1000
Message-ID: <51CD1AB6.5050001@linux.vnet.ibm.com>
Date: Fri, 28 Jun 2013 10:40:14 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 5/8] powerpc/perf: Don't enable if we have zero events
References: <1372073336-8189-1-git-send-email-michael@ellerman.id.au>
 <1372073336-8189-5-git-send-email-michael@ellerman.id.au>
In-Reply-To: <1372073336-8189-5-git-send-email-michael@ellerman.id.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, sukadev@linux.vnet.ibm.com,
 Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/24/2013 04:58 PM, Michael Ellerman wrote:
> In power_pmu_enable() we still enable the PMU even if we have zero
> events. This should have no effect but doesn't make much sense. Instead
> just return after telling the hypervisor that we are not using the PMCs.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Reviewed-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
