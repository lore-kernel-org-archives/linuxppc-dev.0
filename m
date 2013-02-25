Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 58B5C2C0292
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2013 08:47:19 +1100 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 26 Feb 2013 03:13:37 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 485C7E0055
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2013 03:18:16 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay01.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1PLl8w724576136
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2013 03:17:08 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1PLl9He009646
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2013 08:47:12 +1100
Message-ID: <512BDB61.1010204@linux.vnet.ibm.com>
Date: Tue, 26 Feb 2013 03:15:05 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v6 00/46] CPU hotplug: stop_machine()-free CPU hotplug
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
 <87mwuxfatp.fsf@rustcorp.com.au>
In-Reply-To: <87mwuxfatp.fsf@rustcorp.com.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-doc@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, walken@google.com, mingo@kernel.org,
 linux-arch@vger.kernel.org, linux@arm.linux.org.uk,
 xiaoguangrong@linux.vnet.ibm.com, wangyun@linux.vnet.ibm.com,
 paulmck@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 linux-pm@vger.kernel.org, rostedt@goodmis.org, rjw@sisk.pl,
 namhyung@kernel.org, tglx@linutronix.de, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, oleg@redhat.com, vincent.guittot@linaro.org,
 sbw@mit.edu, tj@kernel.org, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/22/2013 06:01 AM, Rusty Russell wrote:
> "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com> writes:
>> Hi,
>>
>> This patchset removes CPU hotplug's dependence on stop_machine() from the CPU
>> offline path and provides an alternative (set of APIs) to preempt_disable() to
>> prevent CPUs from going offline, which can be invoked from atomic context.
>> The motivation behind the removal of stop_machine() is to avoid its ill-effects
>> and thus improve the design of CPU hotplug. (More description regarding this
>> is available in the patches).
> 
> If you're doing a v7, please put your benchmark results somewhere!
> 

Oh, I forgot to put them in v6! Thanks for reminding :-)
And yes, I'll have to do a v7 to incorporate changes (if any) to the new code
that went in during this merge window.

> The obvious place is in the 44/46.
>

Ok, will add it there. Thank you!
 
Regards,
Srivatsa S. Bhat
