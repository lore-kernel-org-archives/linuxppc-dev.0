Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vSqcP4X1BzDqHy
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2017 19:03:17 +1100 (AEDT)
Message-ID: <1487750581.23576.217.camel@kernel.crashing.org>
Subject: Re: [PATCH] powerpc/mm: Add translation mode information in
 /proc/cpuinfo
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>, paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org
Date: Wed, 22 Feb 2017 19:03:01 +1100
In-Reply-To: <8ec533a5-daf6-4644-ffea-e940fe3e77f9@linux.vnet.ibm.com>
References: <1487499469-15284-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <874lzmn5h1.fsf@concordia.ellerman.id.au>
 <8ec533a5-daf6-4644-ffea-e940fe3e77f9@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-02-22 at 11:19 +0530, Aneesh Kumar K.V wrote:
> I avoided using MMU, because it will confuse hardware guys.

Why would it ? I don't see how anybody would be confused. And they
aren't the primary consumers of /proc/cpuinfo anyway. I agree with
Michal here.

>  Radix is not 
> clearly the full definition of
> Memory management unit, but rather the translation mode used by memory 
> management unit. But
> i don't have strong opinion on this.

Who cares ? People understand :-) If you want call it "MMU Mode: if you
think it's cleared but I don't like too much having a space on the left
in case of stupid parsers...

> Do you want me to send an updated patch ? or you can update it when you 
> apply it to your tree ?
> 
> -aneesh
