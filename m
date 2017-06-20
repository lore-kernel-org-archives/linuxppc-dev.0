Return-Path: <srs0=5xdf=5z=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wsXGt4jvzzDqhk
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 01:45:10 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3wsXGt45Mgz8vTm
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Jun 2017 01:45:10 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3wsXGt1K1Cz9s0Z
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Jun 2017 01:45:10 +1000 (AEST)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v5KFi7St046958
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2017 11:45:08 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2b6ykxdf0m-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 20 Jun 2017 11:45:07 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 21 Jun 2017 01:45:01 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v5KFip8V19660976
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Jun 2017 01:44:59 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v5KFiRaP023808
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Jun 2017 01:44:27 +1000
Subject: Re: [PATCH v5 2/2] powerpc/fadump: update documentation about
 'fadump_append=' parameter
To: =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>
Cc: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>
References: <149383572199.1694.10940679065871920087.stgit@hbathini.in.ibm.com>
 <149383576571.1694.13692135068122879322.stgit@hbathini.in.ibm.com>
 <20170510180132.1fa0c1ec@kitsune.suse.cz>
 <e1485f4d-f346-fea6-ee2a-9c7a6b2f6587@linux.vnet.ibm.com>
 <20170511151637.19d4a23f@kitsune.suse.cz>
 <b1c1c890-fac0-dede-4b80-0fc12f1e95e7@linux.vnet.ibm.com>
 <20170512174209.67ccfd45@kitsune.suse.cz>
 <b6a968fe-378e-1273-a996-43c716f276bd@linux.vnet.ibm.com>
 <20170515112901.67d32e76@kitsune.suse.cz>
 <102276aa-cddb-dc60-269c-b29dedc89eab@linux.vnet.ibm.com>
 <20170609140454.2eb01371@kitsune.suse.cz>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Tue, 20 Jun 2017 21:14:08 +0530
