Return-Path: <SRS0=nX4A=2Q=goodmis.org=rostedt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vd7y96bsyzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Mar 2017 07:47:29 +1100 (AEDT)
Date: Tue, 7 Mar 2017 15:47:24 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Ananth N
 Mavinakayanahalli <ananth@linux.vnet.ibm.com>, Michael Ellerman
 <mpe@ellerman.id.au>
Subject: Re: [RESEND PATCH 1/6] trace/kprobes: fix check for kretprobe
 offset within function entry
Message-ID: <20170307154724.132feb31@gandalf.local.home>
In-Reply-To: <1bcc13b27c8338f7b12c160ac049029e2007cc99.1488881988.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1488881988.git.naveen.n.rao@linux.vnet.ibm.com>
 <1bcc13b27c8338f7b12c160ac049029e2007cc99.1488881988.git.naveen.n.rao@linux.vnet.ibm.com>
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


Please start a new thread. When sending patches as replies to other
patch threads, especially this deep into the thread, they will most
likely get ignored.

-- Steve
