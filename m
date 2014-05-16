Return-Path: <mikey@neuling.org>
Message-ID: <1400200013.3797.89.camel@ale.ozlabs.ibm.com>
Subject: Re: [PATCH V2 2/3] powerpc, ptrace: Enable support for
 transactional memory register sets
From: Michael Neuling <mikey@neuling.org>
To: Pedro Alves <palves@redhat.com>
Date: Fri, 16 May 2014 10:26:53 +1000
In-Reply-To: <5374AE24.1030302@redhat.com>
References: <1399276469-13541-1-git-send-email-khandual@linux.vnet.ibm.com>
 <1399276469-13541-3-git-send-email-khandual@linux.vnet.ibm.com>
 <537252C0.6090005@redhat.com> <53730326.6000400@linux.vnet.ibm.com>
 <53735044.5030008@redhat.com> <537479FD.2010200@linux.vnet.ibm.com>
 <5374AE24.1030302@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: avagin@openvz.org, linux-kernel@vger.kernel.org, oleg@redhat.com,
 michael@ellerman.id.au, linuxppc-dev@ozlabs.org,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> So in sum, it very much looks like the intention is for
> PTRACE_GETREGSET/PTRACE_SETREGSET to return ENODEV in the
> case the regset doesn't exist on the running machine, and then
> it looks like at least x86 works that way.

Good point... agreed.  We should ENODEV when we don't have TM hardware
(like POWER7).

Mikey
