Return-Path: <jolsa@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wpMqW3bzKzDqL8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Jun 2017 22:13:59 +1000 (AEST)
Date: Thu, 15 Jun 2017 14:13:55 +0200
From: Jiri Olsa <jolsa@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, acme@kernel.org,
 "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
 Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] perf: libdw support for powerpc
Message-ID: <20170615121355.GE24413@krava>
References: <1496312681-20133-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1496312681-20133-1-git-send-email-pbonzini@redhat.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jun 01, 2017 at 12:24:41PM +0200, Paolo Bonzini wrote:
> Porting PPC to libdw only needs an architecture-specific hook to move
> the register state from perf to libdw.
> 
> The ARM and x86 architectures already use libdw, and it is useful to
> have as much common code for the unwinder as possible.  Mark Wielaard
> has contributed a frame-based unwinder to libdw, so that unwinding works
> even for binaries that do not have CFI information.  In addition,
> libunwind is always preferred to libdw by the build machinery so this
> cannot introduce regressions on machines that have both libunwind and
> libdw installed.
> 
> Cc: acme@kernel.org
> Cc: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

looks good and got possitive feedback from our QE testing this

Acked-by: Jiri Olsa <jolsa@kernel.org>

thanks,
jirka
