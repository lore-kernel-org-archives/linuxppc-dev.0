Subject: Re: Disable cache on 74xx
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Brian Waite <waite@skycomputers.com>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <200302191552.01911.waite@skycomputers.com>
References: <200302191552.01911.waite@skycomputers.com>
Content-Type: text/plain
Message-Id: <1045688879.12534.80.camel@zion.wanadoo.fr>
Mime-Version: 1.0
Date: 19 Feb 2003 22:07:59 +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, 2003-02-19 at 21:52, Brian Waite wrote:
> Hi all,
> 	I am trying to hunt down a memory controller configuration problem and I have
> been asked to disable all caching so as to remove it from the equation. I can
> easl disable L2 but when I start ucking with the WIMG bits to set cache
> inhibit, The kernel panics with stack overflows. Does anyone know where or
> what I have to set to disable caching?

Hrm... set L2 and L3 off, then hack HID0 to disable L1 ?

Ben.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
