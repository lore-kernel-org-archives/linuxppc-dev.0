Return-Path: <srs0=sn4f=4q=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wNSYv55FpzDqLS
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 06:31:15 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wNSYv4K6mz8t94
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 May 2017 06:31:15 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wNSYv0MDHz9s7q
 for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2017 06:31:14 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4AKSoCT037077
 for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2017 16:31:12 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2ac8ne3aug-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Wed, 10 May 2017 16:31:12 -0400
Received: from localhost
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Thu, 11 May 2017 06:31:09 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v4AKUxcF65011884
 for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2017 06:31:07 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v4AKUSPA032608
 for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2017 06:30:28 +1000
Subject: Re: [PATCH v5 2/2] powerpc/fadump: update documentation about
 'fadump_append=' parameter
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
References: <149383572199.1694.10940679065871920087.stgit@hbathini.in.ibm.com>
 <149383576571.1694.13692135068122879322.stgit@hbathini.in.ibm.com>
 <20170510180132.1fa0c1ec@kitsune.suse.cz>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Thu, 11 May 2017 02:00:11 +0530
MIME-Version: 1.0
In-Reply-To: <20170510180132.1fa0c1ec@kitsune.suse.cz>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <e1485f4d-f346-fea6-ee2a-9c7a6b2f6587@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Michal,

On Wednesday 10 May 2017 09:31 PM, Michal Suchánek wrote:
> Hello,
>
> On Wed, 03 May 2017 23:52:52 +0530
> Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:
>
>> With the introduction of 'fadump_append=' parameter to pass additional
>> parameters to fadump (capture) kernel, update documentation about it.
>>
>> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
>> ---
>>
>> Changes from v4:
>> * Based on top of patchset that includes
>>    https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=akpm&id=05f383cdfba8793240e73f9a9fbff4e25d66003f
>>
>>
>>   Documentation/powerpc/firmware-assisted-dump.txt |   10 +++++++++-
>>   1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/powerpc/firmware-assisted-dump.txt
>> b/Documentation/powerpc/firmware-assisted-dump.txt index
>> 8394bc8..6327193 100644 ---
>> a/Documentation/powerpc/firmware-assisted-dump.txt +++
>> b/Documentation/powerpc/firmware-assisted-dump.txt @@ -162,7 +162,15
>> @@ How to enable firmware-assisted dump (fadump):
>>   1. Set config option CONFIG_FA_DUMP=y and build kernel.
>>   2. Boot into linux kernel with 'fadump=on' kernel cmdline option.
>> -3. Optionally, user can also set 'crashkernel=' kernel cmdline
>> +3. A user can pass additional command line parameters as a comma
>> +   separated list through 'fadump_append=' parameter, to be enforced
>> +   when fadump is active. For example, if parameters like nr_cpus=1,
>> +   numa=off & udev.children-max=2 are to be enforced when fadump is
>> +   active, 'fadump_append=nr_cpus=1,numa=off,udev.children-max=2'
>> +   can be passed in command line, which will be replaced with
>> +   "nr_cpus=1 numa=off udev.children-max=2" when fadump is active.
>> +   This helps in reducing memory consumption during dump capture.
>> +4. Optionally, user can also set 'crashkernel=' kernel cmdline
>>      to specify size of the memory to reserve for boot memory dump
>>      preservation.
>>   
>>
> Writing your own deficient parser for comma separated arguments when
> perfectly fine parser for space separated quoted arguments exists in
> the kernel and the bootloader does not seem like a good idea to me.


Couple of things that prompted me for v5 are:
   1. Using parse_early_options() limits the kind of parameters
      that can be passed to fadump capture kernel. Passing parameters
      like systemd.unit= & udev.childern.max= has no effect with v4. 
Updating
      boot_command_line parameter, when fadump is active, seems a better
      alternative.

   2. Passing space-separated quoted arguments is not working
      as intended with lilo. Updating bootloader with the below
      entry in /etc/lilo.conf file results in a missing append
      entry in /etc/yaboot.conf file.

        append = "quiet sysrq=1 insmod=sym53c8xx insmod=ipr 
crashkernel=512M-:256M fadump_append=\"nr_cpus=1 numa=off 
udev.children-max=2\""

Because lilo doesn't seem to handle quoted arguments as intended,
comma-separated list syntax was the obvious choice. Quoted arguments
for a comma-separated list sounds plausible though, provided the
bootloader can handle it. Will try and address that..


> I also do not see how this addresses
>
> On Wed, 26 Apr 2017 20:32:55 +1000
> Michael Ellerman <mpe@ellerman.id.au> wrote:
>
>> Hari Bathini <hbathini@linux.vnet.ibm.com> writes:
>>
>>> diff --git a/arch/powerpc/kernel/fadump.c
>>> b/arch/powerpc/kernel/fadump.c index 8ff0dd4..87edc7b 100644
>>> --- a/arch/powerpc/kernel/fadump.c
>>> +++ b/arch/powerpc/kernel/fadump.c
>>> @@ -338,6 +343,36 @@ unsigned long __init
>>> arch_reserved_kernel_pages(void) return memblock_reserved_size() /
>>> PAGE_SIZE; }
>>>   
>>> +static void __init parse_fadump_append_params(const char *p)
>>> +{
>>> +	static char fadump_cmdline[COMMAND_LINE_SIZE] __initdata;
>>> +	char *token;
>>> +
>>> +	strlcpy(fadump_cmdline, p, COMMAND_LINE_SIZE);
>>> +	token = strchr(fadump_cmdline, ',');
>>> +	while (token) {
>>> +		*token = ' ';
>>> +		token = strchr(token, ',');
>>> +	}
>>> +
>>> +	pr_info("enforcing additional parameters (%s) passed
>>> through "
>>> +		"'fadump_append=' parameter\n", fadump_cmdline);
>>> +	parse_early_options(fadump_cmdline);
>> Using parse_early_options() means it only works for parameters defined
>> with early_param() or __setup() doesn't it?
>>
>> That might be OK but at least you need to clearly document it.
> which was your gripe with v4 of the patchset. Unfortunately the flags
> in Documentation/kernel-parameters.txt do not include a flag that
> denotes parameters available with parse_early_options - unless it is
> the KNL flag and is quite bitrotten.
>
>

The addtional comments Michael was asking for was when fadump_append=
is limited to early parsing only. But with this approach, we don't
have such limitation. Though I do agree that there is always scope
to improve the documentation further..

Thanks
Hari
