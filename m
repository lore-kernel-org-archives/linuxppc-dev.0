Return-Path: <michael@evidence.eu.com>
Received: from sssup.it (ms01.sssup.it [193.205.80.99])
	by ozlabs.org (Postfix) with ESMTP id 43BD7B6F07
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Jan 2011 06:13:35 +1100 (EST)
Message-ID: <4D24C2D8.80708@evidence.eu.com>
Date: Wed, 05 Jan 2011 20:13:28 +0100
From: michael <michael@evidence.eu.com>
MIME-Version: 1.0
To: Rafael Beims <rbeims@gmail.com>
Subject: Re: mpc880 linux-2.6.32 slow running processes
References: <AANLkTin5XTnDEu1BJUOeF0UWtfEpotW5Bq__i8g6U05h@mail.gmail.com>	<4D24B725.2020300@evidence.eu.com>
	<AANLkTi=uvunJ-ZFVGHZZExgBaNL9Sh0uZ3OiiCrcPnx=@mail.gmail.com>
In-Reply-To: <AANLkTi=uvunJ-ZFVGHZZExgBaNL9Sh0uZ3OiiCrcPnx=@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: LinuxPPC-Dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi

On 01/05/2011 07:43 PM, Rafael Beims wrote:
> Wow! That was fast!
> I applied the patch and it worked very well. Now I can use the commands
> normally.
> I will be doing more tests in the next days, but it seems that my problem is
> solved.
>
> Is this patch already mainstream in newer kernel versions?
>
Not yet, because I was moved to another project

Michael Trimarchi
> Thanks again,
> Rafael Beims
> rbeims@gmail.com
> (41) 8873-7565
> "What I hear, I forget. What I see, I remember. And what I do, I
> understand."
> - Chinese Proverb
>
>
> On Wed, Jan 5, 2011 at 4:23 PM, michael<michael@evidence.eu.com>  wrote:
>
>>   Hi
>>
>> On 01/05/2011 07:09 PM, Rafael Beims wrote:
>>
>> Hello all,
>> I'm working with an MPC880 board that is supposed to run linux-2.6.32. After
>> some work, I could get the kernel up and running, mounting a rootfs via
>> NFS.
>> The problem that I'm facing now is that when I try to run any process (may
>> be an ls, cat, or whatever), the response of the process is *very* slow
>> (something like 10 to 20 seconds for a ls).
>> Monitoring the network packets, I can see that the nfs protocol is exchanged
>> just fine, but at some time it simply stops, starting again with a request
>> from the board several seconds later.
>> I'm thinking that the processor is running (something, I don't know what)
>> for all this time before I can see requests coming from the board again. I
>> pinged the board from the PC and during all this I can see the packets being
>> answered.
>>
>>
>>   Can you try this patch?
>>
>>   My question to all is, did anyone see something like this already? Besides
>> that, what is the status of the linux kernel support for the 8xx platform?
>> Is it being actively tested / used today? I ask this because it seems that
>> all the information on the internet very aged (forum discussions from 2005
>> and below mostly).
>>
>> Is there something that I can do to try to narrow the cause of the problem?
>>
>> Anyway, any help would be truly appreciated. Please excuse me if this is not
>> the right place to ask this too.
>>
>> Thanks and best regards,
>> Rafael Beimsrbeims@gmail.com
>> (41) 8873-7565
>> "What I hear, I forget. What I see, I remember. And what I do, I
>> understand."
>> - Chinese Proverb
>>
>>
>>
>> _______________________________________________
>> Linuxppc-dev mailing listLinuxppc-dev@lists.ozlabs.orghttps://lists.ozlabs.org/listinfo/linuxppc-dev
>>
>>
>>
