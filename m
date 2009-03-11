Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0CDFFDE176
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 23:04:58 +1100 (EST)
Message-Id: <7FB04997-33E8-479C-B5EF-A1ECA8059A99@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <20090311035330.DDF1FDE153@ozlabs.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 1/9] powerpc/kconfig: Kill PPC_MULTIPLATFORM
Date: Wed, 11 Mar 2009 07:04:51 -0500
References: <20090311035330.DDF1FDE153@ozlabs.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 10, 2009, at 10:53 PM, Benjamin Herrenschmidt wrote:

>
> config PPC_NATIVE
> 	bool
> -	depends on PPC_MULTIPLATFORM
> +	depends on 6xx || PPC64
> 	help
> 	  Support for running natively on the hardware, i.e. without
> 	  a hypervisor. This option is not user-selectable but should
> 	  be selected by all platforms that need it.

Should this really just be PPC64 && BOOK3S ?  It doesnt look to be  
used for anything beyond using hash_native_64.S

- k
