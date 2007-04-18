Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E0348DDEBE
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Apr 2007 16:11:12 +1000 (EST)
In-Reply-To: <20070418055638.GA16650@in.ibm.com>
References: <20070418055638.GA16650@in.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4F8C7783-242E-4254-A8AD-A8452C7B248C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Emulate more instructions in software
Date: Wed, 18 Apr 2007 01:11:00 -0500
To: ananth@in.ibm.com
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 18, 2007, at 12:56 AM, Ananth N Mavinakayanahalli wrote:

> Emulate a few more instructions in software - especially useful during
> singlestepping (xmon/kprobes).
>
> Instructions emulated with this patch are mfcr/mtcr rX, mfxer/mtxer  
> rX,
> mflr/mtlr rX, mfctr/mtctr rX and mr rA,rB.
>
>
> Signed-off-by: Ananth N Mavinakayanahalli <ananth@in.ibm.com>

When do we actually need to emulate any of these instructions?  I  
don't see why single stepping would effect the ability to execute  
these instructions.

- k
