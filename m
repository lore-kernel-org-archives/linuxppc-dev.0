Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rz6S53s06zDqRK
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Jul 2016 15:41:25 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id g202so13252269pfb.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Jul 2016 22:41:25 -0700 (PDT)
Date: Tue, 26 Jul 2016 15:41:15 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [RFC PATCH 6/9] powerpc: modify __SOFTEN_TEST to support
 tri-state soft_enabled flag
Message-ID: <20160726154115.292349df@roar.ozlabs.ibm.com>
In-Reply-To: <1469458342-26233-7-git-send-email-maddy@linux.vnet.ibm.com>
References: <1469458342-26233-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1469458342-26233-7-git-send-email-maddy@linux.vnet.ibm.com>
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

On Mon, 25 Jul 2016 20:22:19 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> Foundation patch to support checking of new flag for
> "paca->soft_enabled". Modify the condition checking for the
> "soft_enabled" from "equal" to "greater than or equal to".

Rather than a "tri-state" and the mystery "2" state, can you
make a #define for that guy, and use levels.

0-> all enabled
1-> "linux" interrupts disabled
2-> PMU also disabled
etc.

Thanks,
Nick
