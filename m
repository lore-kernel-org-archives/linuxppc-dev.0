Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20060619201121.GC4845@pb15.lixom.net>
References: <20060619200811.GA15524@mag.az.mvista.com>
	<20060619201121.GC4845@pb15.lixom.net>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <92B1CE9B-81D2-4943-9B6A-68459407688A@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] mpic: add support for serial mode interrupts
Date: Tue, 20 Jun 2006 00:35:26 +0200
To: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> Can you define some constants so others can see just what the bits  
> mean
> without digging up documentation, instead of just doing magic numbers?

[my favourite argument :-) ]

You'll have to read the documentation to properly understand what
the bit patterns mean anyway.  And if you use symbolic names, you
only add another step: hunting through header files.

> MPIC_GREG_GLOBAL_CONF_0 already does so; you can copy the style from
> there.

...but yeah, definitely, mixing styles is at least as bad.


Segher
