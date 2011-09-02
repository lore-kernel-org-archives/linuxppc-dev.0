Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE004.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3CFECB6F7F
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Sep 2011 04:33:22 +1000 (EST)
Message-ID: <4E61216A.4040502@freescale.com>
Date: Fri, 2 Sep 2011 13:33:14 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/4] powerpc/85xx: Rename PowerPC core nodes to match
	other	e500mc based .dts
References: <1314905175-4371-1-git-send-email-galak@kernel.crashing.org>
	<4E5FEE40.7080901@freescale.com>
	<0995BAB2-7865-4E95-A842-EFE486FFDAC4@kernel.crashing.org>
	<4E6117E6.8080103@freescale.com>
	<337763E2-C543-4CC2-95F2-0B7BDBA0E6B6@kernel.crashing.org>
In-Reply-To: <337763E2-C543-4CC2-95F2-0B7BDBA0E6B6@kernel.crashing.org>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/02/2011 01:29 PM, Kumar Gala wrote:
> 
> On Sep 2, 2011, at 12:52 PM, Scott Wood wrote:
> 
>> On 09/01/2011 10:21 PM, Kumar Gala wrote:
>>>
>>> On Sep 1, 2011, at 3:42 PM, Scott Wood wrote:
>>>> Is the "PowerPC" vendor string still appropriate here, or should we use
>>>> "fsl"?
>>>
>>> I have mixed feelings on this.  The PowerPC,NAME has a long history & precedence.  Is there any use or value to change this?
>>
>> It's inconsistent with all of our other compatibles.  My understanding
>> is that for older chips, the naming was from a managed numberspace -- is
>> "e500" or "eXXXX" something that was explicitly granted to us by
>> power.org, or just something we started calling our cores?
> 
> The names for PPC cores are NOT granted by anyone.

So, it's fsl's namespace, and the vendor id should be fsl.

-Scott
