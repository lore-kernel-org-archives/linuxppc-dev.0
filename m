Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH] mpic: add support for serial mode interrupts
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <92B1CE9B-81D2-4943-9B6A-68459407688A@kernel.crashing.org>
References: <20060619200811.GA15524@mag.az.mvista.com>
	<20060619201121.GC4845@pb15.lixom.net>
	<92B1CE9B-81D2-4943-9B6A-68459407688A@kernel.crashing.org>
Content-Type: text/plain
Date: Wed, 21 Jun 2006 11:12:36 +1000
Message-Id: <1150852356.12507.32.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2006-06-20 at 00:35 +0200, Segher Boessenkool wrote:
> > Can you define some constants so others can see just what the bits  
> > mean
> > without digging up documentation, instead of just doing magic numbers?
> 
> [my favourite argument :-) ]
> 
> You'll have to read the documentation to properly understand what
> the bit patterns mean anyway.  And if you use symbolic names, you
> only add another step: hunting through header files.

Sure, that's why we should remove every symbolic constant in every
driver anywhere in the kernel right ? Sure would help.

Ben.
