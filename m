Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A8CA0DDDE7
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Aug 2007 14:28:14 +1000 (EST)
In-Reply-To: <1186017799.5495.546.camel@localhost.localdomain>
References: <11859560681182-git-send-email-wei.zhang@freescale.com>
	<11859560694083-git-send-email-wei.zhang@freescale.com>
	<1186005360.5495.529.camel@localhost.localdomain>
	<46B96294322F7D458F9648B60E15112C74D58E@zch01exm26.fsl.freescale.net>
	<1186017799.5495.546.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <05E0FF5A-03DB-441E-81E8-54BD4A215D32@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/2] Add sysdev/pci_quirks.c file into PowerPCarchitecture
	with ULI chip quirk functions.
Date: Wed, 1 Aug 2007 23:29:12 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org,
	Zhang Wei-r63237 <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 1, 2007, at 8:23 PM, Benjamin Herrenschmidt wrote:

> On Thu, 2007-08-02 at 09:17 +0800, Zhang Wei-r63237 wrote:
>> Hi, Ben,
>>
>>>
>>> Are we sure that any powerpc machine that uses that ULI chip will  
>>> need
>>> the same quirk setting ?
>>>
>>
>> We can ensure current platforms (as far as we know, MPC8544DS and
>> MPC8641HPCN) using ULI chips in powerpc of kernel need the same quirk
>> setting.
>> And we hope to make them more generic. And if there are some  
>> different
>> setting in the future, we can add special codes.
>
> All right.

My feeling is this code is pretty specific to how the ULI M1575 is  
used on those boards and should only be built for those boards.

- k
