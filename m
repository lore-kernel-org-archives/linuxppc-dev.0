Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9DCCF1A09BD
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Nov 2014 11:19:00 +1100 (AEDT)
Message-ID: <1417133938.6694.3.camel@concordia>
Subject: Re: [RESEND, V3] powerpc, xmon: Enable HW instruction breakpoint on
 POWER8
From: Michael Ellerman <mpe@ellerman.id.au>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Fri, 28 Nov 2014 11:18:58 +1100
In-Reply-To: <5476DDE3.10705@linux.vnet.ibm.com>
References: <20141126082548.34D5114017D@ozlabs.org>
 <5476DDE3.10705@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, mikey@neuling.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-11-27 at 13:46 +0530, Anshuman Khandual wrote:
> On 11/26/2014 01:55 PM, Michael Ellerman wrote:
> > Something like this, untested:
> 
> Yeah it is working on LPAR and also on bare metal platform as well. The new patch
> will use some of your suggested code, so can I add your signed-off-by to the patch
> as well ?
 
Thanks for testing. Yes please add my:

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>

cheers
