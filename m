Return-Path: <yur@emcraft.com>
Received: from ocean.emcraft.com (ocean.emcraft.com [213.221.7.182])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8BD17DDE33
	for <linuxppc-dev@ozlabs.org>; Thu, 18 Oct 2007 23:20:31 +1000 (EST)
From: Yuri Tikhonov <yur@emcraft.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] ppc44x: support for 256K PAGE_SIZE
Date: Thu, 18 Oct 2007 17:18:00 +0400
References: <200710181108.19413.yur@emcraft.com>
	<1192704248.13993.36.camel@localhost.localdomain>
In-Reply-To: <1192704248.13993.36.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200710181718.00965.yur@emcraft.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Thursday 18 October 2007 14:44, you wrote:
> Sorry, this is against arch/ppc which is bug fix only.  New features
> should be done against arch/powerpc. 

 Understood. The situation here is that the boards, which required these
modifications, have no support in the arch/powerpc branch. So this is 
why we made this in arch/ppc.

> Also, I'd rather see something along the lines of hugetlbfs support instead.

 Here I agree with Benjamin. Furthermore, IIRC the hugetlb file-system is
supported for PPC64 architectures only. Here we have PPC32.

> josh

-- 
Yuri Tikhonov, Senior Software Engineer
Emcraft Systems, www.emcraft.com
