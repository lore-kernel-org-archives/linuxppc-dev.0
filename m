Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E6109DDDED
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 02:31:17 +1100 (EST)
Message-Id: <12547B5E-C4A6-4A4D-97FB-32A85453D301@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1227156402.7185.200.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc: Add MSR[CE,
	DE] to the MSR bits we print on show_regs()
Date: Thu, 20 Nov 2008 09:31:09 -0600
References: <1227105593-29462-1-git-send-email-galak@kernel.crashing.org>
	<1227156402.7185.200.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 19, 2008, at 10:46 PM, Benjamin Herrenschmidt wrote:

> On Wed, 2008-11-19 at 08:39 -0600, Kumar Gala wrote:
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>> ---
>
> Shouldn't this be protected by some ifdef ?
>
> Ben.
>
>> arch/powerpc/kernel/process.c |    2 ++
>> 1 files changed, 2 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/ 
>> process.c
>> index 957bded..b038323 100644
>> --- a/arch/powerpc/kernel/process.c
>> +++ b/arch/powerpc/kernel/process.c
>> @@ -467,6 +467,8 @@ static struct regbit {
>> 	{MSR_VEC,	"VEC"},
>> 	{MSR_VSX,	"VSX"},
>> 	{MSR_ME,	"ME"},
>> +	{MSR_CE,	"CE"},
>> +	{MSR_DE,	"DE"},
>> 	{MSR_IR,	"IR"},
>> 	{MSR_DR,	"DR"},
>> 	{0,		NULL}

Why?  The bits are always defined and don't seem to be reused (and we  
don't ifdef VEC, VSX, etc..) so why bother?

- k
