Return-Path: <segher@gate.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tdVQQ5v2jzDvMX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Dec 2016 06:39:26 +1100 (AEDT)
Date: Tue, 13 Dec 2016 13:15:14 -0600
From: Segher Boessenkool <segher@kernel.crashing.org>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Scott Wood <oss@buserror.net>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Arnaldo Carvalho de Melo <acme@kernel.org>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 1/2] powerpc/32: Unset MSR RI in exception epilogs
Message-ID: <20161213191514.GJ30845@gate.crashing.org>
References: <cover.1481652710.git.christophe.leroy@c-s.fr>
 <e6292c23163fac0865def3a385ff01d1497b005b.1481652710.git.christophe.leroy@c-s.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <e6292c23163fac0865def3a385ff01d1497b005b.1481652710.git.christophe.leroy@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 13, 2016 at 07:19:41PM +0100, Christophe Leroy wrote:
> At exception prologs, once SRR0 and SRR1 have been saved, MSR RI is
> set to mark the interrupt as recoverable.
> 
> MSR RI has to be unset before writing into SRR0 and SRR1 at exception
> epilogs.

Why?  What goes wrong without this?  Etc.


Segher
