Return-Path: <SRS0=7aBp=2I=goodmis.org=rostedt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vX5WS0TmJzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Feb 2017 02:40:19 +1100 (AEDT)
Date: Mon, 27 Feb 2017 10:40:14 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3 2/2] powerpc: ftrace_64: split further based on
 -mprofile-kernel
Message-ID: <20170227104014.7b7dee0e@gandalf.local.home>
In-Reply-To: <378311b965ca33fe69b159f7609ff2eedfe3bc2f.1487702678.git.naveen.n.rao@linux.vnet.ibm.com>
References: <cover.1487702678.git.naveen.n.rao@linux.vnet.ibm.com>
 <378311b965ca33fe69b159f7609ff2eedfe3bc2f.1487702678.git.naveen.n.rao@linux.vnet.ibm.com>
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

On Wed, 22 Feb 2017 00:31:02 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Split ftrace_64.S further retaining the core ftrace 64-bit aspects
> in ftrace_64.S and moving ftrace_caller() and ftrace_graph_caller() into
> separate files based on -mprofile-kernel. The livepatch routines are all
> now contained within the mprofile file.

Why? I would think that it may be possible to share code if they stay
in the same file. I haven't had the chance to look deeply into the
current code, but there may be ways to make macros and consolidate
duplicate code like we did in x86.

-- Steve


> 
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>
