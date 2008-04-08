Return-Path: <hollisb@us.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A76DDDE0DD
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Apr 2008 05:43:57 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m38JjqDv013682
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Apr 2008 15:45:52 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m38JhlKW329272
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Apr 2008 15:43:47 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m38JhlOp008214
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Apr 2008 15:43:47 -0400
From: Hollis Blanchard <hollisb@us.ibm.com>
To: kvm-ppc-devel@lists.sourceforge.net
Subject: Re: [kvm-ppc-devel] [PATCH] [v5] Add idle wait support for 44x
	platforms
Date: Tue, 8 Apr 2008 14:43:46 -0500
References: <df0f79b7b4ab628887c2.1207673354@thinkpadL>
In-Reply-To: <df0f79b7b4ab628887c2.1207673354@thinkpadL>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200804081443.46841.hollisb@us.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 08 April 2008 11:49:14 Jerone Young wrote:
> 2 files changed, 77 insertions(+), 1 deletion(-)
> arch/powerpc/platforms/44x/Makefile |    2
> arch/powerpc/platforms/44x/idle.c   |   76
> +++++++++++++++++++++++++++++++++++
>
>
> Updates: Now setting MSR_WE is now default
>          Tested on hardware platforms bamboo & sequioa and appears
>          things are working fine on actually hardware!
>
> This patch adds the ability for the CPU to go into wait state while in
> cpu_idle loop. This helps virtulization solutions know when the guest Linux
> kernel is in an idle state. There are two ways to do it.
>
> Command line
> 	idle=spin <-- CPU will spin
> 	idle=wait <-- set CPU into wait state when idle (default)
>
>
> Signed-off-by: Jerone Young <jyoung5@us.ibm.com>

Acked-by: Hollis Blanchard <hollisb@us.ibm.com>

-- 
Hollis Blanchard
IBM Linux Technology Center
