Return-Path: <SRS0=7aBp=2I=goodmis.org=rostedt@kernel.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vX57G375WzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 02:22:50 +1100 (AEDT)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vX57G0km8z9sCg
 for <linuxppc-dev@ozlabs.org>; Tue, 28 Feb 2017 02:22:49 +1100 (AEDT)
Date: Mon, 27 Feb 2017 10:22:43 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jason Baron <jbaron@akamai.com>
Cc: Sachin Sant <sachinp@linux.vnet.ibm.com>, linux-next@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, linuxppc-dev@ozlabs.org, Michael
 Ellerman <mpe@ellerman.id.au>
Subject: Re: next-20170217 boot on POWER8 LPAR : WARNING
 @kernel/jump_label.c:287
Message-ID: <20170227102243.2172a8ea@gandalf.local.home>
In-Reply-To: <20c53e88-acf5-4c4f-cea9-4dd8745814b5@akamai.com>
References: <E6A8A7A8-6A55-4989-BAE9-39274876CA3C@linux.vnet.ibm.com>
 <1dffdaac-be8b-0052-52d4-a65fed39f894@akamai.com>
 <02B52EFB-4608-47F3-A81C-B8B52DB11233@linux.vnet.ibm.com>
 <20c53e88-acf5-4c4f-cea9-4dd8745814b5@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 21 Feb 2017 11:37:21 -0500
Jason Baron <jbaron@akamai.com> wrote:


> Thanks for testing. We probably need something like the following to 
> make sure we don't hit this on other arches. Steve - I will send 4 
> separate patches for this to get arch maintainers' acks for this?
> 

I just got back from ELC, so sorry for the late reply.

I think you can just send this as one patch, as it is a single fix. Cc
each of the arch maintainers though. Unless you think it will have
conflicts with other changes in those archs. But I'm assuming there
wont be any conflicts.

This is a fix for something that I just pushed to Linus, thus it can
still get in after the merge window closes.

-- Steve
