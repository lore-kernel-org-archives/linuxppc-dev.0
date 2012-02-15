Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp08.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9D046B6FD5
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2012 20:21:42 +1100 (EST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Wed, 15 Feb 2012 09:19:21 +1000
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q1F9GDtP3457134
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2012 20:16:15 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q1F9LNML011703
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Feb 2012 20:21:24 +1100
Message-ID: <4F3B790F.1040907@linux.vnet.ibm.com>
Date: Wed, 15 Feb 2012 14:51:19 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 6/12] arch/powerpc: remove references to cpu_*_map.
References: <1329281884.20466.rusty@rustcorp.com.au>
In-Reply-To: <1329281884.20466.rusty@rustcorp.com.au>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Venkatesh Pallipadi <venki@google.com>, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/15/2012 10:28 AM, Rusty Russell wrote:

> From: Rusty Russell <rusty@rustcorp.com.au>
> 
> This has been obsolescent for a while; time for the final push.
> 
> Signed-off-by: Rusty Russell <rusty@rustcorp.com.au>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---


Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Regards,
Srivatsa S. Bhat
