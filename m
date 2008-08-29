Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F3AA0DE119
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Aug 2008 22:07:02 +1000 (EST)
Message-Id: <51BD7434-6C6F-426D-8A2C-0AAE374464E3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <1219725568.13162.122.camel@pasglop>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH v2] powerpc: Fix determining TI_CPU in
	power_save_ppc32_restore()
Date: Fri, 29 Aug 2008 07:06:57 -0500
References: <1219716536-21643-1-git-send-email-galak@kernel.crashing.org>
	<1219725568.13162.122.camel@pasglop>
Cc: ppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 25, 2008, at 11:39 PM, Benjamin Herrenschmidt wrote:

> On Mon, 2008-08-25 at 21:08 -0500, Kumar Gala wrote:
>> The calculation to get TI_CPU based off of SPRG3 was just plain  
>> wrong.
>> Just offset off the stack pointer (to get to thread_info) like all  
>> the
>> other references to TI_CPU do.
>>
>> This was pointed out by Chen Gong <G.Chen@freescale.com>
>>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Paul, you picking this up for 2.6.27?

- k
