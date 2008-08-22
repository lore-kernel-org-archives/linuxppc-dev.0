Return-Path: <hollisb@us.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e34.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EA5C7DDD04
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Aug 2008 00:01:15 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e34.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7ME0tW8006708
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 10:00:55 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7ME0aM3122858
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 08:00:39 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m7ME0ZSa012151
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 08:00:36 -0600
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2/4] kvmppc: add hypercall infrastructure - guest part
Date: Fri, 22 Aug 2008 09:00:49 -0500
References: <1219142204-12044-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<1219142204-12044-3-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<0AFFA88B-E4B4-4B27-8B6F-8BA0463D7245@kernel.crashing.org>
In-Reply-To: <0AFFA88B-E4B4-4B27-8B6F-8BA0463D7245@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808220900.50611.hollisb@us.ibm.com>
Cc: Yoder Stuart <stuart.yoder@freescale.com>,
	kvm-ppc <kvm-ppc@vger.kernel.org>, ppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Friday 22 August 2008 05:38:54 Kumar Gala wrote:
> 
> On Aug 19, 2008, at 5:36 AM, ehrhardt@linux.vnet.ibm.com wrote:
> 
> > From: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
> >
> > This adds the guest portion of the hypercall infrastructure,  
> > basically an
> > illegal instruction with a defined layout.
> > See http://kvm.qumranet.com/kvmwiki/PowerPC_Hypercall_ABI for more  
> > detail
> > on the hypercall ABI for powerpc.
> >
> > Signed-off-by: Christian Ehrhardt <ehrhardt@linux.vnet.ibm.com>
> > ---
> >
> > [diffstat]
> > kvm_para.h |   33 +++++++++++++++++++++++++++++++++
> > 1 file changed, 33 insertions(+)
> >
> > [diff]
> 
> Can we make this more generic (naming) and location.  I believe there  
> is some interesting in using the same ABI on the Freescale HV so it  
> seems like have the wrappers be a bit more generic saves us.

Agreed. Maybe something like epapr_hcalls.h .

-- 
Hollis Blanchard
IBM Linux Technology Center
