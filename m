Return-Path: <oleg@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x5rBy20lhzDqBr
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 02:24:26 +1000 (AEST)
Date: Mon, 10 Jul 2017 18:24:21 +0200
From: Oleg Nesterov <oleg@redhat.com>
To: James Morse <james.morse@arm.com>
Cc: linux-kernel@vger.kernel.org, Roland McGrath <roland@hack.frob.com>,
 linuxppc-dev@lists.ozlabs.org, Zhou Chengming <zhouchengming1@huawei.com>,
 Yury Norov <ynorov@caviumnetworks.com>, Andrey Vagin <avagin@openvz.org>
Subject: Re: [PATCH] ptrace: Add compat PTRACE_{G,S}ETSIGMASK handlers
Message-ID: <20170710162421.GA24729@redhat.com>
References: <20170629162637.10676-1-james.morse@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170629162637.10676-1-james.morse@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/29, James Morse wrote:
>
> compat_ptrace_request() lacks handlers for PTRACE_{G,S}ETSIGMASK,
> instead using those in ptrace_request(). The compat variant should
> read a compat_sigset_t from userspace instead of ptrace_request()s
> sigset_t.

Acked-by: Oleg Nesterov <oleg@redhat.com>
