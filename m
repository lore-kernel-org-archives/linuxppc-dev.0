Return-Path: <avi@redhat.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 79F3CB70E4
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jul 2009 21:19:47 +1000 (EST)
Received: from mx2.redhat.com (mx2.redhat.com [66.187.237.31])
	by ozlabs.org (Postfix) with ESMTP id 19816DDD1B
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Jul 2009 21:19:46 +1000 (EST)
Message-ID: <4A4C97C4.9090908@redhat.com>
Date: Thu, 02 Jul 2009 14:19:32 +0300
From: Avi Kivity <avi@redhat.com>
MIME-Version: 1.0
To: Liu Yu-B13201 <Yu.Liu@freescale.com>
Subject: Re: [PATCH 1/2] KVM/PPC: Fix PPC KVM e500_tlb.c build error
References: <47a7508d4561874c1a052cebe1b7f42b19831393.1246502441.git.yang.shi@windriver.com>
	<0A1FE637C2C7E148B9573BB60CC630E531C59D@zch01exm26.fsl.freescale.net>
In-Reply-To: <0A1FE637C2C7E148B9573BB60CC630E531C59D@zch01exm26.fsl.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Yang Shi <yang.shi@windriver.com>,
	kvm-ppc@vger.kernel.org, hollisb@us.ibm.com, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/02/2009 06:09 AM, Liu Yu-B13201 wrote:
> This fix is already accepted in kvm.git
>    

What about the other?  Is it needed?

-- 
error compiling committee.c: too many arguments to function
