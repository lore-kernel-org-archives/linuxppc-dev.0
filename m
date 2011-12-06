Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id C26181007D5
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Dec 2011 09:36:41 +1100 (EST)
Date: Tue, 6 Dec 2011 14:36:38 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexandre Bounine <alexandre.bounine@idt.com>
Subject: Re: [PATCH] rapidio/tsi721: Fix mailbox resource reporting
Message-Id: <20111206143638.12598c7b.akpm@linux-foundation.org>
In-Reply-To: <1323198088-11669-1-git-send-email-alexandre.bounine@idt.com>
References: <1323198088-11669-1-git-send-email-alexandre.bounine@idt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue,  6 Dec 2011 14:01:27 -0500
Alexandre Bounine <alexandre.bounine@idt.com> wrote:

> Report support of four RapidIO mailboxes (MBOX0 - MBOX3) instead of MBOX0
> only.

I don't know how important these changes are and I don't know what
their end user visible effects are.  Hence I am unable to decide which
kernel version(s) we should merge the patches into.

That's why these things should always be explained in changelogs,
please.
