Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lJsP4GQ8zDqBx
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Aug 2018 01:51:18 +1000 (AEST)
Date: Tue, 7 Aug 2018 10:50:54 -0500
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Breno Leitao <leitao@debian.org>
Cc: linuxppc-dev@lists.ozlabs.org, mikey@neuling.org
Subject: Re: [PATCH v2] powerpc/tm: Print 64-bits MSR
Message-ID: <20180807155054.GF31204@gate.crashing.org>
References: <5b85006b6695bd94f4818357be607036e9df8696.camel@neuling.org>
 <1533648900-7933-1-git-send-email-leitao@debian.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1533648900-7933-1-git-send-email-leitao@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 07, 2018 at 10:35:00AM -0300, Breno Leitao wrote:
> On a kernel TM Bad thing program exception, the Machine State Register
> (MSR) is not being properly displayed. The exception code dumps a 32-bits
> value but MSR is a 64 bits register for all platforms that have HTM
> enabled.
> 
> This patch dumps the MSR value as a 64-bits value instead of 32 bits. In
> order to do so, the 'reason' variable could not be used, since it trimmed
> MSR to 32-bits (int).

So maybe reason should be a long instead of an int?


Segher
