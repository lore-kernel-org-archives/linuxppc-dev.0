Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A11EDDEC6C
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 20:44:46 +1000 (EST)
Message-Id: <0AFFA88B-E4B4-4B27-8B6F-8BA0463D7245@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: ehrhardt@linux.vnet.ibm.com
In-Reply-To: <1219142204-12044-3-git-send-email-ehrhardt@linux.vnet.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH 2/4] kvmppc: add hypercall infrastructure - guest part
Date: Fri, 22 Aug 2008 05:38:54 -0500
References: <1219142204-12044-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<1219142204-12044-3-git-send-email-ehrhardt@linux.vnet.ibm.com>
Cc: ppc-dev list <linuxppc-dev@ozlabs.org>,
	Hollis Blanchard <hollisb@us.ibm.com>, kvm-ppc <kvm-ppc@vger.kernel.org>,
	Yoder Stuart <stuart.yoder@freescale.com>
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
> This adds the guest portion of the hypercall infrastructure,  
> basically an
> illegal instruction with a defined layout.
> See http://kvm.qumranet.com/kvmwiki/PowerPC_Hypercall_ABI for more  
> detail
> on the hypercall ABI for powerpc.
>
> Signed-off-by: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
> ---
>
> [diffstat]
> kvm_para.h |   33 +++++++++++++++++++++++++++++++++
> 1 file changed, 33 insertions(+)
>
> [diff]

Can we make this more generic (naming) and location.  I believe there  
is some interesting in using the same ABI on the Freescale HV so it  
seems like have the wrappers be a bit more generic saves us.

- k