MIME-Version: 1.0
In-Reply-To: <20170609140454.2eb01371@kitsune.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <a3ac4a10-3315-187b-e29a-01637ba19dff@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Friday 09 June 2017 05:34 PM, Michal Suchánek wrote:
> On Thu, 8 Jun 2017 23:30:37 +0530
> Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:
>
>> Hi Michal,
>>
>> Sorry for taking this long to respond. I was working on a few other
>> things.
>>
>> On Monday 15 May 2017 02:59 PM, Michal Suchánek wrote:
>>> Hello,
>>>
>>> On Mon, 15 May 2017 12:59:46 +0530
>>> Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:
>>>   
>>>> On Friday 12 May 2017 09:12 PM, Michal Suchánek wrote:
>>>>> On Fri, 12 May 2017 15:15:33 +0530
>>>>> Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:
>>>>>      
>>>>>> On Thursday 11 May 2017 06:46 PM, Michal Suchánek wrote:
>>>>>>> On Thu, 11 May 2017 02:00:11 +0530
>>>>>>> Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:
>>>>>>>         
>>>>>>>> Hello Michal,
>>>>>>>>
>>>>>>>> On Wednesday 10 May 2017 09:31 PM, Michal Suchánek wrote:
>>>>>>>>> Hello,
>>>>>>>>>
>>>>>>>>> On Wed, 03 May 2017 23:52:52 +0530
>>>>>>>>> Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:
>>>>>>>>>            
>>>>>>>>>> With the introduction of 'fadump_append=' parameter to pass
>>>>>>>>>> additional parameters to fadump (capture) kernel, update
>>>>>>>>>> documentation about it.
>>>>>>>>>>
>>>>>>>>>> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
>>>>>>>>>> ---
>>>>>>>>>>
>>>>>>>>>> Changes from v4:
>>>>>>>>>> * Based on top of patchset that includes
>>>>>>>>>>        https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=akpm&id=05f383cdfba8793240e73f9a9fbff4e25d66003f
>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>>       Documentation/powerpc/firmware-assisted-dump.txt |   10
>>>>>>>>>> +++++++++- 1 file changed, 9 insertions(+), 1 deletion(-)
>>>>>>>>>>
>>>>>>>>>> diff --git a/Documentation/powerpc/firmware-assisted-dump.txt
>>>>>>>>>> b/Documentation/powerpc/firmware-assisted-dump.txt index
>>>>>>>>>> 8394bc8..6327193 100644 ---
>>>>>>>>>> a/Documentation/powerpc/firmware-assisted-dump.txt +++
>>>>>>>>>> b/Documentation/powerpc/firmware-assisted-dump.txt @@ -162,7
>>>>>>>>>> +162,15 @@ How to enable firmware-assisted dump (fadump):
>>>>>>>>>>       1. Set config option CONFIG_FA_DUMP=y and build kernel.
>>>>>>>>>>       2. Boot into linux kernel with 'fadump=on' kernel
>>>>>>>>>> cmdline option. -3. Optionally, user can also set
>>>>>>>>>> 'crashkernel=' kernel cmdline +3. A user can pass additional
>>>>>>>>>> command line parameters as a comma
>>>>>>>>>> +   separated list through 'fadump_append=' parameter, to be
>>>>>>>>>> enforced
>>>>>>>>>> +   when fadump is active. For example, if parameters like
>>>>>>>>>> nr_cpus=1,
>>>>>>>>>> +   numa=off & udev.children-max=2 are to be enforced when
>>>>>>>>>> fadump is
>>>>>>>>>> +   active,
>>>>>>>>>> 'fadump_append=nr_cpus=1,numa=off,udev.children-max=2'
>>>>>>>>>> +   can be passed in command line, which will be replaced
>>>>>>>>>> with
>>>>>>>>>> +   "nr_cpus=1 numa=off udev.children-max=2" when fadump is
>>>>>>>>>> active.
>>>>>>>>>> +   This helps in reducing memory consumption during dump
>>>>>>>>>> capture. +4. Optionally, user can also set 'crashkernel='
>>>>>>>>>> kernel cmdline to specify size of the memory to reserve for
>>>>>>>>>> boot memory dump preservation.
>>>>>>>>>>       
>>>>>>>>>>            
>>>>>>>>> Writing your own deficient parser for comma separated
>>>>>>>>> arguments when perfectly fine parser for space separated
>>>>>>>>> quoted arguments exists in the kernel and the bootloader does
>>>>>>>>> not seem like a good idea to me.
>>>>>>>> Couple of things that prompted me for v5 are:
>>>>>>>>        1. Using parse_early_options() limits the kind of
>>>>>>>> parameters that can be passed to fadump capture kernel. Passing
>>>>>>>> parameters like systemd.unit= & udev.childern.max= has no
>>>>>>>> effect with v4. Updating
>>>>>>>>           boot_command_line parameter, when fadump is active,
>>>>>>>> seems a better alternative.
>>>>>>>>
>>>>>>>>        2. Passing space-separated quoted arguments is not
>>>>>>>> working as intended with lilo. Updating bootloader with the
>>>>>>>> below entry in /etc/lilo.conf file results in a missing append
>>>>>>>>           entry in /etc/yaboot.conf file.
>>>>>>>>
>>>>>>>>             append = "quiet sysrq=1 insmod=sym53c8xx insmod=ipr
>>>>>>>> crashkernel=512M-:256M fadump_append=\"nr_cpus=1 numa=off
>>>>>>>> udev.children-max=2\""
>>>>>>> Meaning that a script that emulates LILO semantics on top of
>>>>>>> yaboot which is completely capable of passing qouted space
>>>>>>> separated arguments fails. IMHO it is more reasonable to fix the
>>>>>>> script or whatever adaptation layer or use yaboot directly than
>>>>>>> working around bug in said script by introducing a new argument
>>>>>>> parser in the kernel.
>>>>>>>
>>>>>>>         
>>>>>> Hmmm.. while trying to implement space-separated parameter list
>>>>>> with quotes as syntax for fadump_append parameter, noticed that
>>>>>> it can make implemenation
>>>>>> more vulnerable. Here are some problems I am facing while
>>>>>> implementing this..
>>>>> How so?
>>>>>
>>>>> presumably you can reuse parse_args even if you do not register
>>>>> with early_param and call it yourself. Then your parsing of
>>>>> fadump_append is
>>>> I wasn't aware of that. Thanks for pointing it out, Michal.
>>>> Will try to use parse_args and get back.
>>>>   
>>> I was thinking a bit more about the uses of the commandline and how
>>> fadump_append potentially breaks it.
>>>
>>> The first thing that should be addressed and is the special --
>>> argument which denotes the start of init arguments that are not to
>>> be parsed by the kernel. Incidentally the initial implementation
>>> using early_param happened to handles that without issue.
>>> parse_args surely handles that so adding a hook somewhere should
>>> give you location of that argument (if any). And interesting thing
>>> that can happen is passing an -- inside the fadump_append argument.
>>> It should be handled (or not) in some way or other and the handling
>>> documented.
>>
>> The intention with this patch is to replace
>>
>>     "root=/dev/sda2 ro fadump_append=nr_cpus=1,numa=off
>> crashkernel=1024M"
>>
>> with
>>
>>     "root=/dev/sda2 ro nr_cpus=1 numa=off crashkernel=1024M"
>>
>> when kernel is booting for dump capture.
>> While parse_args() is making parsing relatively easy, the main idea is
>> to replace parameters as above when fadump capture kernel is booting.
>> The code is relatively complicated to replace parameters using
>> space-separated
>> quoted string even though parse_args() may parse them easily.
>> Comma-separated
>> list was easier to implement and seemed less error prone for
>> replacing parameters.
>
> You can still do that relatively easily. parse_args() gives you the
> content of fadump_capture argument. You should probably add a variant
> that gives you also the position of the fadump_capture argument in case
> user specified it multiple times - picking the wrong one would cause
> errors.

