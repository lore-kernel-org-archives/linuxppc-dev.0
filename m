Date: Mon, 17 Sep 2001 07:32:34 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Claire Troussier <troussier@digigram.com>
Cc: Matthew Locke <mlocke@mvista.com>,
	"linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problems with Sandpoint and IDE access
Message-ID: <20010917073234.H14279@cpe-24-221-152-185.az.sprintbbd.net>
References: <3BA21822.B39B3B0A@digigram.com> <3BA231CD.8020600@mvista.com> <3BA5A615.19B31A3F@digigram.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BA5A615.19B31A3F@digigram.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Sep 17, 2001 at 09:28:21AM +0200, Claire Troussier wrote:

> It already exists with major 3 and minor 0

Did you compile in the IDE disk driver too?  Do a cat /proc/ide/drivers

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
