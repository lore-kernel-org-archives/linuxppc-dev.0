Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BBCF11A042A
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Nov 2015 12:23:37 +1100 (AEDT)
Message-ID: <1446427416.31303.1.camel@ellerman.id.au>
Subject: Re: [PATCH] nx-842: Ignore bit 3 of condition register returned by
 icswx
From: Michael Ellerman <mpe@ellerman.id.au>
To: Ram Pai <linuxram@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
Cc: hbabu@us.ibm.com, nacc@us.ibm.com
Date: Mon, 02 Nov 2015 12:23:36 +1100
In-Reply-To: <20151030223120.GA22550@ram.oc3035372033.ibm.com>
References: <20151030223120.GA22550@ram.oc3035372033.ibm.com>
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

On Fri, 2015-10-30 at 15:31 -0700, Ram Pai wrote:
> icswx occasionally under heavy load sets bit 3 of condition register 0.

Why?

Also you seem to be using IBM bit numbering, so please be explicit about that,
or use normal bit numbering.

> It has no software implication.

What does it mean? You might be right but you don't give me enough info to
decide.

> Currently that bit is interpreted by the driver as a failure, when
> it should have calmly ignored it.

Should the fix be in icswx or the driver? Please justify your choice.

This sounds like it's fixing a bug so shouldn't the patch go to stable? And if
so which version(s) should it apply to?

cheers
