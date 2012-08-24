Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id CC8782C00D7
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Aug 2012 07:04:21 +1000 (EST)
Date: Fri, 24 Aug 2012 14:04:19 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexandre Bounine <alexandre.bounine@idt.com>
Subject: Re: [PATCH] rapidio: apply RX/TX enable to active switch ports only
Message-Id: <20120824140419.2b3a9623.akpm@linux-foundation.org>
In-Reply-To: <1345559035-25879-2-git-send-email-alexandre.bounine@idt.com>
References: <1345559035-25879-1-git-send-email-alexandre.bounine@idt.com>
 <1345559035-25879-2-git-send-email-alexandre.bounine@idt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 21 Aug 2012 10:23:55 -0400
Alexandre Bounine <alexandre.bounine@idt.com> wrote:

> Modify RIO enumeration to apply RX/TX enable operations only to active
> switch ports. This will leave inactive ports in condition consistent with
> their state.

It's unclear (to me) what the effects of this are.  Does it fix some
user-visible malfunction?  Or is it just some nice-to-have thing?  Or
what?

> This patch is applicable to kernel versions starting from v2.6.35.

Is that a recommendation that such a backport be performed?  If so,
please provide the reasoning.
