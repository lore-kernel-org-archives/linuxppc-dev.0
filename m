Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AECFDDDE9A
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 16:47:35 +1100 (EST)
Message-Id: <5B5AE183-DD79-44DB-840D-D98FEFF24AAB@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Vitaly Bordug <vitb@kernel.crashing.org>
In-Reply-To: <20071209115353.1ae09ee1@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: Please pull linux-2.6-8xx.git for-paulus branch
Date: Thu, 13 Dec 2007 23:47:24 -0600
References: <20071208130025.09021cb0@kernel.crashing.org>
	<20071208130934.093d80f9@kernel.crashing.org>
	<CF849773-F9A6-45D1-A36E-9A350BE5FB6D@kernel.crashing.org>
	<20071209115353.1ae09ee1@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 9, 2007, at 2:53 AM, Vitaly Bordug wrote:

> On Sat, 8 Dec 2007 09:17:06 -0600
> Kumar Gala wrote:
>
>>
>> On Dec 8, 2007, at 4:09 AM, Vitaly Bordug wrote:
>>
>>> On Sat, 8 Dec 2007 13:00:25 +0300
>>> Vitaly Bordug wrote:
>>>
>>>> Paul,
>>>>
>>>> please do
>>>> git-pull
>>>> git://git.kernel.org/pub/scm/linux/kernel/git/vitb/ 
>>>> linux-2.6-8xx.git
>>>> for-paulus
>>>>
>>>> to receive the following updates:
>>>>
>>> Forgot to tell that this is .25 material...
>>
>> Vitaly, if you don't mind I'll pull these into my tree for Paul to
>> collect all the FSL stuff in one place.
>>
> I'm ok with either way.

I've pulled this and split the patches between for-2.6.24 (sent pull  
request to paulus) and for-2.6.25

- k
