Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6ADE8DE30C
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Apr 2009 13:48:04 +1000 (EST)
Message-Id: <9F2A5A7B-24F7-43AF-A7C4-3114207595AE@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: mjw@linux.vnet.ibm.com
In-Reply-To: <1240443612.27209.2.camel@mx3>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] powerpc: adjust oprofile_cpu_type
Date: Wed, 22 Apr 2009 22:47:55 -0500
References: <1240443612.27209.2.camel@mx3>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 22, 2009, at 6:40 PM, Mike Wolf wrote:

> Resending.  the patch was munged last time.
>
>
> Oprofile is changing the naming it is using for the compatibility  
> modes.
> Instead of having compat-power<x>, oprofile will go to family naming
> convention and use compat-v<x>.  Currently only compat-v1 will be
> defined.
>
> Signed-off-by: Mike Wolf <mjw@linux.vnet.ibm.com>
>
> ----

Any ideas what's going on w/ppc32 and these names?

- k
