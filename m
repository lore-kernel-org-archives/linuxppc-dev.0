Date: Wed, 3 Jul 2002 16:42:15 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: duey <jduey@ccc-dcs.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Walnut config in kernel tree
Message-ID: <20020703234215.GB697@opus.bloom.county>
References: <20020704001909.69DBF38D22@server.weathercom.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020704001909.69DBF38D22@server.weathercom.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Jul 03, 2002 at 06:01:45PM +0000, duey wrote:

> Has the make target to config the kernel tree for the walnut board changed?
> I just cloned the latest tree from the mvista mirror and when I did a 'make
> walnut_config' I got a 'no rule to make target' error message.

Did you do a 'bk -r get -q' first?  I'm not sure if the target will work
if arch/ppc/configs/<name>_defconfig isn't checked out.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
