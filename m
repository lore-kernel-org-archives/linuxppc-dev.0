Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BB1A2DE02F
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jun 2008 01:24:37 +1000 (EST)
Message-Id: <0CBF00BA-085C-49C7-A32D-0BEF6089958F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: jyoung5@us.ibm.com
In-Reply-To: <1212779345.6876.17.camel@thinkpadL>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [v4] Fix definitions for dbcr0, dbcr1,
	& dbcr2 register for bookE processors
Date: Wed, 11 Jun 2008 10:24:31 -0500
References: <1212779345.6876.17.camel@thinkpadL>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, kvm-ppc <kvm-ppc@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 6, 2008, at 2:09 PM, Jerone Young wrote:

> Updates: Placed everything in one conditional. Updated commit message.
>
> This takes values from the PowerPC ISA BookIII-E specifications that  
> are for DBCR0. Many of these values are different from those  
> currently specified, which are for the ppc405. Also added some bookE  
> definitions for DBCR1 & DBCR2.
>
> Signed-off-by: Jerone Young <jyoung5@us.ibm.com>

Acked-by: Kumar Gala <galak@kernel.crashing.org>

- k
