Return-Path: <khandual@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E267F2C00A6
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Dec 2013 15:31:16 +1100 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Fri, 13 Dec 2013 10:01:15 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 79114E0053
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Dec 2013 10:03:33 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rBD4V4MD37748912
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Dec 2013 10:01:04 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rBD4VAx6015882
 for <linuxppc-dev@ozlabs.org>; Fri, 13 Dec 2013 10:01:11 +0530
Message-ID: <52AA8D4C.6040905@linux.vnet.ibm.com>
Date: Fri, 13 Dec 2013 10:00:04 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 1/2] power7, perf: Make some new raw event codes available
 in sysfs
References: <1381902780-2719-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1381902780-2719-2-git-send-email-khandual@linux.vnet.ibm.com>
 <1386903031.3853.2.camel@concordia>
In-Reply-To: <1386903031.3853.2.camel@concordia>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org, sukadev@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 12/13/2013 08:20 AM, Michael Ellerman wrote:
> On Wed, 2013-10-16 at 11:22 +0530, Anshuman Khandual wrote:
>> This patch adds some more raw event codes into the existing list
>> of event codes present in power7-events-list.h file. This tries
>> to complete the list of events supported in Power7 and matches
>> the raw event list with libpfm4 library.
> 
> It's a bit annoying, but you also need to update the "ABI" document:

What is annoying ? you need to be specific.

> 
>   Documentation/ABI/testing/sysfs-bus-event_source-devices-events
> 

The events listed under the following heading are events required to do
CPI analysis.

"Description:    POWER-systems specific performance monitoring event"

		/sys/devices/cpu/events/PM_1PLUS_PPC_CMPL
                /sys/devices/cpu/events/PM_BRU_FIN
                /sys/devices/cpu/events/PM_BR_MPRED
                /sys/devices/cpu/events/PM_CMPLU_STALL
                /sys/devices/cpu/events/PM_CMPLU_STALL_BRU
                /sys/devices/cpu/events/PM_CMPLU_STALL_DCACHE_MISS
                /sys/devices/cpu/events/PM_CMPLU_STALL_DFU
                /sys/devices/cpu/events/PM_CMPLU_STALL_DIV
                /sys/devices/cpu/events/PM_CMPLU_STALL_ERAT_MISS
                /sys/devices/cpu/events/PM_CMPLU_STALL_FXU
                /sys/devices/cpu/events/PM_CMPLU_STALL_IFU
                /sys/devices/cpu/events/PM_CMPLU_STALL_LSU
                /sys/devices/cpu/events/PM_CMPLU_STALL_REJECT
                /sys/devices/cpu/events/PM_CMPLU_STALL_SCALAR
                /sys/devices/cpu/events/PM_CMPLU_STALL_SCALAR_LONG
                /sys/devices/cpu/events/PM_CMPLU_STALL_STORE
                /sys/devices/cpu/events/PM_CMPLU_STALL_THRD
                /sys/devices/cpu/events/PM_CMPLU_STALL_VECTOR
                /sys/devices/cpu/events/PM_CMPLU_STALL_VECTOR_LONG
                /sys/devices/cpu/events/PM_CYC
                /sys/devices/cpu/events/PM_GCT_NOSLOT_BR_MPRED
                /sys/devices/cpu/events/PM_GCT_NOSLOT_BR_MPRED_IC_MISS
                /sys/devices/cpu/events/PM_GCT_NOSLOT_CYC
                /sys/devices/cpu/events/PM_GCT_NOSLOT_IC_MISS
                /sys/devices/cpu/events/PM_GRP_CMPL
                /sys/devices/cpu/events/PM_INST_CMPL
                /sys/devices/cpu/events/PM_LD_MISS_L1
                /sys/devices/cpu/events/PM_LD_REF_L1
                /sys/devices/cpu/events/PM_RUN_CYC
                /sys/devices/cpu/events/PM_RUN_INST_CMPL


But I am not sure the events the current patch in context adds

+EVENT(PM_1THRD_CON_RUN_INSTR,                 0x30062)
+EVENT(PM_CMPLU_STALL_COUNT,                   0x4000B)
+EVENT(PM_MEM0_PB_RD_CL,                       0x30083)
+EVENT(PM_THRD_1_RUN_CYC,                      0x10060)
+EVENT(PM_THRD_2_CONC_RUN_INSTR,               0x40062)
+EVENT(PM_THRD_2_RUN_CYC,                      0x20060)
+EVENT(PM_THRD_3_CONC_RUN_INST,                0x10062)
+EVENT(PM_THRD_3_RUN_CYC,                      0x30060)
+EVENT(PM_THRD_4_CONC_RUN_INST,                0x20062)
+EVENT(PM_THRD_4_RUN_CYC,                      0x40060)

will be helpful in CPI stack analysis and should be part of the ABI
documentation file. If it does, I will be glad to add them.
