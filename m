Return-Path: <srs0=iehn=4s=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wPQ9C20MyzDqc9
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 19:46:39 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wPQ9C1Lq3z8t1b
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 12 May 2017 19:46:39 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wPQ9B3vLNz9s4q
 for <linuxppc-dev@ozlabs.org>; Fri, 12 May 2017 19:46:38 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4C9j50A028603
 for <linuxppc-dev@ozlabs.org>; Fri, 12 May 2017 05:46:29 -0400
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2acx6c0srb-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Fri, 12 May 2017 05:46:29 -0400
Received: from localhost
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Fri, 12 May 2017 19:46:27 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4C9kGwO66322434
 for <linuxppc-dev@ozlabs.org>; Fri, 12 May 2017 19:46:24 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4C9joVE006665
 for <linuxppc-dev@ozlabs.org>; Fri, 12 May 2017 19:45:50 +1000
Subject: Re: [PATCH v5 2/2] powerpc/fadump: update documentation about
 'fadump_append=' parameter
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
References: <149383572199.1694.10940679065871920087.stgit@hbathini.in.ibm.com>
 <149383576571.1694.13692135068122879322.stgit@hbathini.in.ibm.com>
 <20170510180132.1fa0c1ec@kitsune.suse.cz>
 <e1485f4d-f346-fea6-ee2a-9c7a6b2f6587@linux.vnet.ibm.com>
 <20170511151637.19d4a23f@kitsune.suse.cz>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Fri, 12 May 2017 15:15:33 +0530
MIME-Version: 1.0
In-Reply-To: <20170511151637.19d4a23f@kitsune.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <b1c1c890-fac0-dede-4b80-0fc12f1e95e7@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Thursday 11 May 2017 06:46 PM, Michal Suchánek wrote:
> On Thu, 11 May 2017 02:00:11 +0530
> Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:
>
>> Hello Michal,
>>
>> On Wednesday 10 May 2017 09:31 PM, Michal Suchánek wrote:
>>> Hello,
>>>
>>> On Wed, 03 May 2017 23:52:52 +0530
>>> Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:
>>>   
>>>> With the introduction of 'fadump_append=' parameter to pass
>>>> additional parameters to fadump (capture) kernel, update
>>>> documentation about it.
>>>>
>>>> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
>>>> ---
>>>>
>>>> Changes from v4:
>>>> * Based on top of patchset that includes
>>>>     https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=akpm&id=05f383cdfba8793240e73f9a9fbff4e25d66003f
>>>>
>>>>
>>>>    Documentation/powerpc/firmware-assisted-dump.txt |   10
>>>> +++++++++- 1 file changed, 9 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/Documentation/powerpc/firmware-assisted-dump.txt
>>>> b/Documentation/powerpc/firmware-assisted-dump.txt index
>>>> 8394bc8..6327193 100644 ---
>>>> a/Documentation/powerpc/firmware-assisted-dump.txt +++
>>>> b/Documentation/powerpc/firmware-assisted-dump.txt @@ -162,7
>>>> +162,15 @@ How to enable firmware-assisted dump (fadump):
>>>>    1. Set config option CONFIG_FA_DUMP=y and build kernel.
>>>>    2. Boot into linux kernel with 'fadump=on' kernel cmdline option.
>>>> -3. Optionally, user can also set 'crashkernel=' kernel cmdline
>>>> +3. A user can pass additional command line parameters as a comma
>>>> +   separated list through 'fadump_append=' parameter, to be
>>>> enforced
>>>> +   when fadump is active. For example, if parameters like
>>>> nr_cpus=1,
>>>> +   numa=off & udev.children-max=2 are to be enforced when fadump
>>>> is
>>>> +   active, 'fadump_append=nr_cpus=1,numa=off,udev.children-max=2'
>>>> +   can be passed in command line, which will be replaced with
>>>> +   "nr_cpus=1 numa=off udev.children-max=2" when fadump is active.
>>>> +   This helps in reducing memory consumption during dump capture.
>>>> +4. Optionally, user can also set 'crashkernel=' kernel cmdline
>>>>       to specify size of the memory to reserve for boot memory dump
>>>>       preservation.
>>>>    
>>>>   
>>> Writing your own deficient parser for comma separated arguments when
>>> perfectly fine parser for space separated quoted arguments exists in
>>> the kernel and the bootloader does not seem like a good idea to
>>> me.
>>
>> Couple of things that prompted me for v5 are:
>>     1. Using parse_early_options() limits the kind of parameters
>>        that can be passed to fadump capture kernel. Passing parameters
>>        like systemd.unit= & udev.childern.max= has no effect with v4.
>> Updating
>>        boot_command_line parameter, when fadump is active, seems a
>> better alternative.
>>
>>     2. Passing space-separated quoted arguments is not working
>>        as intended with lilo. Updating bootloader with the below
>>        entry in /etc/lilo.conf file results in a missing append
>>        entry in /etc/yaboot.conf file.
>>
>>          append = "quiet sysrq=1 insmod=sym53c8xx insmod=ipr
>> crashkernel=512M-:256M fadump_append=\"nr_cpus=1 numa=off
>> udev.children-max=2\""
> Meaning that a script that emulates LILO semantics on top of yaboot
> which is completely capable of passing qouted space separated arguments
> fails. IMHO it is more reasonable to fix the script or whatever
> adaptation layer or use yaboot directly than working around bug in said
> script by introducing a new argument parser in the kernel.
>
>

Hmmm.. while trying to implement space-separated parameter list with quotes
as syntax for fadump_append parameter, noticed that it can make 
implemenation
more vulnerable. Here are some problems I am facing while implementing 
this..

As the boot_command_line needs to be updated before parse_early_param,
we still need some kind of parser. Now this parser has to look for quotes.
But grub2 is updating fadump_append=\"nr_cpus=1 numa=off\" in
/etc/default/grub to "fadump_append=nr_cpus=1 numa=off" cmdline.
This may make parsing complicated in cases where only a single parameter
is passed without quotes like fadump_append=nr_cpus=1. It can get more
complicated, if there is some other parameter after fadump_append with
quotes like below:

  fadump_append=nr_cpus=1 paramx paramy "another_param=something with 
spaces"

Can't say the same about a comma-separated parameter list. Though I won't
dare say it is the best way but maybe the lesser of two evils..

Thanks
Hari
