Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A8731DE698
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jun 2008 02:49:01 +1000 (EST)
Message-Id: <172A4191-2837-4858-9F16-2D9ECE362597@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jon Loeliger <jdl@freescale.com>
In-Reply-To: <48593373.1010406@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: Question regarding mpic_assign_isu() in storcenter.c
Date: Wed, 18 Jun 2008 11:48:51 -0500
References: <21800186.1213747779368.JavaMail.root@mswamui-cedar.atl.sa.earthlink.net>
	<48593373.1010406@freescale.com>
Cc: Eric Witcher <witcher@mindspring.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 18, 2008, at 11:10 AM, Jon Loeliger wrote:

> Eric Witcher wrote:
>> The answer is that mpic_assign_isu(mpic, 1, paddr + 0x11000) places  
>> the initial base register
>> for isu 1 on a reserved location in the PIC register map (see *).   
>> I guess you can infer from this
>> that no badness occurs when you write to a reserved location on the  
>> PIC.
>
> See?  See Kumar?  Didn't you tell me that would
> come back to haunt us juuust like you said... :-)

I feel like I remember saying something about that :)

I've submitted a patch to deal with the issue so we can just use 256  
and remove all the multiple isu business.

- k
