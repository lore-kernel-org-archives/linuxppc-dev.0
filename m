Date: Thu, 8 Jul 2004 18:02:28 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Robert P. J. Day" <rpjday@mindspring.com>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: make menuconfig error in latest "bk pull"
Message-ID: <20040709010228.GL23135@smtp.west.cox.net>
References: <Pine.LNX.4.60.0407061615230.21433@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.60.0407061615230.21433@localhost.localdomain>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jul 06, 2004 at 04:16:52PM -0400, Robert P. J. Day wrote:

>
>   i'm probably way behind the curve here, but:
>
> $ make ARCH=ppc menuconfig
> scripts/kconfig/mconf arch/ppc/Kconfig
> drivers/net/Kconfig:201: can't open file "drivers/net/ibm_ocp/Kconfig"
> make[1]: *** [menuconfig] Error 1
> make: *** [menuconfig] Error 2
> $

This, and one other place, were missed in the removal of the old IBM OCP
enet driver.  I'll be fixing both shortly (both are local to linuxppc-2.5).

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
