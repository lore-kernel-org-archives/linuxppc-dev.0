Return-Path: <qiudayu@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5CA0C2C0106
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 14:06:08 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <qiudayu@linux.vnet.ibm.com>;
 Thu, 25 Apr 2013 14:00:09 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 3F39B2CE804A
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 14:06:02 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3P45tQQ7995566
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 14:05:55 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3P460iC025083
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Apr 2013 14:06:01 +1000
Message-ID: <5178ABA2.4030109@linux.vnet.ibm.com>
Date: Thu, 25 Apr 2013 12:05:54 +0800
From: Mike Qiu <qiudayu@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Chen Gang <gang.chen@asianux.com>
Subject: Re: "attempt to move .org backwards" still show up
References: <5177965D.9090406@linux.vnet.ibm.com>
 <20130424083142.GB26834@concordia> <51779941.8080403@linux.vnet.ibm.com>
 <30651.1366799858@ale.ozlabs.ibm.com> <1366807638.5911.2.camel@localhost>
 <5178816D.3000309@asianux.com>
In-Reply-To: <5178816D.3000309@asianux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: sfr@canb.auug.org.au, Michael Neuling <mikey@neuling.org>, matt@ozlabs.org,
 linux-kernel@vger.kernel.org, paulus@samba.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

于 2013/4/25 9:05, Chen Gang 写道:
> On 2013年04月24日 20:47, Mike wrote:
>> 在 2013-04-24三的 20:37 +1000，Michael Neuling写道：
>>>> Mike Qiu <qiudayu@linux.vnet.ibm.com> wrote:
>>>>
>>>>>> 于 2013/4/24 16:31, Michael Ellerman 写道:
>>>>>>>> On Wed, Apr 24, 2013 at 04:22:53PM +0800, Mike Qiu wrote:
>>>>>>>>>> Hi all
>>>>>>>>>>
>>>>>>>>>> I get an error message when I compile the source code in Power7 platform
>>>>>>>>>> use the newest upstream kernel.
>>>>>>>> Hi Mike,
>>>>>>>>
>>>>>>>> It depends on what your .config is. What defconfig are you building?
>>>>>> I just copy the config file from /boot/config.* to .config and use make
>>>>>> menuconfig
>>>>>> change nothing by manually, then save.
>>>> Can you post the resulting config here?
>>>>
>>>> Do you have commit in your tree?
>>>>    commit 087aa036eb79f24b856893190359ba812b460f45
>>>>    Author: Chen Gang <gang.chen@asianux.com>
>>>>    powerpc: make additional room in exception vector area
>>>>
>> Sure, that commit certainly in my git tree. And I just try to remove the
>> code and re-git clone the source code from upstream, this problem still
>> happen.
>> I will post the config file as the attachment
>> :)
>>
>> Thanks
> I will try, and plan to get a result within this week (2013-04-28)
>
> Thanks.
Hi
This has block my work now
So I hope you can take a look ASAP
Thanks
:)

Mike
