Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3D9A31A0259
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Oct 2015 13:10:52 +1100 (AEDT)
Message-ID: <1444961451.28419.0.camel@ellerman.id.au>
Subject: Re: [PATCH] PPC: fix LOGMPP instruction opcode and inline asm
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stewart Smith <stewart@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, thuth@redhat.com, stable@vger.kernel.org,
 paulus@samba.org, dgibson@redhat.com, jstancek@redhat.com
Date: Fri, 16 Oct 2015 13:10:51 +1100
In-Reply-To: <1444958435-18808-1-git-send-email-stewart@linux.vnet.ibm.com>
References: <1444958435-18808-1-git-send-email-stewart@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-10-16 at 12:20 +1100, Stewart Smith wrote:
> Back in 9678cda when we started using the Micro Partition Prefetch Engine
> in POWER8 for KVM, there were two mistakes introduced from the original
> patch used for investigation and microbenchmarks.
> 
> One mistake was that the opcode was constructed incorrectly, putting
> the register in the wrong field in the opcode, meaning that we were
> asking the chip to read the memory address from some other register than
> what we intended - probably r0.

Where is the logmpp instruction documented?

cheers
