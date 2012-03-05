Return-Path: <akpm@linux-foundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12]) by ozlabs.org (Postfix) with ESMTP id 1B49BB6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Mar 2012 07:37:18 +1100 (EST)
Date: Mon, 5 Mar 2012 12:37:14 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: Alexandre Bounine <alexandre.bounine@idt.com>
Subject: Re: [PATCH] rapidio/tsi721: fix bug in inbound doorbell handler
Message-Id: <20120305123714.0750129e.akpm@linux-foundation.org>
In-Reply-To: <1330979585-29429-1-git-send-email-alexandre.bounine@idt.com>
References: <1330979585-29429-1-git-send-email-alexandre.bounine@idt.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Chul Kim <chul.kim@idt.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon,  5 Mar 2012 15:33:05 -0500
Alexandre Bounine <alexandre.bounine@idt.com> wrote:

> Fixes queue wrapping bug in Inbound Doorbell handling routine.

The changelog doesn't describe the user-visible impact of the bug. 
Please always include this so that people know whether to backport the
fix into their kernels, and so they can determine whether the patch
will fix a problem which they are observing.
