Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E2EAD1A3177
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Dec 2015 14:46:25 +1100 (AEDT)
Message-ID: <1448941585.9027.4.camel@ellerman.id.au>
Subject: Re: [PATCH v5] powerpc/pseries: Limit EPOW reset event warnings
From: Michael Ellerman <mpe@ellerman.id.au>
To: Vipin K Parashar <vipin@linux.vnet.ibm.com>, Vasant Hegde
 <hegdevasant@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: Kamalesh Babulal <kamalesh@linux.vnet.ibm.com>
Date: Tue, 01 Dec 2015 14:46:25 +1100
In-Reply-To: <565C3A83.8080504@linux.vnet.ibm.com>
References: <1447836157-19599-1-git-send-email-vipin@linux.vnet.ibm.com>
 <5656CEC9.4070000@linux.vnet.ibm.com> <565C3A83.8080504@linux.vnet.ibm.com>
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

On Mon, 2015-11-30 at 17:31 +0530, Vipin K Parashar wrote:
> On Thursday 26 November 2015 02:50 PM, Vasant Hegde wrote:
> > On 11/18/2015 02:12 PM, Vipin K Parashar wrote:
> > > Kernel prints respective warnings about various EPOW events for
> > > user information/action after parsing EPOW interrupts. At times
> > > below EPOW reset event warning is seen to be flooding kernel log
> > > over a period of time.
> > > 
> > > May 25 03:46:34 alp kernel: Non critical power or cooling issue cleared
> > > May 25 03:46:52 alp kernel: Non critical power or cooling issue cleared
> > > May 25 03:53:48 alp kernel: Non critical power or cooling issue cleared
> > > May 25 03:55:46 alp kernel: Non critical power or cooling issue cleared
> > > May 25 03:56:34 alp kernel: Non critical power or cooling issue cleared
> > > May 25 03:59:04 alp kernel: Non critical power or cooling issue cleared
> > > May 25 04:02:01 alp kernel: Non critical power or cooling issue cleared
> > > 
> > @Michael,
> >   I think above log is raising some concern. We have been asked by multiple
> > people on this. Hence I think we should avoid these duplicate messages.
> 
> Hi Michael,
>           Please do let know if you have some suggestions with this patch.


It seems OK to me. I actually had it in my testing tree and was about to merge
it when Vasant replied with comments.

So if you two can agree on a final patch I'll merge it.

cheers
