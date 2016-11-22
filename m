Return-Path: <rostedt@goodmis.org>
Received: from smtprelay.hostedemail.com (smtprelay0067.hostedemail.com
 [216.40.44.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tNX2t343gzDsxp
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Nov 2016 04:07:33 +1100 (AEDT)
Date: Tue, 22 Nov 2016 12:07:26 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Torsten Duwe <duwe@lst.de>
Subject: Re: [PATCH v2] powerpc: split ftrace bits into a separate file
Message-ID: <20161122120726.3560bd3a@gandalf.local.home>
In-Reply-To: <20161122163439.524-1-naveen.n.rao@linux.vnet.ibm.com>
References: <20161122163439.524-1-naveen.n.rao@linux.vnet.ibm.com>
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

On Tue, 22 Nov 2016 22:04:39 +0530
"Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:

> entry_*.S now includes a lot more than just kernel entry/exit code. As a
> first step at cleaning this up, let's split out the ftrace bits into
> separate files.
> 
> No functional changes.
> 
> Suggested-by: Michael Ellerman <mpe@ellerman.id.au>
> Signed-off-by: Naveen N. Rao <naveen.n.rao@linux.vnet.ibm.com>

Looks good to me.

Acked-by: Steven Rostedt <rostedt@goodmis.org>

-- Steve
