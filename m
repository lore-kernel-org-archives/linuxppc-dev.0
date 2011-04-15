Return-Path: <sruffell@digium.com>
Received: from mail.digium.com (mail.digium.com [216.207.245.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0A190B6FEF
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 15 Apr 2011 13:46:06 +1000 (EST)
Message-ID: <4DA7BF77.6@digium.com>
Date: Thu, 14 Apr 2011 22:45:59 -0500
From: Shaun Ruffell <sruffell@digium.com>
MIME-Version: 1.0
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [PATCH] powerpc: Define 'crash_kexec_wait_realmode' for Non-SMP
	systems.
References: <20110414222719.GA16256@digium.com>
	<4DA78A44.1000704@windriver.com>
In-Reply-To: <4DA78A44.1000704@windriver.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 4/14/11 6:59 PM, Paul Gortmaker wrote:
> On 11-04-14 06:27 PM, Shaun Ruffell wrote:
>> This fixes a regression from b987812b3fcaf70fdf0037589e5d2f5f2453e6ce
>
> A fix was already sent yesterday:
>
> http://lists.ozlabs.org/pipermail/linuxppc-dev/2011-April/089559.html
>
> which relocates the stub function to where it needs to be.  Your fix
> below would end up making duplicate stub functions.

Thanks for the reply. I didn't search the linuxppp-dev list before 
sending in that patch, only the LKML. Sorry about the noise.

Cheers,
Shaun
