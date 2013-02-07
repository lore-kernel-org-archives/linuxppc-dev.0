Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EAE322C02CA
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2013 17:13:47 +1100 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Thu, 7 Feb 2013 11:41:19 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id D268E125804E
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  7 Feb 2013 11:44:05 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r176DQtn27394142
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Feb 2013 11:43:27 +0530
Received: from d28av04.in.ibm.com (loopback [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r176DQgg003051
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 7 Feb 2013 17:13:28 +1100
Message-ID: <51134596.4080106@linux.vnet.ibm.com>
Date: Thu, 07 Feb 2013 11:41:34 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v5 00/45] CPU hotplug: stop_machine()-free CPU hotplug
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <510FBC01.2030405@linux.vnet.ibm.com> <87haloiwv0.fsf@rustcorp.com.au>
In-Reply-To: <87haloiwv0.fsf@rustcorp.com.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-doc@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, walken@google.com, mingo@kernel.org,
 linux-arch@vger.kernel.org, linux@arm.linux.org.uk,
 xiaoguangrong@linux.vnet.ibm.com, wangyun@linux.vnet.ibm.com,
 paulmck@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 linux-pm@vger.kernel.org, rostedt@goodmis.org, rjw@sisk.pl,
 namhyung@kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, oleg@redhat.com, sbw@mit.edu, tj@kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/07/2013 09:44 AM, Rusty Russell wrote:
> "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com> writes:
>> On 01/22/2013 01:03 PM, Srivatsa S. Bhat wrote:
>>                  Avg. latency of 1 CPU offline (ms) [stop-cpu/stop-m/c latency]
>>
>> # online CPUs    Mainline (with stop-m/c)       This patchset (no stop-m/c)
>>
>>       8                 17.04                          7.73
>>
>>      16                 18.05                          6.44
>>
>>      32                 17.31                          7.39
>>
>>      64                 32.40                          9.28
>>
>>     128                 98.23                          7.35
> 
> Nice!

Thank you :-)

>  I wonder how the ARM guys feel with their quad-cpu systems...
> 

That would be definitely interesting to know :-)

Regards,
Srivatsa S. Bhat
