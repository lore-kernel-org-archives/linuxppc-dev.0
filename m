Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-wr0-x243.google.com (mail-wr0-x243.google.com
 [IPv6:2a00:1450:400c:c0c::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vKRvJ2D63zDq8g
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2017 18:50:36 +1100 (AEDT)
Received: by mail-wr0-x243.google.com with SMTP id k90so14208806wrc.3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 09 Feb 2017 23:50:36 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Fri, 10 Feb 2017 08:50:30 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, mhiramat@kernel.org,
 ananth@linux.vnet.ibm.com, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 1/3] kprobes: introduce weak variant of
 kprobe_exceptions_notify
Message-ID: <20170210075030.GA24405@gmail.com>
References: <b0894e503195b13a5ed6319e897e673f376a748d.1486496890.git.naveen.n.rao@linux.vnet.ibm.com>
 <87vasizp8u.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87vasizp8u.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Michael Ellerman <mpe@ellerman.id.au> wrote:

> "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> writes:
> 
> > kprobe_exceptions_notify() is not used on some of the architectures such
> > as arm[64] and powerpc anymore. Introduce a weak variant for such
> > architectures.
> 
> I'll merge patch 1 & 3 via the powerpc tree for v4.11.

Acked-by: Ingo Molnar <mingo@kernel.org>

Thanks,

	Ingo
