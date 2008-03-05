Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18382.12838.527446.325768@cargo.ozlabs.ibm.com>
Date: Wed, 5 Mar 2008 16:39:50 +1100
From: Paul Mackerras <paulus@samba.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] add strncmp to PowerPC
In-Reply-To: <d495403c2b5f700be085c965746cd211@kernel.crashing.org>
References: <1204301097.14759.6.camel@localhost.localdomain>
	<1204340690.15052.457.camel@pasglop>
	<18382.7074.69060.661720@cargo.ozlabs.ibm.com>
	<d495403c2b5f700be085c965746cd211@kernel.crashing.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Steven Rostedt <rostedt@goodmis.org>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool writes:

> Anyway, this asm code has bugs, as do both the current C version in the
> kernel, and the code I posted.  We need to do better :-)

The only bug I know of in the asm code is the behaviour when the count
is zero.  Do you know of any other?

Paul.
