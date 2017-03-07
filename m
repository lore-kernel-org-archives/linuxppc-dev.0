Return-Path: <SRS0=nX4A=2Q=goodmis.org=rostedt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vd7vr73YYzDqLW
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Mar 2017 07:45:27 +1100 (AEDT)
Date: Tue, 7 Mar 2017 15:45:21 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ananth N
 Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>
Subject: Re: [PATCH v4 1/3] perf: probe: factor out the ftrace README scanning
Message-ID: <20170307154521.191d7e46@gandalf.local.home>
In-Reply-To: <e4ea4dcc09ac167cc47026e6db73ac67ca001772.1488475783.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1488475783.git.naveen.n.rao@linux.vnet.ibm.com>
 <e4ea4dcc09ac167cc47026e6db73ac67ca001772.1488475783.git.naveen.n.rao@linux.vnet.ibm.com>
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


FYI,

When creating new patch series, please start a new thread, and don't
post a patch as a reply to another patch. It gets easily lost that way.

-- Steve


On Thu,  2 Mar 2017 23:25:05 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Simplify and separate out the ftrace README scanning logic into a
> separate helper. This is used subsequently to scan for all patterns of
> interest and to cache the result.
> 
> Since we are only interested in availability of probe argument type x,
> we will only scan for that.
> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
> ---
