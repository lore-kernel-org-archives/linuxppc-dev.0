Return-Path: <avi@qumranet.com>
Received: from il.qumranet.com (bzq-179-150-194.static.bezeqint.net
	[212.179.150.194]) by ozlabs.org (Postfix) with ESMTP id DBC37DE12B
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 21:14:39 +1000 (EST)
Message-ID: <4807311D.3020402@qumranet.com>
Date: Thu, 17 Apr 2008 14:14:37 +0300
From: Avi Kivity <avi@qumranet.com>
MIME-Version: 1.0
To: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: [PATCH 4 of 4] [KVM POWERPC] PowerPC 440 KVM implementation
References: <442f314cd08ea6addd39.1208406489@localhost.localdomain>
In-Reply-To: <442f314cd08ea6addd39.1208406489@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: kvm-ppc-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org,
	kvm-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hollis Blanchard wrote:
> +config KVM
> +	tristate "Kernel-based Virtual Machine (KVM) support"
> +	depends on EXPERIMENTAL
> +	select PREEMPT_NOTIFIERS
> +	select ANON_INODES
> +	---help---
> +	  Support hosting virtualized guest machines. You will also
> +	  need to select one or more of the processor modules below.
> +
> +	  This module provides access to the hardware capabilities through
> +	  a character device node named /dev/kvm.
> +
> +	  To compile this as a module, choose M here: the module
> +	  will be called kvm.
> +
> +	  If unsure, say N.
>   

In my ignorance, I set KVM=m on a non-44x build, which then failed. This 
needs either to depend on 44x, or to be fixed to compile.

> +
> +config KVM_BOOKE_HOST
> +	tristate "KVM host support for Book E PowerPC processors"
> +	depends on KVM && 44x
> +	---help---
> +	  Provides host support for KVM on Book E PowerPC processors. Currently
> +	  this works on 440 processors only.
> +
>   


-- 
error compiling committee.c: too many arguments to function
