Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8BE9BDEFE4
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 23:46:24 +1000 (EST)
Message-Id: <81439C52-0CB6-4C46-9A97-3D30B84F58AF@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: ehrhardt@linux.vnet.ibm.com
In-Reply-To: <1219142204-12044-5-git-send-email-ehrhardt@linux.vnet.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH 4/4] kvmppc: convert wrteei to wrtee as kvm guest
	optimization
Date: Thu, 21 Aug 2008 08:41:10 -0500
References: <1219142204-12044-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<1219142204-12044-5-git-send-email-ehrhardt@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, hollisb@us.ibm.com, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 19, 2008, at 5:36 AM, ehrhardt@linux.vnet.ibm.com wrote:

> From: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
>
> Dependent on the already existing CONFIG_KVM_GUEST config option  
> this patch
> changes wrteei to wrtee allowing the hypervisor to rewrite those to  
> nontrapping
> instructions. Maybe we should split the kvm guest otpimizations in  
> two parts
> one for the overhead free optimizations and on for the rest that  
> might add
> some complexity for non virtualized execution (like this one).
>
> Signed-off-by: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
> ---

So this commit message doesnt explain why 'wrtee' facilities doing  
whatever optimization and 'wrteei' doesnt.

- k
