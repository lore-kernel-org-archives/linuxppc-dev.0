Return-Path: <SRS0=aJRt=GL=goodmis.org=rostedt@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 405v100gJwzF1r3
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2018 02:31:48 +1100 (AEDT)
Date: Wed, 21 Mar 2018 11:31:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Paul Mackerras <paulus@ozlabs.org>, sathnaga@linux.vnet.ibm.com
Subject: Re: [PATCH v2 5/5] powerpc64/ftrace: Implement support for
 ftrace_regs_caller()
Message-ID: <20180321113142.7291ded1@gandalf.local.home>
In-Reply-To: <1521646126.5jxja0sxh5.naveen@linux.ibm.com>
References: <cover.1521627906.git.naveen.n.rao@linux.vnet.ibm.com>
 <764a63e7418b05185434fe660814ce762c93c7d0.1521627906.git.naveen.n.rao@linux.vnet.ibm.com>
 <20180321095912.212e0b0d@gandalf.local.home>
 <1521642624.97rikdhoqw.naveen@linux.ibm.com>
 <20180321112221.16cd9c3c@gandalf.local.home>
 <1521646126.5jxja0sxh5.naveen@linux.ibm.com>
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

On Wed, 21 Mar 2018 20:59:03 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> Thanks for the review!

You're welcome. Note, I did put "Acked-by" and not "Reviewed-by"
because my "Reviewed-by" is usually a bit more thorough than what I did
for your patches. That's because it's been a while since I have worked
on PPC and don't feel comfortable adding "Reviewed-by" for PPC code. :-/

-- Steve
