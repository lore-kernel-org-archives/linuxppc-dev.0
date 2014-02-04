Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 641ED2C009C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Feb 2014 04:18:29 +1100 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Tue, 4 Feb 2014 22:48:26 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id D67D0E0059
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Feb 2014 22:51:35 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s14HIOY055312534
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Feb 2014 22:48:24 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s14HIKNW007910
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 4 Feb 2014 22:48:23 +0530
Message-ID: <52F12008.4040103@linux.vnet.ibm.com>
Date: Tue, 04 Feb 2014 22:44:48 +0530
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [PATCH V2 1/2] time: Change the return type of
 clockevents_notify() to integer
References: <20140124065501.17564.39363.stgit@preeti.in.ibm.com>
 <20140124065739.17564.97259.stgit@preeti.in.ibm.com>
 <alpine.DEB.2.02.1402041100250.24986@ionos.tec.linutronix.de>
In-Reply-To: <alpine.DEB.2.02.1402041100250.24986@ionos.tec.linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: daniel.lezcano@linaro.org, peterz@infradead.org, fweisbec@gmail.com,
 agraf@suse.de, paul.gortmaker@windriver.com, paulus@samba.org,
 mingo@kernel.org, mikey@neuling.org, shangw@linux.vnet.ibm.com,
 rafael.j.wysocki@intel.com, paulmck@linux.vnet.ibm.com, arnd@arndb.de,
 linux-pm@vger.kernel.org, rostedt@goodmis.org, michael@ellerman.id.au,
 john.stultz@linaro.org, anton@samba.org, chenhui.zhao@freescale.com,
 deepthi@linux.vnet.ibm.com, r58472@freescale.com, geoff@infradead.org,
 linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com,
 schwidefsky@de.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/04/2014 03:31 PM, Thomas Gleixner wrote:
> On Fri, 24 Jan 2014, Preeti U Murthy wrote:
>> -extern void tick_broadcast_oneshot_control(unsigned long reason);
>> +extern int tick_broadcast_oneshot_control(unsigned long reason);
> 
>> -static inline void tick_broadcast_oneshot_control(unsigned long reason) { }
>> +static inline int tick_broadcast_oneshot_control(unsigned long reason) { }
> 
>> -static inline void tick_broadcast_oneshot_control(unsigned long reason) { }
>> +static inline int tick_broadcast_oneshot_control(unsigned long reason) { }
> 
> The inline stubs need to return 0.

Oh right! Apologies!
Thanks.
> 
> Thanks,
> 
> 	tglx
> 

Regards
Preeti U Murthy
