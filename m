Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EDDCCDDD04
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Feb 2009 17:11:54 +1100 (EST)
Message-Id: <DECF9965-04E1-4897-8686-147625C5EE93@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20090211114011.04f838d6.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH v4] powerpc: Unify opcode definitions and support
Date: Wed, 11 Feb 2009 00:11:32 -0600
References: <1234312110-22227-1-git-send-email-galak@kernel.crashing.org>
	<20090211114011.04f838d6.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 10, 2009, at 6:40 PM, Stephen Rothwell wrote:

> Hi Kumar,
>
> On Tue, 10 Feb 2009 18:28:30 -0600 Kumar Gala <galak@kernel.crashing.org 
> > wrote:
>>
>> +++ b/arch/powerpc/include/asm/ppc-opcode.h
>> @@ -0,0 +1,68 @@
>> +/*
>> + * Copyright (C) 2009 Freescale Semicondutor, Inc. All rights  
>> reserved.
>
> If you are going to use "All rights reserved", you should also allow  
> us
> to use it under the GPL explicitly ...

posted a new version that should fix this (added GPL license)

- k
