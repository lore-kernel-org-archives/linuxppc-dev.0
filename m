Return-Path: <stewart@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 464111A0758
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Apr 2015 15:36:09 +1000 (AEST)
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 573011401B1
 for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2015 15:36:07 +1000 (AEST)
Received: from /spool/local
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <stewart@linux.vnet.ibm.com>;
 Mon, 6 Apr 2015 23:36:05 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id E899019D8026
 for <linuxppc-dev@ozlabs.org>; Mon,  6 Apr 2015 23:27:07 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t375ZkCX31850646
 for <linuxppc-dev@ozlabs.org>; Mon, 6 Apr 2015 22:35:46 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t375a1Di028501
 for <linuxppc-dev@ozlabs.org>; Mon, 6 Apr 2015 23:36:01 -0600
From: Stewart Smith <stewart@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/powernv: Remove powernv RTAS support
In-Reply-To: <1427276571.31588.4.camel@ellerman.id.au>
References: <1426141631-10741-1-git-send-email-mpe@ellerman.id.au>
 <m3mw317hod.fsf@oc8180480414.ibm.com>
 <1427276571.31588.4.camel@ellerman.id.au>
Date: Tue, 07 Apr 2015 15:36:00 +1000
Message-ID: <m37ftozein.fsf@oc8180480414.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, dja@axtens.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:
>> The only current place I could think this could be remotely possible
>> would be in simulator... and we should instead make the OPAL calls work
>> properly in the simulator for all the RTAS functionality (that we care
>> about).
>
> If you mean mambo, I tested that, at least the public version, and it doesn't
> provide or need RTAS.
>
> On the other sims we ran without RTAS during the Power8 bringup, though it was
> eventually used a little bit late in the cycle. In future we should be using
> skiboot, or just putting logic directly into the kernel for early bringup - or
> permanently :)

agreed on using skiboot. If we're going as far as booting a linux
kernel, the overhead of loading skiboot is next to nothing in
comparison. Or at least it should be.
