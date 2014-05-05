Return-Path: <chzigotzky@xenosoft.de>
Received: from mo4-p00-ob.smtp.rzone.de (mo4-p00-ob.smtp.rzone.de
 [81.169.146.216])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5A0F01402FA
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 May 2014 19:41:41 +1000 (EST)
Message-ID: <53675CCF.1000300@xenosoft.de>
Date: Mon, 05 May 2014 11:41:35 +0200
From: Christian Zigotzky <chzigotzky@xenosoft.de>
MIME-Version: 1.0
To: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: Boot problems with a PA6T board
References: <5366649E.4030102@xenosoft.de> <1399268891.4600.3.camel@concordia>
In-Reply-To: <1399268891.4600.3.camel@concordia>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

Thanks a lot for your answer. They reasoned that "starting cpu hw idx 
0... failed" is reported because that core of the CPU is already up and 
running.

I have built a git kernel from 2014-04-02.

-> git clone 
git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git linux-git
-> git show 3e75c6de1ac33fe3500f44573d9212dc82c99f59
-> git checkout -f 3e75c6de1ac33fe3500f44573d9212dc82c99f59; git clean -fdx

This kernel booted and showed a Kernel Panic with the following error 
message:

Oops: Machine check, sig: 7 [#1]

Rgds,

Christian


On 05.05.2014 07:48, Michael Ellerman wrote:
> On Sun, 2014-05-04 at 18:02 +0200, Christian Zigotzky wrote:
>> Hi All,
>>
>> The RC 1, 2, and 3 of the kernel 3.15 don't boot on my PA6T board with a
>> Radeon HD 6870 graphics card.
>>
>> Screenshot:
>> http://forum.hyperion-entertainment.biz/download/file.php?id=1060&mode=view
>>
>> The kernel 3.14 starts without any problems. Has anyone a tip for me,
>> please?
> The line that says "starting cpu hw idx 0... failed" looks a little worrying.
> Do you see that on 3.14 as well?
>
> Otherwise bisection is probably your best bet.
>
> cheers
>
>
>
