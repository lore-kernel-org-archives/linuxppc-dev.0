Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTM865ZSFzDqD2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 15:44:06 +1100 (AEDT)
Date: Thu, 23 Feb 2017 15:19:52 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: linuxppc-dev@ozlabs.org, benh@kernel.crashing.org, mpe@ellerman.id.au,
 ruscur@russell.cc, sam.bobroff@au1.ibm.com
Subject: Re: [RFC NO-MERGE 1/2] arch/powerpc/prom_init: Parse the command
 line before calling CAS
Message-ID: <20170223041952.GA6330@fergus.ozlabs.ibm.com>
References: <1487657171-17260-1-git-send-email-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1487657171-17260-1-git-send-email-sjitindarsingh@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 21, 2017 at 05:06:10PM +1100, Suraj Jitindar Singh wrote:
> CAS now requires the guest to tell the host whether it would like to use

Readers might not know what CAS is.  It would be kind to reword this
as "On POWER9, the hypervisor requires the guest ... hash or radix MMU
at the time of calling ibm,client-architecture-support (CAS)".

> a hash or radix mmu. It is possible to disable radix by passing
> "disable_radix" on the command line. The next patch will add support for
> the new CAS format, thus we need to parse the command line before calling
> CAS so we can correctly represent which mmu we would like to use.
> 
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

Reviewed-by: Paul Mackerras <paulus@ozlabs.org>
