Return-Path: <srs0=usuu=6o=linux.vnet.ibm.com=hbathini@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6W182SwPzDqb5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 04:33:16 +1000 (AEST)
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3x6W1815BGz8sfw
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 04:33:16 +1000 (AEST)
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3x6W174LFdz9s03
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Jul 2017 04:33:15 +1000 (AEST)
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6BITCO3078444
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Jul 2017 14:33:13 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bn0mw1t9k-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Tue, 11 Jul 2017 14:33:13 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <hbathini@linux.vnet.ibm.com>;
 Wed, 12 Jul 2017 04:33:11 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6BIVjTS17629220
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Jul 2017 04:31:53 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6BIVKds032476
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Jul 2017 04:31:21 +1000
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
 <a3ac4a10-3315-187b-e29a-01637ba19dff@linux.vnet.ibm.com>
 <20170626141501.6086b6ab@kitsune.suse.cz>
From: Hari Bathini <hbathini@linux.vnet.ibm.com>
Date: Wed, 12 Jul 2017 00:00:57 +0530
MIME-Version: 1.0
In-Reply-To: <20170626141501.6086b6ab@kitsune.suse.cz>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <dc6ce480-52e0-1cf9-a2ce-252fdf24f79a@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michal,


Thanks for the review..


On Monday 26 June 2017 05:45 PM, Michal Suchánek wrote:
> Hello,
>
> On Tue, 20 Jun 2017 21:14:08 +0530
> Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:
>
>> On Friday 09 June 2017 05:34 PM, Michal Suchánek wrote:
>>> On Thu, 8 Jun 2017 23:30:37 +0530
>>> Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:
>>>> On Monday 15 May 2017 02:59 PM, Michal Suchánek wrote:
>>>>> On Mon, 15 May 2017 12:59:46 +0530
>>>>> Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:
>>>>>> On Friday 12 May 2017 09:12 PM, Michal Suchánek wrote:
>>>>>>> On Fri, 12 May 2017 15:15:33 +0530
>>>>>>> Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:
>>>>>>>> On Thursday 11 May 2017 06:46 PM, Michal Suchánek wrote:
>>>>>>>>> On Thu, 11 May 2017 02:00:11 +0530
>>>>>>>>> Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:
>>>>>>>>>> On Wednesday 10 May 2017 09:31 PM, Michal Suchánek wrote:
>>>>>>>>>>> On Wed, 03 May 2017 23:52:52 +0530
>>>>>>>>>>> Hari Bathini <hbathini@linux.vnet.ibm.com> wrote:
>>>>>>>>>>>               
>>>>>>>>>>>> With the introduction of 'fadump_append=' parameter to pass
>>>>>>>>>>>> additional parameters to fadump (capture) kernel, update
>>>>>>>>>>>> documentation about it.
>>>>>>>>>>>>
>>>>>>>>>>>> Signed-off-by: Hari Bathini <hbathini@linux.vnet.ibm.com>
>>>>>>>>>>>> ---
>>>>>>>>>>>>        
>>>>>>>>>>>>               
>>>>>>>>>>> Writing your own deficient parser for comma separated
>>>>>>>>>>> arguments when perfectly fine parser for space separated
>>>>>>>>>>> quoted arguments exists in the kernel and the bootloader
>>>>>>>>>>> does not seem like a good idea to me.
>>>>>>>>>> Couple of things that prompted me for v5 are:
>>>>>>>>>>         1. Using parse_early_options() limits the kind of
>>>>>>>>>> parameters that can be passed to fadump capture kernel.
>>>>>>>>>> Passing parameters like systemd.unit= & udev.childern.max=
>>>>>>>>>> has no effect with v4. Updating
>>>>>>>>>>            boot_command_line parameter, when fadump is active,
>>>>>>>>>> seems a better alternative.
>>>>>>>>>>
>>>>>>>>>>         2. Passing space-separated quoted arguments is not
>>>>>>>>>> working as intended with lilo. Updating bootloader with the
>>>>>>>>>> below entry in /etc/lilo.conf file results in a missing
>>>>>>>>>> append entry in /etc/yaboot.conf file.
>>>>>>>>>>
>>>>>>>>>>              append = "quiet sysrq=1 insmod=sym53c8xx
>>>>>>>>>> insmod=ipr crashkernel=512M-:256M fadump_append=\"nr_cpus=1
>>>>>>>>>> numa=off udev.children-max=2\""
>>>>>>>>> Meaning that a script that emulates LILO semantics on top of
>>>>>>>>> yaboot which is completely capable of passing qouted space
>>>>>>>>> separated arguments fails. IMHO it is more reasonable to fix
>>>>>>>>> the script or whatever adaptation layer or use yaboot
>>>>>>>>> directly than working around bug in said script by
>>>>>>>>> introducing a new argument parser in the kernel.
>>>>>>>>>
>>>>>>>>>            
>>>> The intention with this patch is to replace
>>>>
>>>>      "root=/dev/sda2 ro fadump_append=nr_cpus=1,numa=off
>>>> crashkernel=1024M"
>>>>
>>>> with
>>>>
>>>>      "root=/dev/sda2 ro nr_cpus=1 numa=off crashkernel=1024M"
>>>>
>>>> when kernel is booting for dump capture.
>>>> While parse_args() is making parsing relatively easy, the main
>>>> idea is to replace parameters as above when fadump capture kernel
>>>> is booting. The code is relatively complicated to replace
>>>> parameters using space-separated
>>>> quoted string even though parse_args() may parse them easily.
>>>> Comma-separated
>>>> list was easier to implement and seemed less error prone for
>>>> replacing parameters.
>>> You can still do that relatively easily. parse_args() gives you the
>>> content of fadump_capture argument. You should probably add a
>>> variant that gives you also the position of the fadump_capture
>>> argument in case user specified it multiple times - picking the
>>> wrong one would cause errors.
>> There is no denying that this can be done with the use of
>> parse_args() function.
>> But my contention is a custom parser is no more error prone,
>> considering it only has to search/replace commas in
>> fadump_extra_args= till the first occurrence of space/nul, without
>> having to deal with the naunces of parse_args() function.
> If you do that you
>
> 1) introduce new parser which is error-prone even for not very complex
> parsers
>
> 2) does not handle quoting properly meaning that
>   a) the passed arguments cannot include a comma (which is the case for
>   many existing kernel parameters)
>   b) your parser, parse_args and any parser analyzing the commandline
>   before you replace the arguments do not agree on the content and
>   length of the fadump_extra_args argument
>
> 3) you introduce completely new syntax for arguments which the user
>   has to research and understand for no good reason
>> Also, to
>> get the last occurence, could use something like
>> get_last_crashkernel() instead of adding a variant to parse_args().
> Why are you talking about last occurence all the time? Does that mean
> that if user specifies fadump_extra_args in both the 'default' and
> 'extra' kernel arguments to the grub configuration script only the one
> from 'extra' arguments will be expanded and  the on from 'default'
> arguments will be just left there? Why?
>
>>> Then you can just replace the fadump_append="appended arguments"
>>> with the dequoted "appended arguments" parse_args() gives you.
>>> Dequating should shorten the arguments as would removing the
>>> fadump_append= prefix so it should be quite possible in-place. It
>>> is in fact even easier than the comma separated list since you do
>>> not need to do any parsing yourself - only strlen, memset and
>>> memcpy.
>>>
>>> That said, if you replace the fadump_append argument the running
>>> kernel will have extra arguments without knowing where they came
>>> from making detection of this happening all the more difficult.
>> How about replacing "fadump_extra_args=x,y,z" with "fadump_extra_args
>> x y z"?
> How does this handle x that includes a comma?
>
> How does this handle x that includes a space?
>
> How does it handle x that includes a double quote? - Well, presumably
> it will just stay there with the fadump_extra_args expanded or not and
> will cause equal breakage.
>
>> Presence of fadump_extra_args hints the user about the extra
>> parameters passed
>> to fadump capture kernel and also lets parsing/replacing be simple -
>> replace the first '=' and subsequent commas with ' ' in this
>> fadump_extra_args= parameter
>> and we are good to go. No additional handling. Even if we go with
>> space-separated
>> quoted string, simply replacing "fadump_extra_args=" with
>> "fadump_extra_args"
> Leaving the empty fadump_extra_args argument might be good for
> indication that the replacement possibly took place and comes for free.
>
>> should suffice, no need to worry about parse_args as well.
> If you use parse_args it can give you the content of the every
> fadump_extra_args argument and dequotes it for you. So in the case
> fadump_extra_args does include double quotes you get them handled
> correctly for you by existing parser.
>
> And you want to make a variant of parse_args that tells you where the
> argument starts and ends in the parsed commandline so you know which
> part you should replace - which it certainly does know but no current
> users need the information so it does not tell you.
>
> When you do that users can read (or for the most part have already
> read) about the kernel argument syntax and apply that to
> fadump_extra_args. No additional specification and exceptions are
> needed.
>
>> I prefer
>> comma-separated
>> list though, for it leaves no dependency on how bootloader handles
>> space-separated
>> quoted strings, considering my encounter with yast bootloader which
>> is not so
>> impressive in handling quoted strings. Also, the code change is not
>> so complicated.
> If yast cannot handle kernel parameters correctly report a bug. The
> quoting of arguments with spaces is part of the kernel parameter
> specification so yast should handle it.
>
>>
>>>> Want to replace fadump_append=, to avoid command line overflow
>>>> issues and also to not have to deal with special cases like --.
>>>> Actually, fadump_append=
>>>> seems to be confusing in that sense. How about
>>>> fadump_args=comma-separated-list-
>>>> of-params-for-capture-kernel ? Please share your thoughts.
>>> The comma separated list still can contain a -- argument so you
>>> still have to do something about that. Or not and just document
>>> that people should not use it.
>> The user has the flexibility to use fadump_extra_args= to pass
>> special parameters
>> keeping in mind that "fadump_extra_args=x,y,z" will be replaced
>> in-place with
>> "fadump_extra_args x y z" and it happens only in fadump capture
>> kernel. No additional
>> code changes needed to handle this except for documentation talking
>> about it?
> Presumably if y is "--" then z and any subsequent kernel arguments after
> fadump_extra_args are passed to init when fadump_extra_args is
> expanded and not so when left as is. This may be unexpected - the user
> may expect that if fadump_extra_args contains a "--" as y then z is
> appended after existing "--" in commandline or if none is present the
> whole "-- z" is moved to the end. This would be clean way of handling
> the extra arguments - no text only preprocessing allowing for dirty
> tricks moving arguments from kernel to init by in-place text
> replacement. Note that any unclosed quoting in arguments after
> fadump_extra_args may make appending "-- z" quite difficult if you
> wanted to do it correctly. If you do not want to bother (with either)
> it is an understandable shortcoming in the implementation and should be
> documented.
>

I would prefer documenting over a complex implementation. Actually, I
am considering a simple approach of replacing every occurrence of
"fadump_extra_args=" with "fadump_extra_args " in fadump capture
kernel. The cmdline

   "root=/dev/sda2 ro fadump_extra_args="a b c" crashkernel=512M 
fadump_extra_args=d"

becomes

   "root=/dev/sda2 ro fadump_extra_args "a b c" crashkernel=512M 
fadump_extra_args d"

in fadump capture kernel. This must take care of the pitfalls with the 
current approach and also,
doesn't rely on parse_args() which was not designed for this scenario to 
start with..?

Will report a bug for yast handling of kernel parameters with quotes.

Thanks
Hari