There is no denying that this can be done with the use of parse_args() 
function.
But my contention is a custom parser is no more error prone, considering it
only has to search/replace commas in fadump_extra_args= till the first
occurrence of space/nul, without having to deal with the naunces of
parse_args() function. Also, to get the last occurence, could use something
like get_last_crashkernel() instead of adding a variant to parse_args().

> Then you can just replace the fadump_append="appended arguments" with
> the dequoted "appended arguments" parse_args() gives you. Dequating
> should shorten the arguments as would removing the fadump_append=
> prefix so it should be quite possible in-place. It is in fact even
> easier than the comma separated list since you do not need to do any
> parsing yourself - only strlen, memset and memcpy.
>
> That said, if you replace the fadump_append argument the running kernel
> will have extra arguments without knowing where they came from making
> detection of this happening all the more difficult.

How about replacing "fadump_extra_args=x,y,z" with "fadump_extra_args x 
y z"?
Presence of fadump_extra_args hints the user about the extra parameters 
passed
to fadump capture kernel and also lets parsing/replacing be simple - replace
the first '=' and subsequent commas with ' ' in this fadump_extra_args= 
parameter
and we are good to go. No additional handling. Even if we go with 
space-separated
quoted string, simply replacing "fadump_extra_args=" with 
"fadump_extra_args "
should suffice, no need to worry about parse_args as well. I prefer 
comma-separated
list though, for it leaves no dependency on how bootloader handles 
space-separated
quoted strings, considering my encounter with yast bootloader which is 
not so
impressive in handling quoted strings. Also, the code change is not so 
complicated.


>> Want to replace fadump_append=, to avoid command line overflow issues
>> and also to not have to deal with special cases like --. Actually,
>> fadump_append=
>> seems to be confusing in that sense. How about
>> fadump_args=comma-separated-list-
>> of-params-for-capture-kernel ? Please share your thoughts.
> The comma separated list still can contain a -- argument so you still
> have to do something about that. Or not and just document that people
> should not use it.

The user has the flexibility to use fadump_extra_args= to pass special 
parameters
keeping in mind that "fadump_extra_args=x,y,z" will be replaced in-place 
with
"fadump_extra_args x y z" and it happens only in fadump capture kernel. 
No additional
code changes needed to handle this except for documentation talking 
about it?

> As for the parameter name fadump_args or fadump_extra_args is more
> generic than fadump_append giving you more room for changing the
> implementation details without making the argument name non-sensical.
>
>>
>>> The second thing that breaks is reusing content of /proc/cmdline in
>>> kexec calls for passing arguments to the loaded kernel. It works
>>> flawlessly passing the same arguments the currently running kernel
>>> was started with unless fadump_append argument handler appends
>>> content of the fadump_append argument to actual commandline that
>>> appears there. So this would be an argument against modifying the
>>> commandline. You could argue using fadump and kexec together is an
>>> exotic use case but I would expect that the very machines that
>>> require fadump_append to reduce dump memory requirement benefit
>>> from using kexec for reboots because the BIOS probing the hardware
>>> takes quite a while as well. If rewriting the commandline is
>>> desired then this side effect of recursively adding the content of
>>> fadump_append on kexecs which reuse /proc/cmdline should be
>>> documented.
>>>
>>>   
>> fadump capture kernel (the kernel where we expand
>> "fadump_append=x,y,z" to "x y z") only advised to be used for saving
>> dump (just like kdump kernel).
>> We are expected to boot into production kernel immediately after
>> saving dump.
> Which you can do for example using kexec.
>
>> Only in special cases where a user configures to stay in fadump
>> capture kernel
>> will he encounter the above problem. And someone choosing such
>> scenario is most
>> likely aware of what to make of /proc/cmdline?
> Why? They leave that to the initscripts and since you just changed the
> semantics of the kernel parameters significantly those can produce
> entertaining results.
>
>

Yeah. That is tricky but we are talking about a capture kernel here 
which should
typically reboot after dump capture (just like kdump kernel does). So, 
the case
you are mentioning about can be considered an exception a script should 
be able
to tackle?


Thanks
Hari
