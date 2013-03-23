Return-Path: <oleg@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 by ozlabs.org (Postfix) with ESMTP id 3822F2C00BE
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 24 Mar 2013 05:43:17 +1100 (EST)
Date: Sat, 23 Mar 2013 19:08:01 +0100
From: Oleg Nesterov <oleg@redhat.com>
To: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Subject: Re: [PATCH v2 1/4] uprobes: add trap variant helper
Message-ID: <20130323180801.GA4667@redhat.com>
References: <20130322151627.GB20010@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130322151627.GB20010@in.ibm.com>
Cc: ppcdev <linuxppc-dev@lists.ozlabs.org>, lkml <linux-kernel@vger.kernel.org>,
 Srikar Dronamraju <srikar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/22, Ananth N Mavinakayanahalli wrote:
>
> Some architectures like powerpc have multiple variants of the trap
> instruction. Introduce an additional helper is_trap_insn() for run-time
> handling of non-uprobe traps on such architectures.

Looks fine to me.

I am going to take this into my tree, hopefully Ben won't object. The
main change is arch-agnostic and the changes in arch/powerpc are trivial.

Oleg.
