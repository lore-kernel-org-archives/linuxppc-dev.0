Return-Path: <phdm@macqel.be>
Received: from smtp2.macqel.be (smtp2.macqel.be [194.78.208.39])
 by ozlabs.org (Postfix) with ESMTP id 1C6A52C0374
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Mar 2013 17:08:46 +1100 (EST)
Date: Wed, 6 Mar 2013 07:00:58 +0100
From: Philippe De Muyter <phdm@macqel.be>
To: Michael Neuling <mikey@neuling.org>
Subject: 3.9-rc1 powerpc ptrace.c: 'brk.len' is used uninitialized
Message-ID: <20130306060058.GA3106@frolo.macqel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello Michael,

bisect tells me that since your commit 9422de3e953d0e60eb95f5430a9dd803eec1c6d7 
"powerpc: Hardware breakpoints rewrite to handle non DABR breakpoint registers",
compiling linux fails with :

  cc1: warnings being treated as errors
  arch/powerpc/kernel/ptrace.c: In function 'arch_ptrace':
  arch/powerpc/kernel/ptrace.c:1450: warning: 'brk.len' is used uninitialized in this function
  arch/powerpc/kernel/ptrace.c:1352: note: 'brk.len' was declared here

could you look at that ?

Thanks

Philippe
