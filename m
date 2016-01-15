Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6AC961A0050
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jan 2016 21:07:15 +1100 (AEDT)
Message-ID: <1452852434.23073.5.camel@ellerman.id.au>
Subject: Re: [V3] powerpc/powernv: Add a kmsg_dumper that flushes console
 output on panic
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stewart Smith <stewart@linux.vnet.ibm.com>, Russell Currey
 <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
Date: Fri, 15 Jan 2016 21:07:14 +1100
In-Reply-To: <87a8o78mk3.fsf@linux.vnet.ibm.com>
References: <20160111091402.BDBAB1402DE@ozlabs.org>
 <87wprfea1n.fsf@linux.vnet.ibm.com> <1452572253.1433.4.camel@russell.cc>
 <1452600325.20985.4.camel@ellerman.id.au>
 <87a8o78mk3.fsf@linux.vnet.ibm.com>
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

On Fri, 2016-01-15 at 15:59 +1100, Stewart Smith wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
> > So my preference would be just an incremental patch ASAP to fix the kernel to
> > do the right thing with the new interface.
>
> I see that's merged now, which is great! Even if someone is bisecting
> back, things will be fine too.

Yep. And the bisection window is only 17 commits, so not a major problem in the
end.

I've added a check to my scripts so that when a patch touches opal-api.h it
yells at me to check skiboot. Hopefully that will prevent this case in future.

cheers
