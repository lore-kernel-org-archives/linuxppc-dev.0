Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6AE841A0729
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jul 2015 19:58:35 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id AAD93140DFC
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Jul 2015 19:58:34 +1000 (AEST)
Message-ID: <1438077498.7562.130.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH] powerpc/kexec: Wait 1s for secondaries to enter OPAL
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: sam.mj@au1.ibm.com
Cc: Stewart Smith <stewart@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Date: Tue, 28 Jul 2015 19:58:18 +1000
In-Reply-To: <55B71D89.7000308@au1.ibm.com>
References: <1437544469-20028-1-git-send-email-sam.mj@au1.ibm.com>
 <m3r3nukut9.fsf@oc8180480414.ibm.com> <55B71D89.7000308@au1.ibm.com>
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

On Tue, 2015-07-28 at 16:13 +1000, Samuel Mendoza-Jonas wrote:

> "It sounds reasonable" was more or less the inspiration :)
> While I was going over some of the code relating to the previous kexec
> fix with Ben he pointed this out and suggested there wasn't
> much of a reason to differentiate between a crashing/non-crashing
> cpu as far as the timeout goes - if we're not 'crashing' we still
> don't want to spin forever.
> 
> I'll let Ben comment on whether 1s per cpu is enough.

Well, if the scheduler doesn't give us the CPU at the point of kexec
within a second, I think we are in pretty bad shape already, don't you
think ?

I don't mind bumping the timeout of you have worries...

Cheers,
Ben.
