Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EF3D8DDEE1
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Oct 2007 13:20:09 +1000 (EST)
In-Reply-To: <18199.59909.763111.810973@cargo.ozlabs.ibm.com>
References: <Pine.LNX.4.64.0710181655270.28684@blarg.am.freescale.net>
	<18199.59909.763111.810973@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <12EA14AC-6A3E-4322-9083-0C18996EC227@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] powerpc: Add -mno-spe for ARCH=powerpc builds
Date: Thu, 18 Oct 2007 22:20:49 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 18, 2007, at 6:19 PM, Paul Mackerras wrote:

> Kumar Gala writes:
>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>
> Your commit message doesn't give any reason why you are doing this, or
> any explanation of what goes wrong without it.  In fact, the commit
> message is completely empty. :)  Please resubmit with a decent commit
> message.

I will, just as an FYI I based this on your commit for -mno-altivec  
(which has no rationale for the commit) :)

- k
