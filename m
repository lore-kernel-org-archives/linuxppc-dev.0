Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 76ECD1A09AA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Jul 2015 23:41:26 +1000 (AEST)
Date: Mon, 20 Jul 2015 08:41:03 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Ananth N Mavinakayanahalli <ananth@in.ibm.com>
Cc: masami.hiramatsu.pt@hitachi.com, mpe@ellerman.id.au, mingo@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3 2/2] kprobes: Mark OPTPROBES na for powerpc
Message-ID: <20150720134103.GA9691@gate.crashing.org>
References: <20150720105349.24801.64387.stgit@thinktux.in.ibm.com>
 <20150720105417.24801.66440.stgit@thinktux.in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150720105417.24801.66440.stgit@thinktux.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 20, 2015 at 04:24:22PM +0530, Ananth N Mavinakayanahalli wrote:
> There is a potential gain to be had with a direct
> jump instead of a breakpoint, but the caveats need to be traded off
> with the complexity it brings in.
> 
> For now, mark OPTPROBES na for powerpc.

If we haven't yet investigated whether this feature is something beneficial
to the powerpc kernel, it should just stay as TODO, not be marked as n/a.


Segher
