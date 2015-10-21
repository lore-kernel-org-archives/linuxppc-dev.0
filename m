Return-Path: <segher@gate.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9A7361A03E1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2015 03:48:26 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B01A6140DB4
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Oct 2015 03:48:25 +1100 (AEDT)
Date: Wed, 21 Oct 2015 11:47:46 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, geoff@infradead.org
Subject: Re: [PATCH] powerpc/ps3: Quieten the build when building ps3
Message-ID: <20151021164746.GA8157@gate.crashing.org>
References: <1445230402-18087-1-git-send-email-mpe@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1445230402-18087-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 19, 2015 at 03:53:22PM +1100, Michael Ellerman wrote:
> The boot wrapper uses dd when building for ps3, which annoyingly tells
> us in great detail what it's doing, eg:
> 
>   512+0 records in
>   512+0 records out
>   512 bytes (512 B) copied, 0.000802129 s, 638 kB/s
>   512+0 records in
>   512+0 records out
>   512 bytes (512 B) copied, 0.000745101 s, 687 kB/s
> 
> Also annoyingly, there is no "quiet" flag to dd, so our only option is
> to grab all the output from dd, and iff there is an error print it out.

"status=none", but that's not POSIX it seems.


Segher
