Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C9BBFB6EF7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2012 09:45:24 +1100 (EST)
Message-ID: <1328827517.3019.0.camel@pasglop>
Subject: Re: [PATCH] powerpc: Fix WARN_ON in decrementer_check_overflow
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hugh Dickins <hughd@google.com>
Date: Fri, 10 Feb 2012 09:45:17 +1100
In-Reply-To: <alpine.LSU.2.00.1202091411170.1263@eggly.anvils>
References: <1328765653.2903.59.camel@pasglop>
 <alpine.LSU.2.00.1202091411170.1263@eggly.anvils>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-02-09 at 14:25 -0800, Hugh Dickins wrote:
> 
> Okay, thanks for the update, that's equivalent to the get_cpu_var
> plus put_cpu_var patch I had generally been running with successfully.
> 
> (I was not at all confident that it was a sufficient fix, and have
> to say "generally" above because one time I got something that looked
> like recursive calls overflowing the stack, and IIRC something "irq"
> did appear in each frame of the trace.  But probably no connection,
> never seen again, and I don't recall even which -rc or -next it was.)

If you ever see that again, please shoot me the log !

Cheers,
Ben.
