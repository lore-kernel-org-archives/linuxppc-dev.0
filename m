Date: Mon, 7 Jun 2004 20:28:26 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: newest "bk pull" of 8xx tree still builds a kernel that hangs
In-Reply-To: <20040608002527.GA14242@smtp.west.cox.net>
Message-ID: <Pine.LNX.4.58.0406072026220.15060@localhost.localdomain>
References: <Pine.LNX.4.58.0406071152260.14264@localhost.localdomain>
 <20040607200811.GD12823@smtp.west.cox.net> <Pine.LNX.4.58.0406071950460.3449@localhost.localdomain>
 <20040608002527.GA14242@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 7 Jun 2004, Tom Rini wrote:

...
> I haven't had time to look into this yet, in part because I just don't
> know how well to trust my h/w, but to get SMC1 console working (RPX
> Lite) I need to enable both SCC1 and SMC1.  For your board, I would
> recommend enabling all of the consoles.

ok, i just turned them all on, it's compiling as we speak.  i'll let you
know what happens.  my .config file now looks like (in part):

...
CONFIG_VT=y
CONFIG_VT_CONSOLE=y
CONFIG_HW_CONSOLE=y
...
CONFIG_SERIAL_8250=y
CONFIG_SERIAL_8250_CONSOLE=y
CONFIG_SERIAL_8250_NR_UARTS=4
CONFIG_SERIAL_8250_EXTENDED=y
...
CONFIG_SERIAL_CORE=y
CONFIG_SERIAL_CORE_CONSOLE=y
CONFIG_SERIAL_CPM=y
CONFIG_SERIAL_CPM_CONSOLE=y
CONFIG_SERIAL_CPM_SCC1=y
CONFIG_SERIAL_CPM_SCC2=y
CONFIG_SERIAL_CPM_SCC3=y
CONFIG_SERIAL_CPM_SCC4=y
CONFIG_SERIAL_CPM_SMC1=y
CONFIG_SERIAL_CPM_SMC2=y
CONFIG_UNIX98_PTYS=y
...

i'm pretty sure there's not much more i can turn on related to this. :-)

rday



** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
