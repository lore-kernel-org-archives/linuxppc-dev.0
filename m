Date: Tue, 29 Jun 2004 10:19:33 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: [PATCH] OCP for MP10x
Message-ID: <20040629171933.GJ28128@smtp.west.cox.net>
References: <1088516489.20324.12.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1088516489.20324.12.camel@localhost>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, Jun 29, 2004 at 02:41:29PM +0100, Adrian Cox wrote:

> Attached is the latest version of my OCP patch for MPC107/8240/8245.
> This unifies some openpic setup code, and ensures that the OCP devices
> are only added to the bus on chip variants which have them.
>
> All interested parties seem happy, and this patch is necessary to
> provide a unified I2C driver for 85xx and 107/824x.
>
> Signed-off-by: Adrian Cox <adrian@humboldt.co.uk>

OK.  I'm going to fire this up on my LoPEC and then Sandpoint, and if
it's happy, I'll pass it along to akpm.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
