Return-Path: <SRS0=2n06=HI=goodmis.org=rostedt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40RpMf2vJRzF22W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Apr 2018 05:05:02 +1000 (AEST)
Date: Thu, 19 Apr 2018 11:28:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@ozlabs.org>, Satheesh Rajendran
 <sathnaga@linux.vnet.ibm.com>
Subject: Re: [PATCH v5 00/10] powerpc64/ftrace: Add support for
 ftrace_modify_call() and a few other fixes
Message-ID: <20180419112832.322cb54e@gandalf.local.home>
In-Reply-To: <cover.1524121038.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1524121038.git.naveen.n.rao@linux.vnet.ibm.com>
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

On Thu, 19 Apr 2018 12:33:59 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> This is v5 of the patches posted at:
> https://patchwork.ozlabs.org/project/linuxppc-dev/list/?series=37250
> 
> This series has been tested using mambo for p8 (hash) and p9 (radix), 
> and also on Power8 host.
> 
> In v5, the patch for KVM has been re-worked and is now [6/10], instead 
> of [2/10]. This now works properly on a Power8 machine. More details in 
> the patch. All other patches are unchanged from v4.
> 

I had a small comment on patch 6, but by doing a quick review of the
code, I don't have any issues with this. I would assume others will do
a more thorough review though.

For the series:

Acked-by: Steven Rostedt (VMware) <rostedt@goodmis.org>

-- Steve
