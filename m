Return-Path: <bsingharora@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.247])
	by ozlabs.org (Postfix) with ESMTP id 46E2FB7BAA
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 25 Sep 2009 17:20:47 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id b2so1126041ana.32
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 25 Sep 2009 00:20:45 -0700 (PDT)
MIME-Version: 1.0
Sender: bsingharora@gmail.com
In-Reply-To: <20090924142228.5a2ddf59@infradead.org>
References: <20090922112526.GA7788@linux.vnet.ibm.com>
	<20090924051238.GA5963@linux.vnet.ibm.com>
	<20090924142228.5a2ddf59@infradead.org>
Date: Fri, 25 Sep 2009 12:50:44 +0530
Message-ID: <661de9470909250020u711031djfbf30f41e06d60bf@mail.gmail.com>
Subject: Re: [v6 PATCH 0/7]: cpuidle/x86/POWER: Cleanup idle power management
	code in x86,
	cleanup drivers/cpuidle/cpuidle.c and introduce cpuidle to POWER.
From: Balbir Singh <balbir@in.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Shaohua Li <shaohua.li@intel.com>, Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Gautham R Shenoy <ego@in.ibm.com>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, arun@linux.vnet.ibm.com,
	Ingo Molnar <mingo@elte.hu>, linuxppc-dev@lists.ozlabs.org,
	Len Brown <lenb@kernel.org>
Reply-To: balbir@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 24, 2009 at 5:52 PM, Arjan van de Ven <arjan@infradead.org> wrote:
> On Thu, 24 Sep 2009 10:42:41 +0530
> Arun R Bharadwaj <arun@linux.vnet.ibm.com> wrote:
>
>> * Arun R Bharadwaj <arun@linux.vnet.ibm.com> [2009-09-22 16:55:27]:
>>
>> Hi Len, (or other acpi folks),
>>
>> I had a question regarding ACPI-cpuidle interaction in the current
>> implementation.
>>
>> Currently, every cpu (i.e. acpi_processor) registers to cpuidle as
>> a cpuidle_device. So every cpu has to go through the process of
>> setting up the idle states and then registering as a cpuidle device.
>>
>> What exactly is the reason behind this?
>>
>
> technically a BIOS can opt to give you C states via ACPI on some cpus,
> but not on others.
>
> in practice when this happens it tends to be a bug.. but it's
> technically a valid configuration

In this day and age of flashable BIOS with recovery BIOS built in,
can't we just print out a big far warning, asking users of such
systems to go back to their vendors and ask for updates or find the
updates and apply them? Does the OS have to do the heavy lifting and
allow users to live with buggy BIOS's.

When you say it is a technically valid configuration, you mean that
the ACPI spec allows for such inconsistency?

Balbir Singh
