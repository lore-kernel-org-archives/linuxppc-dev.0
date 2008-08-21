Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 534DB47678
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 07:59:52 +1000 (EST)
Message-Id: <C7EDF44A-277E-4157-B2D6-0DEDCF65AED7@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20080821.140346.236252915.davem@davemloft.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH] math-emu: Fix compiler warnings
Date: Thu, 21 Aug 2008 16:59:44 -0500
References: <1219323021-7273-1-git-send-email-galak@kernel.crashing.org>
	<20080821.140346.236252915.davem@davemloft.net>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 21, 2008, at 4:03 PM, David Miller wrote:

> From: Kumar Gala <galak@kernel.crashing.org>
> Date: Thu, 21 Aug 2008 07:50:20 -0500
>
>> Fix warnings of the form:
>> arch/powerpc/math-emu/fsubs.c:15: warning: 'R_f1' may be used  
>> uninitialized in this function
>> arch/powerpc/math-emu/fsubs.c:15: warning: 'R_f0' may be used  
>> uninitialized in this function
>>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>
> You should look at the compiler options we use on sparc to build this
> stuff :-)
>
> EXTRA_CFLAGS = -Iinclude/math-emu -w

Yeah, I plan on doing that on PPC once I move over the global include/ 
math-emu files.

- k
