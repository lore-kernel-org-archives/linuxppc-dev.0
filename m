Return-Path: <rth@twiddle.net>
Received: from are.twiddle.net (are.twiddle.net [64.81.246.98])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DE17F679EA
	for <linuxppc-dev@ozlabs.org>; Thu, 11 May 2006 10:22:28 +1000 (EST)
Date: Wed, 10 May 2006 17:22:17 -0700
From: Richard Henderson <rth@twiddle.net>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC/PATCH] Make powerpc64 use __thread for per-cpu variables
Message-ID: <20060511002217.GA31481@twiddle.net>
References: <17505.26159.807484.477212@cargo.ozlabs.ibm.com>
	<20060510154702.GA28938@twiddle.net>
	<20060510.124003.04457042.davem@davemloft.net>
	<17506.21908.857189.645889@cargo.ozlabs.ibm.com>
	<49BB818F-DF88-43A3-8B6A-7F9F5C7A2C3C@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49BB818F-DF88-43A3-8B6A-7F9F5C7A2C3C@kernel.crashing.org>
Cc: linux-arch@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, "David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, May 11, 2006 at 01:17:50AM +0200, Segher Boessenkool wrote:
> Would an asm clobber of GPR13 in the schedule routines (or a wrapper
> for them, or whatever) work?

No.  The address is cse'd symbolically long before the r13
reference is exposed.


r~
